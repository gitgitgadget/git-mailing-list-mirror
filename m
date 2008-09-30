From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/4 v2] cygwin: Use native Win32 API for stat
Date: Tue, 30 Sep 2008 13:26:25 -0700
Message-ID: <20080930202625.GM21310@spearce.org>
References: <20080927084349.GC21650@dpotapov.dyndns.org> <200809272035.03833.johannes.sixt@telecom.at> <20080927215406.GG21650@dpotapov.dyndns.org> <200809281124.08364.johannes.sixt@telecom.at> <20080929153400.GJ17584@spearce.org> <20080930135347.GK21650@dpotapov.dyndns.org> <48E23E5B.7020404@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Tue Sep 30 22:27:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkloo-0003rU-15
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 22:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbYI3U00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 16:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbYI3U00
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 16:26:26 -0400
Received: from george.spearce.org ([209.20.77.23]:35158 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbYI3U00 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 16:26:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4CCED3835F; Tue, 30 Sep 2008 20:26:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48E23E5B.7020404@griep.us>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97157>

Marcus Griep <marcus@griep.us> wrote:
> Dmitry Potapov wrote:
> > lstat/stat functions in Cygwin are very slow, because they try to emulate
> > some *nix things that Git does not actually need. This patch adds Win32
> > specific implementation of these functions for Cygwin.
> 
> Can't wait to see this patch in next or master!  If you recall my benchmarks
> from earlier, the speed-up is pretty good for cygwin users working with
> large repositories.
> 
> > Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
> 
> Thanks for the work, Dmitry!

Thanks folks.  I'm scheduling this for 'next'.  Lets see how
it goes...

-- 
Shawn.
