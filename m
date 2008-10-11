From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC PATCH] describe: Make --tags and --all match lightweight
 tags	more often
Date: Sun, 12 Oct 2008 00:47:20 +0200
Message-ID: <48F12CF8.505@op5.se>
References: <20081010165952.GI8203@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Erez Zilber <erezzi.list@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 12 00:49:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KonGt-00017Y-5Y
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 00:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbYJKWrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 18:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754016AbYJKWrv
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 18:47:51 -0400
Received: from mail.op5.se ([193.201.96.20]:41332 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbYJKWru (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 18:47:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EF8A11B8005F;
	Sun, 12 Oct 2008 00:40:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.712
X-Spam-Level: 
X-Spam-Status: No, score=-2.712 tagged_above=-10 required=6.6
	tests=[AWL=-0.213, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CvpsMG-HGo2p; Sun, 12 Oct 2008 00:39:59 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id CDEBF1B80048;
	Sun, 12 Oct 2008 00:39:53 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081010165952.GI8203@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97995>

Shawn O. Pearce wrote:
> If the caller supplies --tags they want the lightweight, unannotated
> tags to be searched for a match.  If a lightweight tag is closer
> in the history, it should be matched, even if an annotated tag is
> reachable further back in the commit chain.
> 
> The same applies with --all when matching any other type of ref.
> 

In 99% of the cases, "--all" will then give back the currently
checked out branch unless a revision is specified, right?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
