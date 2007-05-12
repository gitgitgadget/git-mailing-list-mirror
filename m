From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Transactions for git (and stgit) ?
Date: Sat, 12 May 2007 12:49:19 +0200
Message-ID: <20070512104919.GA22735@diana.vm.bytemark.co.uk>
References: <1178794261.5806.98.camel@murta.transitives.com> <4643049C.3D5F30D8@eudaptics.com> <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070512095312.GK19253@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carl Worth <cworth@cworth.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat May 12 12:49:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmpAe-0001JB-U3
	for gcvg-git@gmane.org; Sat, 12 May 2007 12:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783AbXELKtp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 12 May 2007 06:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756275AbXELKtp
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 06:49:45 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1300 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755783AbXELKtp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 06:49:45 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HmpA7-0005wm-00; Sat, 12 May 2007 11:49:19 +0100
Mail-Followup-To: Yann Dirson <ydirson@altern.org>,
	Carl Worth <cworth@cworth.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070512095312.GK19253@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47032>

On 2007-05-12 11:53:12 +0200, Yann Dirson wrote:

> It could even be more sensible to implement transactions at the git
> level rather than at the stgit one...

Yes, please. (Unless a convincing technical argument pops up against
it, of course.) Any stgit invariant that isn't based on a git
invariant is one more thing that can break when git and stgit commands
are mixed.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
