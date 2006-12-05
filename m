X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: using xdl_merge(), was Re: Resolving conflicts
Date: Tue, 5 Dec 2006 19:53:09 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612051949290.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <456FD461.4080002@saville.com> <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
 <456FDF24.1070001@saville.com> <Pine.LNX.4.64.0612012018490.3476@woody.osdl.org>
 <7vejri20mf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612021131140.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <4575B32F.5060108@ramsay1.demon.co.uk> <Pine.LNX.4.64.0612051023460.3542@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 18:53:32 +0000 (UTC)
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0612051023460.3542@woody.osdl.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33365>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrfPq-0007nu-KL for gcvg-git@gmane.org; Tue, 05 Dec
 2006 19:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968628AbWLESxP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 13:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968629AbWLESxP
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 13:53:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:60531 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S968628AbWLESxO
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 13:53:14 -0500
Received: (qmail invoked by alias); 05 Dec 2006 18:53:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp031) with SMTP; 05 Dec 2006 19:53:10 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 5 Dec 2006, Linus Torvalds wrote:

>  - take every single merge in git (or the kernel, if you want even more)

I tried that already. Only to find that the first merge I tested showed 
one change between RCS merge and xdl_merge(): xdl_merge() does not yet 
take context into account, so these two diffs

@@ bla
 Ten
+weary
 footsore
+wanderers
 all
 in
 a

and

@@ blub
 Ten
+weird
 footsore
 all
 in
 a

will conflict only for the weary/weird lines, _not_ for wanderers.

Besides, my recent patch series was gained exactly by that test. Though I 
did not extend that test to the Linux repo, and I am by no means finished 
with the git one.

Ciao,
