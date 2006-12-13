X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t9100-git-svn-basic.sh fails
Date: Wed, 13 Dec 2006 01:03:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612130102000.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061212232321.GL2476@albany.tokkee.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 13 Dec 2006 00:10:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061212232321.GL2476@albany.tokkee.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34172>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuHhK-0002Oo-5u for gcvg-git@gmane.org; Wed, 13 Dec
 2006 01:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932578AbWLMAKH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 19:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWLMAKG
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 19:10:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:42470 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932578AbWLMAKF
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 19:10:05 -0500
Received: (qmail invoked by alias); 13 Dec 2006 00:03:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp029) with SMTP; 13 Dec 2006 01:03:23 +0100
To: Sebastian Harl <sh@tokkee.org>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 13 Dec 2006, Sebastian Harl wrote:

> When compiling git 1.4.4.2 on my Debian Sarge box t9100-git-svn-basic.sh 
> fails with the following output:
> 
>   * FAIL 6: detect node change from directory to file #1
>          git-svn commit --find-copies-harder --rmdir \
>		 remotes/git-svn..mybranch2

Could you please run the test like this:

git/t> sh t9100-* -i -v

The "-i" tells it to stop when a test fails, and "-v" makes it verbose.

Ciao,
