From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: lost all my patches again
Date: Thu, 4 Oct 2007 10:33:04 +0200
Message-ID: <20071004083304.GB17778@diana.vm.bytemark.co.uk>
References: <9e4733910710032229m38fb4e47k5aa0b2b2e0eb2251@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 10:33:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdM9T-0004io-6J
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 10:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbXJDIdj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 04:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbXJDIdi
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 04:33:38 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3935 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbXJDIdh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 04:33:37 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IdM8m-0004f1-00; Thu, 04 Oct 2007 09:33:04 +0100
Content-Disposition: inline
In-Reply-To: <9e4733910710032229m38fb4e47k5aa0b2b2e0eb2251@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59930>

On 2007-10-04 01:29:17 -0400, Jon Smirl wrote:

> for some reason the refresh from that command didn't close. Then stg
> pushed all the patches back after the edit and they got included
> into that patch.

That's really weird. As far as I know there isn't a concept of
"closed" patches in StGit -- there's no need, because they're always
closed!

> I did the 'stg refresh' from a directory that was not being tracked
> by git. It is in the .gitignore list. This appears to be the root of
> the problem.

Mmmph. This is not the only StGit command that's apparently not safe
to run from a subdirectory. See e.g. https://gna.org/bugs/?9986.

I plan to do some StGit hacking this weekend. I guess subdirectory
safeness ought to be at the top of my list ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
