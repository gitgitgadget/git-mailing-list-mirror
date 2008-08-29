From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] rev-list: fix --reverse interaction with --parents
Date: Fri, 29 Aug 2008 21:53:59 +0200
Message-ID: <200808292153.59376.johannes.sixt@telecom.at>
References: <48AD9786.80707@viscovery.net> <1220037518-11219-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 29 21:55:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZA4D-0002ir-4B
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 21:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbYH2TyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 15:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbYH2TyF
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 15:54:05 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:51736 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189AbYH2TyE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 15:54:04 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 4B9CC13A3A1;
	Fri, 29 Aug 2008 21:54:00 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 78B4D1D215;
	Fri, 29 Aug 2008 21:53:59 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1220037518-11219-1-git-send-email-trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94319>

On Freitag, 29. August 2008, Thomas Rast wrote:
> Johannes Sixt wrote:
> > This command does not give the expected result: It reports *two* initial
> > commits and one merge; in particular, commit X is reported as initial
> > commit.
> >
> > $ git rev-list --parents --reverse --full-history master -- P2
>
> The good news is: the patch really does fix your issue.  It also fixes
> the test case (which uses the history from the diagram above).  And it
> passes the test suite.

Thanks for picking up the topic and helping out. It does indeed work with my 
example.

I let others comment whether this patch is good. I've no clue how the revision 
walker machinery works.

-- Hannes
