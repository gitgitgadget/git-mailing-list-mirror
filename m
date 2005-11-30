X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Question about handling of heterogeneous repositories
Date: Wed, 30 Nov 2005 14:58:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511301457040.2284@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0511220850w429d2f36lafe9de7ce19ce8f@mail.gmail.com> 
 <20051127131147.GF22159@pasky.or.cz>  <20051129204729.GA3033@steel.home> 
 <200511301405.19541.Josef.Weidendorfer@gmx.de>
 <81b0412b0511300515u5d2840ccv92be6e374dd795be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 30 Nov 2005 15:20:54 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <81b0412b0511300515u5d2840ccv92be6e374dd795be@mail.gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1EhSTT-00030t-KW for gcvg-git@gmane.org; Wed, 30 Nov
 2005 14:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751232AbVK3N6Q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 30 Nov 2005
 08:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVK3N6Q
 (ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 08:58:16 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:42710 "EHLO
 wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP id
 S1751232AbVK3N6O (ORCPT <rfc822;git@vger.kernel.org>); Wed, 30 Nov 2005
 08:58:14 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de
 [132.187.3.34]) by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id
 C445ADEF2C; Wed, 30 Nov 2005 14:58:11 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1]) by
 wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id A0A0CB5398; Wed, 30 Nov
 2005 14:58:11 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de
 [132.187.3.28]) by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id
 7FDD2B5383; Wed, 30 Nov 2005 14:58:11 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
 by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 4420CDEF2C; Wed, 30 Nov
 2005 14:58:11 +0100 (CET)
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 30 Nov 2005, Alex Riesen wrote:

> On 11/30/05, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> >
> > To detect inter-repository renaming, one has to see both repositories. 
> > Currently, git/cogito etc. commands only work with one repository 
> > only.
> 
> This case is somewhat special: one is _guaranteed_ to see both 
> repositories.

It is even more so: it is guaranteed that git cannot reconstruct this 
as a move operation.

Hth,
Dscho
