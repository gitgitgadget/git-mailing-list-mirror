From: Yann Dirson <ydirson@altern.org>
Subject: Re: Merging commits together into a super-commit
Date: Sun, 13 May 2007 21:35:08 +0200
Message-ID: <20070513193507.GN19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070510171457.GK13719@fieldses.org> <87vef0350y.wl%cworth@cworth.org> <20070510192106.GB4489@pasky.or.cz> <87tzuk31fu.wl%cworth@cworth.org> <20070512113430.GL19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070512140228.GB28039@diana.vm.bytemark.co.uk> <20070512144145.GF16903@nan92-1-81-57-214-146.fbx.proxad.net> <7vy7jtyh8q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, Petr Baudis <pasky@suse.cz>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 21:36:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnJrn-0001rO-1e
	for gcvg-git@gmane.org; Sun, 13 May 2007 21:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757972AbXEMTgW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 15:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758063AbXEMTgW
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 15:36:22 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:60488 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757972AbXEMTgV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 15:36:21 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 53CD55F96F;
	Sun, 13 May 2007 21:36:18 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 2E1EF1F161; Sun, 13 May 2007 21:35:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy7jtyh8q.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47175>

On Sat, May 12, 2007 at 12:27:49PM -0700, Junio C Hamano wrote:
> Are there other per-branch information StGIT wants to keep on an
> active branch that might benefit the core as well?

Maybe the "protected" attribute, to forbid commands to touch to the
stack ?  Not sure, however, since the semantics would probably be a
bit different in git (eg. just forbid update-ref) and in StGIT (also
protects unapplied patches).

Best regards,
-- 
Yann
