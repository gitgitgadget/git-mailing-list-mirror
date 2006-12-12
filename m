X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Using git as a general backup mechanism (was Re: Using GIT to
 store /etc)
Date: Tue, 12 Dec 2006 23:57:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612122355400.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
 <Pine.LNX.4.64.0612111837210.20138@iabervon.org> <8900B938-1360-4A67-AB15-C9E84255107B@mac.com>
 <200612121553.37499.andyparkins@gmail.com> <457F31E6.8090701@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 22:57:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <457F31E6.8090701@midwinter.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34162>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuGYx-0000ir-RP for gcvg-git@gmane.org; Tue, 12 Dec
 2006 23:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932556AbWLLW5Z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 17:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWLLW5Z
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 17:57:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:34202 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932556AbWLLW5Y
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 17:57:24 -0500
Received: (qmail invoked by alias); 12 Dec 2006 22:57:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp041) with SMTP; 12 Dec 2006 23:57:22 +0100
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 12 Dec 2006, Steven Grimm wrote:

> If there were a shallowize command, you could do something like "git 
> pull; git shallowize --depth 1" to track the latest revision without 
> keeping the history locally.

Almost!

$ git pull --depth 1

Though it needs a server _and_ a client supporting shallow clones, which 
support is brewed in "next" right now.

Ciao,
Dscho
