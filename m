From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Throw IllegalStateException if DirCacheEntry has
 not been fully initialized.
Date: Wed, 12 Aug 2009 03:04:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908120303240.8306@pacific.mpi-cbg.de>
References: <1250038581-31241-1-git-send-email-grek@tuffmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Grzegorz Kossakowski <grek@google.com>
To: Grzegorz Kossakowski <grek@tuffmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 03:04:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb2Fx-0003W3-C8
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 03:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbZHLBDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 21:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753161AbZHLBDs
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 21:03:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:34976 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751490AbZHLBDr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 21:03:47 -0400
Received: (qmail invoked by alias); 12 Aug 2009 01:03:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 12 Aug 2009 03:03:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GW34rrmsGlwaSZCZ+XiLRQK5l8+T4UGBEqUO+Ct
	NjuUaM1ten+DKx
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1250038581-31241-1-git-send-email-grek@tuffmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125636>

Hi,

On Tue, 11 Aug 2009, Grzegorz Kossakowski wrote:

> From: Grzegorz Kossakowski <grek@google.com>
> 
> When mode's object type of entry equals to Constants.OBJ_BAD it's a sign
> of bad (uninitialized) state of an entry and not of problems with merging.
> 
> Signed-off-by: Grzegorz Kossakowski <grek@google.com>
> ---
>  .../org/spearce/jgit/dircache/DirCacheTree.java    |    3 ++-

That's great, but next time, please prefix your mail subjects with [JGIT 
PATCH] so that people who don't speak Java know that this is not for them.

Thanks!
Dscho
