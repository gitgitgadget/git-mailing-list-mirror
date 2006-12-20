X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-merge-recursive segmentation error
Date: Wed, 20 Dec 2006 03:33:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612200332420.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0612191709320.6766@woody.osdl.org>
 <929899.78332.qm@web31809.mail.mud.yahoo.com> <7vtzzrmhhd.fsf@assigned-by-dhcp.cox.net>
 <7vpsafmh89.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 20 Dec 2006 02:33:43 +0000 (UTC)
Cc: ltuikov@yahoo.com, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vpsafmh89.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34898>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwrH0-0001Ia-0b for gcvg-git@gmane.org; Wed, 20 Dec
 2006 03:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964788AbWLTCdf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 21:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWLTCdf
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 21:33:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:35478 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S964788AbWLTCdf
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 21:33:35 -0500
Received: (qmail invoked by alias); 20 Dec 2006 02:33:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp034) with SMTP; 20 Dec 2006 03:33:33 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 19 Dec 2006, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > Luben Tuikov <ltuikov@yahoo.com> writes:
> >
> >> I also ran git-bisect twice over two well known but overlapping
> >> good-bad regions and I get the same commit as being the culprit.
> >> It seems to be commit 1510fea781cb0517eeba8c378964f7bc4f9577ab.
> >>
> >>     Luben
> >
> > Ooooooops.
> 
> 1510fe is buggy and it is my fault.

You hand munging should not have led to any segmentation fault. It would 
be sooo nice to have the test case.

Ciao,
