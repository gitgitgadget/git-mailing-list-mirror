From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fix memory leak in parse_object when check_sha1_signature fails
Date: Thu, 24 May 2007 22:09:39 -0400
Message-ID: <20070525020939.GT28023@spearce.org>
References: <1b46aba20705241846u615785eeh7c3ebeaf840b2180@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 04:09:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrPFS-0001cT-TD
	for gcvg-git@gmane.org; Fri, 25 May 2007 04:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbXEYCJp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 22:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752719AbXEYCJo
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 22:09:44 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59057 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbXEYCJo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 22:09:44 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HrPFC-0008TI-IX; Thu, 24 May 2007 22:09:30 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 53B1D20FBAE; Thu, 24 May 2007 22:09:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1b46aba20705241846u615785eeh7c3ebeaf840b2180@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48332>

Carlos Rica <jasampler@gmail.com> wrote:
> When check_sha1_signature fails, program is not terminated:
> it prints an error message and returns NULL, so the
> buffer returned by read_sha1_file should be freed before.
...
> 		if (check_sha1_signature(sha1, buffer, size, typename(type)) 
> 		< 0) {
...

gmail strikes again.  The above line is wrapped, which means your
patch is whitespace damaged and won't apply properly.

-- 
Shawn.
