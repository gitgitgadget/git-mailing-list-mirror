X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-recursive: configurable 'merge' program
Date: Tue, 5 Dec 2006 08:38:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612050836570.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061204235647.9BA8B139B0E@magnus.utsl.gen.nz> <el2cpj$cna$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 07:38:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <el2cpj$cna$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33313>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrUsm-0005wG-Dw for gcvg-git@gmane.org; Tue, 05 Dec
 2006 08:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937472AbWLEHiY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 02:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937473AbWLEHiY
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 02:38:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:43072 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S937472AbWLEHiY
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 02:38:24 -0500
Received: (qmail invoked by alias); 05 Dec 2006 07:38:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp037) with SMTP; 05 Dec 2006 08:38:22 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 5 Dec 2006, Jakub Narebski wrote:

> Sam Vilain wrote:
> 
> > For those who like to spawn interactive merge tools on a merge failure
> > or otherwise run some kind of script, allow a "merge.tool" repo-config
> > option that will take arguments as merge(1) does.
> 
> How it goes together with merge-recursive rewrite using built-in merge tool
> >from xdiff, xdl_merge?

Not a big problem. If people like Sam's patch, it is easy to integrate, 
since it only means that if merge.tool is set to something non-empty, 
xdl_merge is not called, but the merge.tool is forked.

Ciao,
Dscho
