X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: merge-recursive, was Re: What's in git.git
Date: Thu, 26 Oct 2006 12:56:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610261252480.3286@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0610261114520.3286@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3b9bpgvs.fsf@assigned-by-dhcp.cox.net> <7v7iyno0qk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 26 Oct 2006 10:56:47 +0000 (UTC)
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v7iyno0qk.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30186>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd2uW-0007oT-2S for gcvg-git@gmane.org; Thu, 26 Oct
 2006 12:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423248AbWJZK43 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 06:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423249AbWJZK43
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 06:56:29 -0400
Received: from mail.gmx.de ([213.165.64.20]:45523 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1423248AbWJZK42 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 06:56:28 -0400
Received: (qmail invoked by alias); 26 Oct 2006 10:56:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp023) with SMTP; 26 Oct 2006 12:56:26 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 26 Oct 2006, Junio C Hamano wrote:

> This is a prime demonstration that it makes more sense to keep script 
> version until we flush out configurability issues.

Okay, I agree.

BTW before somebody asks: No, I did _not_ implement the .mailmap 
functionality. But once things are flushed out with the configuration, and 
_if_ the builtin is not undesired, I will implement it.

Since Linux really is a special guest, maybe we'd want to integrate the 
dot3 thing in .mailmap, and override the Linux defaults _only_ if .mailmap 
exists. Thoughts?

Ciao,
Dscho
