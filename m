From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 5/5] Use start_comand() in builtin-fetch-pack.c instead of explicit fork/exec.
Date: Thu, 4 Oct 2007 22:11:58 +0200
Message-ID: <200710042211.58363.johannes.sixt@telecom.at>
References: <200709302340.17644.johannes.sixt@telecom.at> <7v8x6jb6of.fsf@gitster.siamese.dyndns.org> <4704B0EF.3040207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 22:13:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdX3j-0003ca-Vu
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 22:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755796AbXJDUMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 16:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755484AbXJDUME
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 16:12:04 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:50011 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242AbXJDUMB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 16:12:01 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 87BBF36059;
	Thu,  4 Oct 2007 22:11:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 1E16159D4F;
	Thu,  4 Oct 2007 22:11:59 +0200 (CEST)
User-Agent: KMail/1.9.3
In-Reply-To: <4704B0EF.3040207@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59998>

On Thursday 04 October 2007 11:22, Johannes Sixt wrote:
> Junio C Hamano schrieb:
> > I think Daniel and Shawn's git-fetch-in-C should graduate
> > 'master' before this series.  If you can re-send the series
> > rebased on 2b5a06edca8f7237aad6464b349b79772024d2a2 (Restore
> > default verbosity for http fetches.), it would be much
> > appreciated.
>
> Sure, will do this evening.

I've difficulties with this rebase: 2b5a06 does not compile for me due to 
7155b727c9 (Introduce remove_dir_recursively()), which needs strbuf, but that 
is not merged into this branch. I can rebase on its parent (bundle transport: 
fix an alloc_ref() call) or 17df81ff (Merge branch 'db/fetch-pack' into 
next). I'd prefer the latter since it also has strbuf.

-- Hannes
