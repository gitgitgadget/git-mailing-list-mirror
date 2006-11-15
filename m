X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git tag: don't complain of empty messages
Date: Wed, 15 Nov 2006 17:02:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611151657570.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <ejfc1t$6am$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 15 Nov 2006 16:03:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <ejfc1t$6am$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31448>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkNE0-0006Is-Dr for gcvg-git@gmane.org; Wed, 15 Nov
 2006 17:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030618AbWKOQCf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 11:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030622AbWKOQCe
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 11:02:34 -0500
Received: from mail.gmx.de ([213.165.64.20]:13271 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1030618AbWKOQCe (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 11:02:34 -0500
Received: (qmail invoked by alias); 15 Nov 2006 16:02:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp019) with SMTP; 15 Nov 2006 17:02:32 +0100
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 15 Nov 2006, Han-Wen Nienhuys wrote:

> GIT refuses to set annotated tags without a comment. I think this is a silly
> restriction when the message is explicitly set to the empty string.

I think that this behaviour is on purpose: The tag will be identified 
(like all objects in git) by its contents. The rationale: the filename 
does not matter, since the tag _object_ is not identified by it. So, in 
case you lose your .git/refs/tags/ directory, you can still reconstruct 
the tags with "git-fsck-objects --full".

Ciao,
Dscho
