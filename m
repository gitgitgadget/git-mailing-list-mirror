From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit] kha/{safe,experimental} updated
Date: Thu, 25 Sep 2008 09:33:49 +0200
Message-ID: <20080925073349.GB27632@diana.vm.bytemark.co.uk>
References: <20080921153757.GA9098@diana.vm.bytemark.co.uk> <b0943d9e0809241548t32e8ac24n3ec88698fb907764@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	Daniel White <daniel@whitehouse.id.au>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 09:13:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kil26-0004cP-9p
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 09:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbYIYHLx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2008 03:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbYIYHLx
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 03:11:53 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3391 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbYIYHLx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 03:11:53 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KilME-0007HO-00; Thu, 25 Sep 2008 08:33:50 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0809241548t32e8ac24n3ec88698fb907764@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96728>

On 2008-09-24 23:48:08 +0100, Catalin Marinas wrote:

> 2008/9/21 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > Just pushed out the stack log stuff to kha/safe. It really should
> > be ready for wider use at this point, and it was getting tiresome
> > to keep rebasing it.
>
> Great work, I merged (most of) it. Many thanks.

Thanks.

> > One patch is still in experimental -- it depends on a new git
> > feature that isn't in any release yet.
> [...]
> >      Read several objects at once with git cat-file --batch
>
> I skipped this one for now.

I was talking about kha/experimental~0 here; you're talking about
kha/safe~0, which is kha/experimental~1. But never mind.

> I'm using Ubuntu (Hardy) and the git version is 1.5.4.3. I would
> wait until we get at least a stable git release with this feature.

I'm using it too, but I always build my own git, so I never know what
version the system comes with ... but I see your point. I'll put that
patch back in kha/experimental for now.

> I haven't looked in detail but can we have a way to drop back to the
> old implementation if the option isn't available?

I guess in this case we could, since if the option exists, we can use
it. (The second patch is not so lucky; the flag exists since quite a
while, but lacks a feature in older gits.)

Since it's just a moderate speed-up in both cases, I'm kind of
inclined to just wait for relevant distributions to catch up, and
avoid all the hassle.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
