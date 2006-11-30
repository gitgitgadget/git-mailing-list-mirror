X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 23:45:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611302338190.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45357CC3.4040507@utoronto.ca> <456E8147.9070304@gmx.net>
 <fcaeb9bf0611300101s51a53b75lc7e771b067ba6e33@mail.gmail.com>
 <200611300930.33537.alan@chandlerfamily.org.uk> <ekm8ig$usu$1@sea.gmane.org>
 <7vbqmpjlsz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 22:45:41 +0000 (UTC)
Cc: jnareb@gmail.com, Alan Chandler <alan@chandlerfamily.org.uk>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vbqmpjlsz.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32823>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpuel-0000Jr-1e for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031602AbWK3WpY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031603AbWK3WpY
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:45:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:28361 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1031602AbWK3WpX (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 17:45:23 -0500
Received: (qmail invoked by alias); 30 Nov 2006 22:45:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp030) with SMTP; 30 Nov 2006 23:45:21 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 30 Nov 2006, Junio C Hamano wrote:

> Somehow we ended up introducing that twisted semantics and that was 
> where --only came from, which unfortunately later became the default 
> (and I already said that I realize this was a big mistake).

If you are talking about "git commit file1 file2" ignoring the current 
index, and building a new index just updating file1 and file2 from the 
working directory, I disagree that it was a big mistake.

Actually, I was very happy to get that change (IIRC it was me requesting 
it, so blame me), because I now can say: just specify exactly what you 
want to commit *1*.

If you want to commit just file2 (even if you added file1, but did not 
commit it yet) do "git commit file2". If you want to commit all changes, 
either pass the names of all modified files, or "-a". IMHO this satisfies 
the principle of least surprise.

Ciao,
Dscho

Footnote 1: Of course, you can use commit in more ways. But this is 
sufficient to get people started.
