X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-merge-recursive-old?
Date: Wed, 29 Nov 2006 16:07:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611291606410.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <868xhuxpun.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 15:08:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <868xhuxpun.fsf@blue.stonehenge.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32642>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpR2O-0005dj-9T for gcvg-git@gmane.org; Wed, 29 Nov
 2006 16:07:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967396AbWK2PHs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 10:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967397AbWK2PHs
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 10:07:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:56513 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S967396AbWK2PHr (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 10:07:47 -0500
Received: (qmail invoked by alias); 29 Nov 2006 15:07:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp039) with SMTP; 29 Nov 2006 16:07:45 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 29 Nov 2006, Randal L. Schwartz wrote:

> I build daily, and apaprently I built git-merge-recursive-old,
> but it's not in .gitignore.  Needs to be added, no?

To the contrary. You need to remove it: v1.4.4-g7cdbff1 removed it, but 
you still have the generated file...

Hth,
Dscho
