From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui/Makefile - Handle $DESTDIR on Cygwin
Date: Thu, 17 Jan 2008 23:01:46 -0500
Message-ID: <20080118040146.GY24004@spearce.org>
References: <20080116064012.GO24004@spearce.org> <1200628223-2280-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 05:02:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFiQv-0003Cb-UF
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 05:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbYAREBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 23:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbYAREBw
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 23:01:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42760 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbYAREBv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 23:01:51 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JFiQC-00006Z-M5; Thu, 17 Jan 2008 23:01:36 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E1A0C20FBAE; Thu, 17 Jan 2008 23:01:46 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1200628223-2280-1-git-send-email-mlevedahl@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70961>

Mark Levedahl <mlevedahl@gmail.com> wrote:
> From: Mark Levedahl <mdl123@verizon.net>
> 
> gg_libdir is converted to an absolute Windows path on Cygwin,
> but a later step attempts to prefix $DESTDIR to install to a
> staging directory. Explicitly separate the uses of gg_libdir for
> these two purposes so installation to $DESTDIR will work.
> 
> Signed-off-by: Mark Levedahl <mdl123@verizon.net>
> ---
> git-gui built with this  passed tests on cygwin + tcl/tk 8.5,
> cygwin + normal tcl/tk, and linux. DESTDIR also works on cygwin,
> so I would suggest this rather than the previous patch.

Excellent.  I was about to think about writing this patch myself,
but you beat me to it.  I'm applying this and will include it as
part of git-gui 0.9.2, which should be in git 1.5.4.

Thanks.
 
-- 
Shawn.
