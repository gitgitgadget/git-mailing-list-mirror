X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/13] Add a config option for remotes to specify a 
 foreign vcs
Date: Wed, 5 Aug 2009 23:50:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908052349250.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0908050055500.2147@iabervon.org>  <alpine.DEB.1.00.0908052251430.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051658530.2147@iabervon.org>  <alpine.DEB.1.00.0908052319210.8306@pacific.mpi-cbg.de>
 <fabb9a1e0908051446t63942d21nf71ee0673bb85b8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 5 Aug 2009 21:50:01 +0000 (UTC)
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19RyhwlWpBRos+/x6aouR0VmXGhHit3+XgW3CPKQa
	HPkujMOqM9SoPm
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e0908051446t63942d21nf71ee0673bb85b8c@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1MYoMq-0005ko-UQ for gcvg-git-2@gmane.org; Wed, 05 Aug 2009
 23:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752730AbZHEVtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009
 17:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752706AbZHEVtg
 (ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 17:49:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:51539 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751267AbZHEVtf
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 17:49:35 -0400
Received: (qmail invoked by alias); 05 Aug 2009 21:49:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by
 mail.gmx.net (mp058) with SMTP; 05 Aug 2009 23:49:35 +0200
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 5 Aug 2009, Sverre Rabbelier wrote:

> On Wed, Aug 5, 2009 at 14:20, Johannes 
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
> > I actually would rather have "svn-http://something" because it tells 
> > me right away and in red letters what is happening.
> 
> I don't know if this is only for ssh, but wouldn't
> "http+svn://something" be very recognisable?

Problem: on Windows, we cannot name the helper git-remote-http+svn: "+" is 
not an allowed character in a filename.

Ciao,
Dscho
