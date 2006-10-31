X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] upload-pack: no longer call rev-list
Date: Tue, 31 Oct 2006 11:02:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0610311100170.26682@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0610302008320.26682@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1woprrwi.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0610311054500.26682@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 31 Oct 2006 10:02:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0610311054500.26682@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30578>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeqRq-0005Ib-3z for gcvg-git@gmane.org; Tue, 31 Oct
 2006 11:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423063AbWJaKCT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 05:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423064AbWJaKCT
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 05:02:19 -0500
Received: from mail.gmx.de ([213.165.64.20]:54403 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1423063AbWJaKCS (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 05:02:18 -0500
Received: (qmail invoked by alias); 31 Oct 2006 10:02:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp033) with SMTP; 31 Oct 2006 11:02:17 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 31 Oct 2006, Johannes Schindelin wrote:

> Except show_commit() should not show "commit " in front of each line. 
> So, another parameter?

Sorry, that was not clear. When using traverse_commit_list() from 
upload-pack, the "commit " prefix is _not_ shown. With every other 
user of travsere_commit_list(), it is.

Ciao,
Dscho
