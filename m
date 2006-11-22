X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Struggling with tangled
Date: Wed, 22 Nov 2006 12:35:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611221233370.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <E1GmpTj-000235-2n@home.chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 22 Nov 2006 11:36:11 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <E1GmpTj-000235-2n@home.chandlerfamily.org.uk>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32080>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmqOV-0002jS-Vk for gcvg-git@gmane.org; Wed, 22 Nov
 2006 12:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752292AbWKVLf4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 06:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbWKVLf4
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 06:35:56 -0500
Received: from mail.gmx.de ([213.165.64.20]:36811 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1752292AbWKVLf4 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 06:35:56 -0500
Received: (qmail invoked by alias); 22 Nov 2006 11:35:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp019) with SMTP; 22 Nov 2006 12:35:54 +0100
To: Alan Chandler <alan@chandlerfamily.org.uk>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 22 Nov 2006, Alan Chandler wrote:

> 2) Some files get completely munged with conflict resolution markers 
> every few lines.  Is there a simple way to say "don't use this file, but 
> use the [stage2/stage3] sources of the merge". (ie one of the original 
> inputs to the merge - and if so, which one is which)

I find myself using

	git diff --ours <file>

and

	git diff --theirs <file>

in such a case sometimes. If I _know_ my version is good, I do

	git diff --ours <file> | git apply -R

This also updates the index.

Hth,
Dscho
