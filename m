X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 13:47:15 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611301345170.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45357CC3.4040507@utoronto.ca> <20061021130111.GL75501@over-yonder.net>
 <453F2FF8.2080903@op5.se> <200610251146.06116.jnareb@gmail.com>
 <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
 <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
 <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
 <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
 <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net>
 <456ED047.3030102@ableton.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 12:47:33 +0000 (UTC)
Cc: Joseph Wakeling <joseph.wakeling@webdrake.net>,
	git@vger.kernel.org, bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <456ED047.3030102@ableton.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32736>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GplK2-0000VQ-R7 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 13:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965753AbWK3MrW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 07:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936305AbWK3MrV
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 07:47:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:6123 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S936336AbWK3MrT (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 07:47:19 -0500
Received: (qmail invoked by alias); 30 Nov 2006 12:47:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp039) with SMTP; 30 Nov 2006 13:47:17 +0100
To: Nicholas Allen <allen@ableton.com>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 30 Nov 2006, Nicholas Allen wrote:

> Does this mean if I have, for example, a large C++ file with a bunch of 
> methods in it and I move one of the methods from the bottom of the file 
> to the top and in another branch someone makes a change to that method 
> that when I merge their changes git will merge their changes into the 
> method at the top of the file where I have moved it?

As for now, no, it does not. This is a shortcoming of RCS merge which does 
the heavy-lifting.

Having said that, stay tuned for new developments: the functionality of 
merge is being integrated in git. This opens the door to make use of the 
code tracking support in git, to do exactly what you just proposed.

Ciao,
Dscho
