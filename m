X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Struggling with tangled
Date: Wed, 22 Nov 2006 14:30:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611221429470.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <E1GmpTj-000235-2n@home.chandlerfamily.org.uk>
 <Pine.LNX.4.63.0611221233370.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vu00rsnho.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 22 Nov 2006 13:31:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vu00rsnho.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32085>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmsBZ-0004Yu-HD for gcvg-git@gmane.org; Wed, 22 Nov
 2006 14:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755853AbWKVNaU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 08:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755818AbWKVNaU
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 08:30:20 -0500
Received: from mail.gmx.de ([213.165.64.20]:60855 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1755853AbWKVNaS (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 08:30:18 -0500
Received: (qmail invoked by alias); 22 Nov 2006 13:30:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp031) with SMTP; 22 Nov 2006 14:30:17 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 22 Nov 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	git diff --ours <file> | git apply -R
> >
> > This also updates the index.
> 
> Good suggestion, but apply does not update the index without
> being told to do so with --index, so I think the commandline
> should be:
> 
> 	git diff --ours <path> | git apply -R --index

Oops. Thanks!
Dscho
