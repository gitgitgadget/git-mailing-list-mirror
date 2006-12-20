X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Undocumented long options
Date: Wed, 20 Dec 2006 17:17:00 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612201716240.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612201707.00346.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 20 Dec 2006 16:17:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612201707.00346.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34945>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx484-00007C-D4 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 17:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030187AbWLTQRF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 11:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWLTQRF
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 11:17:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:52858 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1030187AbWLTQRD
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 11:17:03 -0500
Received: (qmail invoked by alias); 20 Dec 2006 16:17:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp050) with SMTP; 20 Dec 2006 17:17:01 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 20 Dec 2006, Jakub Narebski wrote:

> Here is the list of undocumented long options I have found in git:
> 
> * --abbrev-commit (in revision.c) - I'm not sure _where_ it should
>   be added, as it afects most visible I think git-log, git-show,
>   git-rev-list. Implies --abbrev.
> * --exclude-existing of git-show-ref; new option
> * --reflog of git-show-branch, similar to --no-name and --ahs1-name
>   options I think; new option
> * --timestamp option of git-rev-list. Bit strange, but perhaps useful.
>   I don't quite know what it does.
> * --full-history option of git-rev-list (--full-diff just got
>   documented). I think it would be nice to have described while at it
>   git history simplification, and how options like --full-history, path
>   limiter, --parents interacts with it.
> * --trivial option of git-read-tree. It looks like opposite of
>   (documented) --aggresive option, but source indicates that it might
>   be not exactly opposite.
> * --thin and --no-thin of send-pack. It is plumbing option, but even
>   plumbing should be documented. Not sure which commands are affected by
>   this.

Matthew  24:46

Hth,
Dscho
