X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Teach git-branch howto rename a branch
Date: Mon, 27 Nov 2006 00:56:34 +0100
Message-ID: <200611270056.35053.Josef.Weidendorfer@gmx.de>
References: <1164409429445-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 00:04:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <1164409429445-git-send-email-hjemli@gmail.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32371>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoTyR-0006sV-2f for gcvg-git@gmane.org; Mon, 27 Nov
 2006 01:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755277AbWK0AD3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 19:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755310AbWK0AD3
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 19:03:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:21474 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1755277AbWK0AD2 (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 19:03:28 -0500
Received: (qmail invoked by alias); 26 Nov 2006 23:56:36 -0000
Received: from p5496967F.dip0.t-ipconnect.de (EHLO noname) [84.150.150.127]
 by mail.gmx.net (mp040) with SMTP; 27 Nov 2006 00:56:36 +0100
To: Lars Hjemli <hjemli@gmail.com>
Sender: git-owner@vger.kernel.org

On Saturday 25 November 2006 00:03, Lars Hjemli wrote:
> This adds a '--rename' option to git branch. If specified, branch
> creation becomes branch renaming.

This probably also should rename all config keys
 branch.<oldname>.*
into
 branch.<newname>.*

