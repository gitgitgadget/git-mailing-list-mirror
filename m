X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-clone: lose the artificial "first" fetch refspec
Date: Sat, 16 Dec 2006 12:51:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612161240120.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <7vfybgjj7k.fsf@assigned-by-dhcp.cox.net>
 <7v3b7gji73.fsf@assigned-by-dhcp.cox.net> <7vvekci3ds.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 16 Dec 2006 11:52:08 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vvekci3ds.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34608>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvY5F-0004Ao-Ai for gcvg-git@gmane.org; Sat, 16 Dec
 2006 12:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753647AbWLPLwA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 06:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965429AbWLPLwA
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 06:52:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:58889 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1753644AbWLPLv7
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 06:51:59 -0500
Received: (qmail invoked by alias); 16 Dec 2006 11:51:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp045) with SMTP; 16 Dec 2006 12:51:58 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Sat, 16 Dec 2006, Junio C Hamano wrote:

>  With the recent flurry of UI updates, I think it is sane to do
>  that before v1.5.0; opinions?

Answering to all of your recent patches in this direction: I like it.

Originally, I thought that this would require more from me: I often 
synchronize my git repository (including topic branches) between different 
machines back and forth, via usb stick, and two different central 
machines. I use the script I sent in this mail:

http://article.gmane.org/gmane.comp.version-control.git/6956/

However, I just realized that I will not need the script anymore, what 
with the recent addition of wildcards to remote.<branch>.fetch. Good job!

Ciao,
Dscho
