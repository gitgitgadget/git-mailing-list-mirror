X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Average size of git bookkeeping data (related to Using git as
 a general backup mechanism)
Date: Thu, 14 Dec 2006 01:02:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612140058000.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061213193149.43284.qmail@web86909.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 00:03:08 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061213193149.43284.qmail@web86909.mail.ukl.yahoo.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34268>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gue3x-0005RO-KS for gcvg-git@gmane.org; Thu, 14 Dec
 2006 01:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751787AbWLNAC5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 19:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWLNAC5
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 19:02:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:53765 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751804AbWLNAC4
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 19:02:56 -0500
Received: (qmail invoked by alias); 14 Dec 2006 00:02:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp017) with SMTP; 14 Dec 2006 01:02:55 +0100
To: David Tweed <tweed314@yahoo.co.uk>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 13 Dec 2006, David Tweed wrote:

> How big is the "metadata" or "bookeeping data" in git related to a 
> commit?

In my experience, a single commit (with the trees and blobs being 
reachable from it) takes about the same space in a pack as the 
corresponding tar ball.

When you add revisions, the pack grows approximately with the compressed 
patch size.

So, if you can estimate the size of the initial tar ball and the size of 
the subsequent patches, you have a ballpark figure of the metadata size of 
the git repository. (This is for the bare case; for the regular case you 
have to add the size of a checked out tree, of course.)

Hth,
Dscho
