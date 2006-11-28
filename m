X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Trim hint printed when gecos is empty.
Date: Tue, 28 Nov 2006 14:28:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611281426311.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <ekh2uh$nk2$1@sea.gmane.org> <ekh4cu$q6e$2@sea.gmane.org>
 <ekh5k8$vih$1@sea.gmane.org> <200611281146.56201.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 28 Nov 2006 13:29:03 +0000 (UTC)
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200611281146.56201.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32522>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp30h-0002Mt-9t for gcvg-git@gmane.org; Tue, 28 Nov
 2006 14:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758668AbWK1N22 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 08:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758669AbWK1N22
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 08:28:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:8651 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1758668AbWK1N21 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 08:28:27 -0500
Received: (qmail invoked by alias); 28 Nov 2006 13:28:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp046) with SMTP; 28 Nov 2006 14:28:26 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 28 Nov 2006, Andy Parkins wrote:

> The thing that's missing is a config option to make git-commit add the 
> signoff automatically.

No. As has been often said, a signoff _has_ to be a conscious act, or else 
it will lose its meaning.

Once you are reasonably convinced you want to sign off on that commit, 
just add "-s" to git-commit. And if you forgot, fix it by "git commit -s 
--amend". (Note that this is another nice example why "-a" by default 
would be wrong, wrong, wrong.)

Ciao,
Dscho
