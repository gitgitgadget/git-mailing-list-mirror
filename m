From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Help identify aspell version on Windows too
Date: Fri, 26 Sep 2008 07:28:18 -0700
Message-ID: <20080926142818.GW3669@spearce.org>
References: <1222378282-21757-1-git-send-email-hendeby@isy.liu.se> <48DC815C.6030401@viscovery.net> <48DCA5F3.4090009@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Fri Sep 26 16:29:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjEK0-000359-Gm
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 16:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbYIZO2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 10:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752316AbYIZO2T
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 10:28:19 -0400
Received: from george.spearce.org ([209.20.77.23]:46919 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbYIZO2T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 10:28:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C246E3835F; Fri, 26 Sep 2008 14:28:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48DCA5F3.4090009@isy.liu.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96853>

Gustaf Hendeby <hendeby@isy.liu.se> wrote:
> >>  	}
> >> -	set s_version [string range $s_version 5 end]
> >> +			set s_version [string range [string trim $s_version] 5 end]
> > 
> > A strange indentation you have here.
> 
> Yep, sorry about that, seems I had a nonstandard tab-width setting.  Too
> bad not all projects can decide on the same tab width. :(  Will resend
> if there are no other comments to this, and at the same time fix the
> spelling in the commit message...

I fixed the indentation, but didn't notice the spelling error in
the commit message.  Anyway, its too late, I have already pushed
this fix out to my maint and master branches in git-gui.  I'm not
going to rewind 'em.

-- 
Shawn.
