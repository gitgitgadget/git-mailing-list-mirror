X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-diff opens too many files?
Date: Mon, 20 Nov 2006 16:20:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611201620070.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <fcaeb9bf0611200212s6ddb0518k24f85223acfed08b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 20 Nov 2006 15:21:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <fcaeb9bf0611200212s6ddb0518k24f85223acfed08b@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31916>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmAx6-0005YG-SB for gcvg-git@gmane.org; Mon, 20 Nov
 2006 16:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965889AbWKTPUs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 10:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965899AbWKTPUs
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 10:20:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:28813 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S965889AbWKTPUr (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 10:20:47 -0500
Received: (qmail invoked by alias); 20 Nov 2006 15:20:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp040) with SMTP; 20 Nov 2006 16:20:46 +0100
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 20 Nov 2006, Nguyen Thai Ngoc Duy wrote:

> I got this error in a quite big (in files) repository:
> error: open("vnexpress.net/Suc-khoe/2001/04/3B9AF976"): Too many open
> files in system
> fatal: cannot hash vnexpress.net/Suc-khoe/2001/04/3B9AF976
> 
> The repository contained about 67.000 files and probably all were modified.
> git version 1.4.4.rc1.g2bba

What was the command line? "git diff" really is a wrapper around different 
programs...

Ciao,
Dscho
