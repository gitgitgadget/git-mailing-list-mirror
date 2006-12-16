X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid accessing a slow working copy during diffcore
 operations.
Date: Sat, 16 Dec 2006 12:54:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612161253080.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061214111557.GA24297@spearce.org> <7vpsakl6mu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 16 Dec 2006 11:55:03 +0000 (UTC)
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vpsakl6mu.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34609>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvY84-0004ND-VT for gcvg-git@gmane.org; Sat, 16 Dec
 2006 12:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965429AbWLPLy5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 06:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965432AbWLPLy5
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 06:54:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:46906 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S965429AbWLPLy5
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 06:54:57 -0500
Received: (qmail invoked by alias); 16 Dec 2006 11:54:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp030) with SMTP; 16 Dec 2006 12:54:55 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Fri, 15 Dec 2006, Junio C Hamano wrote:

> Also I'd prefer doing this without #ifdef;
> 
>         if (defined(NO_FAST_WORKING_DIRECTORY) &&
>         	!want_file && has_sha1_pack(sha1, NULL))
> 		return 0;

Are you sure? AFAIU it is an OS dependent problem, so it should not be 
configurable at runtime anyway.

Ciao,
Dscho
