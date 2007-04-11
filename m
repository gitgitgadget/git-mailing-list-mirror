From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] simple random data generator for tests
Date: Wed, 11 Apr 2007 13:42:05 -0400
Message-ID: <20070411174205.GQ5436@spearce.org>
References: <alpine.LFD.0.98.0704111330120.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 19:42:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbgpj-00005u-DJ
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 19:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbXDKRmM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 13:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752999AbXDKRmM
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 13:42:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33254 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbXDKRmL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 13:42:11 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HbgpV-0004je-1R; Wed, 11 Apr 2007 13:42:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D6FDF20FBAE; Wed, 11 Apr 2007 13:42:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704111330120.28181@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44248>

Nicolas Pitre <nico@cam.org> wrote:
> ---
>  Makefile         |    7 +++++--
>  test-genrandom.c |   34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 2 deletions(-)
>  create mode 100644 test-genrandom.c

A change to .gitignore would also be nice.  ;-)
 
> +	unsigned long count, next = 0;

What about wraparound?  Could this produce different results on a
32 bit system and a 64 bit system, due to the difference in size
of unsigned long?

-- 
Shawn.
