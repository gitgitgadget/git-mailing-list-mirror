X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/5] fetch-pack: Do not fetch tags for shallow clones.
Date: Sat, 25 Nov 2006 20:01:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611251958110.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87k61kubya.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 25 Nov 2006 19:01:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <87k61kubya.fsf@wine.dyndns.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32299>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go2mU-0001TQ-1r for gcvg-git@gmane.org; Sat, 25 Nov
 2006 20:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967108AbWKYTBh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 14:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967111AbWKYTBh
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 14:01:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:48619 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S967108AbWKYTBg (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 14:01:36 -0500
Received: (qmail invoked by alias); 25 Nov 2006 19:01:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp027) with SMTP; 25 Nov 2006 20:01:35 +0100
To: Alexandre Julliard <julliard@winehq.org>
Sender: git-owner@vger.kernel.org

Hi,

the other 4 patches look good to me (fixing a few typos/thinkos). However, 
I think there must be a way to fetch tags for clones, when it is possible 
for fetches. Especially since fetch gets closer to including the features 
needed for "clone" (regexes for remote names, storing packs, ...)

Ciao,
Dscho

P.S.: I just realized that send-pack and receive-pack are not at all aware 
of shallow repos. Maybe both should check for a shallow repo, and die() on 
it?

