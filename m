X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] (experimental) per-topic shortlog.
Date: Tue, 28 Nov 2006 00:46:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611280040480.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v8xhxsopp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611261652520.30076@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 27 Nov 2006 23:46:42 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0611261652520.30076@woody.osdl.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32463>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoqBL-0002q4-Q7 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 00:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758624AbWK0Xqh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 18:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758623AbWK0Xqh
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 18:46:37 -0500
Received: from mail.gmx.de ([213.165.64.20]:38337 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1758622AbWK0Xqg (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 18:46:36 -0500
Received: (qmail invoked by alias); 27 Nov 2006 23:46:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp031) with SMTP; 28 Nov 2006 00:46:35 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Hi,

On Sun, 26 Nov 2006, Linus Torvalds wrote:

> Of course, such a thing done well would probably be worthy of a doctoral 
> thesis or something. Maybe somebody on this list who is into bayesian 
> clustering and doesn't have a thesis subject...

Funny you should mention it... I recently was exposed to Formal Concept 
Analysis, and immediately thought that this would have applications in the 
visualization of source codes' histories.

Maybe there is a way to apply Bayesian Inference to determine a subset 
which bears the highest information / subset size ratio.

As for reducing the number of lines in the shortlog: taking myself as an 
example, I often touch the same code several times, just to fix bugs. So, 
if the same code was touched several times, just take the first oneline, 
and add "(+fixes)". Of course, this is more like a wedding between 
shortlog and annotate, and likely to be slow.

Ciao,
Dscho
