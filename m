From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merging commits together into a super-commit
Date: Sat, 12 May 2007 12:27:49 -0700
Message-ID: <7vy7jtyh8q.fsf@assigned-by-dhcp.cox.net>
References: <1178794261.5806.98.camel@murta.transitives.com>
	<4643049C.3D5F30D8@eudaptics.com>
	<alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org>
	<87wszg39cp.wl%cworth@cworth.org>
	<20070510171457.GK13719@fieldses.org>
	<87vef0350y.wl%cworth@cworth.org> <20070510192106.GB4489@pasky.or.cz>
	<87tzuk31fu.wl%cworth@cworth.org>
	<20070512113430.GL19253@nan92-1-81-57-214-146.fbx.proxad.net>
	<20070512140228.GB28039@diana.vm.bytemark.co.uk>
	<20070512144145.GF16903@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carl Worth <cworth@cworth.org>, Petr Baudis <pasky@suse.cz>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat May 12 21:28:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmxG9-0004Im-Tq
	for gcvg-git@gmane.org; Sat, 12 May 2007 21:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759035AbXELT1y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 12 May 2007 15:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759022AbXELT1y
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 15:27:54 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:57189 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758179AbXELT1w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 May 2007 15:27:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512192752.WHHP22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 15:27:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id yKTp1W00E1kojtg0000000; Sat, 12 May 2007 15:27:50 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47077>

Yann Dirson <ydirson@altern.org> writes:

> On Sat, May 12, 2007 at 04:02:28PM +0200, Karl Hasselstr=C3=B6m wrote=
:
>> ...
>> What we should do is delete all stgit metadata when the last patch
>> goes away.
>
> This supposes there is no valuable branch-level metadata.  Currently
> we have the description - something which could arguably be moved to
> the git level as well.  Otherwise that sounds reasonable to me.

Will it be something like

	[branch "master"]
        	description =3D "My primary development line"

if so I think that is a reasonable thing to do, from git-core's
point of view.  Obviously, gitk, tig, gitweb and friends can use
this, too.

Are there other per-branch information StGIT wants to keep on an
active branch that might benefit the core as well?

>> And we shouldn't have "stg init", either. Initing should be done
>> automatically when needed.
>
> Good idea as well, that would make stg more accessible to the average
> plain-git user.

Yes, I wished for this often myself.
