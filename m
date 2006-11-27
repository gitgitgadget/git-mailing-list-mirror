X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Idea for rebase strategy
Date: Tue, 28 Nov 2006 00:40:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611280037200.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0611270108160.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfyc5l24t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 27 Nov 2006 23:40:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vfyc5l24t.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32462>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goq5H-0001Po-F9 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 00:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758620AbWK0XkU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 18:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758619AbWK0XkU
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 18:40:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:55216 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1758620AbWK0XkT (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 18:40:19 -0500
Received: (qmail invoked by alias); 27 Nov 2006 23:40:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp036) with SMTP; 28 Nov 2006 00:40:17 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 27 Nov 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > an idea hit me today: maybe we can make rebase work nicely with merges 
> > after all. We could record the original branch point and the new branch 
> > point for rebases.
> 
> [...]
> 
> If we have a reliable ref-log for 'topic' that should be trivial
> to do.

But of course! Yet another reason to introduce core.disableRefLog, and 
turn it on by default...

The graceful merging of a rebased branch indeed depends on the local 
history, i.e. what is stored in the reflog.

Ciao,
Dscho
