From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: cleaning up after using git branch delete commands
Date: Thu, 8 Nov 2007 06:53:02 +0100
Message-ID: <20071108055302.GA11230@diana.vm.bytemark.co.uk>
References: <9e4733910711070606t2c558ac9ob4c729d5baca8fb9@mail.gmail.com> <tnxwssuyug1.fsf@pc1117.cambridge.arm.com> <9e4733910711070811y72f96a90i4db9acdf93aa765c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 06:53:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq0Kj-0004lh-KU
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 06:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbXKHFxW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 00:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbXKHFxW
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 00:53:22 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3987 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbXKHFxV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 00:53:21 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Iq0K6-0002w4-00; Thu, 08 Nov 2007 05:53:02 +0000
Content-Disposition: inline
In-Reply-To: <9e4733910711070811y72f96a90i4db9acdf93aa765c@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63935>

On 2007-11-07 11:11:42 -0500, Jon Smirl wrote:

> how about a 'stg gc' command that gets rid of all the inaccessible
> clutter?

"stg assimilate" already has the job of fixing up stuff after the user
has used git commands to move HEAD around. I think it would make sense
to teach it to do this too -- and then rename it "stg repair" or
something. That way, there's one command to fix every kind of "damage"
that git can do to stgit.

Alternatively, "stg branch --create" and "stg init" and whoever else
is bothered by the clutter could simply remove it themselves. That
would be even more user-friendly, I guess.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
