X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-shortlog mailmap
Date: Thu, 26 Oct 2006 15:16:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610261514160.3286@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0610261114520.3286@wbgn013.biozentrum.uni-wuerzburg.de>
 <ehputm$ch2$3@sea.gmane.org> <20061026123424.GQ20017@pasky.or.cz>
 <ehqaco$r4l$1@sea.gmane.org> <4540AD6E.6070201@op5.se> <ehqc8r$2nc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 26 Oct 2006 13:16:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <ehqc8r$2nc$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30211>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd55b-0005p3-MN for gcvg-git@gmane.org; Thu, 26 Oct
 2006 15:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423504AbWJZNQE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 09:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423505AbWJZNQE
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 09:16:04 -0400
Received: from mail.gmx.de ([213.165.64.20]:27298 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1423504AbWJZNQC (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 09:16:02 -0400
Received: (qmail invoked by alias); 26 Oct 2006 13:16:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp041) with SMTP; 26 Oct 2006 15:16:01 +0200
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 26 Oct 2006, Jakub Narebski wrote:

> Andreas Ericsson wrote:
> 
> > Wouldn't this be better implemented in the rev-list code then, so all 
> > log viewers can benefit from it?
> 
> Because this belongs to porcelain. Plumbing shouldn't show something
> that isn't there.

Actually, I think it would make sense. Since log viewers are 
porcelain-ish, they could transform the author/committer data according 
to .mailmap. Of course, that means that if two people have different 
mailmaps, they have to be aware of that fact when disagreeing over some 
authorship.

Ciao,
Dscho
