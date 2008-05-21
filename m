From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGit: kha/{safe,experimental} updated
Date: Wed, 21 May 2008 16:58:34 +0200
Message-ID: <20080521145834.GB31982@diana.vm.bytemark.co.uk>
References: <20080514014309.GA17955@diana.vm.bytemark.co.uk> <b0943d9e0805191421n1ca676dai1b3ed7d6eb1df5f4@mail.gmail.com> <20080520070441.GB7324@diana.vm.bytemark.co.uk> <b0943d9e0805201019x10bf87ecr1c11c8ee474f6138@mail.gmail.com> <20080520210249.GA19465@diana.vm.bytemark.co.uk> <b0943d9e0805210707s5af76462wc92a4cf55e5d4a9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 17:04:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jypmt-0004Jz-N1
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 16:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757144AbYEUO6l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 May 2008 10:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757255AbYEUO6l
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 10:58:41 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4784 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757144AbYEUO6l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 10:58:41 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Jyply-0008SJ-00; Wed, 21 May 2008 15:58:34 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0805210707s5af76462wc92a4cf55e5d4a9d@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82551>

On 2008-05-21 15:07:44 +0100, Catalin Marinas wrote:

> 2008/5/20 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > Nah, easier to just change the order of the checks (try r2 before
> > r1) as I outlined. I'll whip up a patch.
> [...]
> > If you're exactly on a tagged commit, git-describe will return
> > just the name of that tag, so you don't need to do anything extra.
>
> Now that you mentioned this (I didn't know), is there a need to
> reverse steps r2 and r1? I always build the release from the current
> tag and the version should be clean.

The advantage is that step r1 involves running git-describe, which is
relatively expensive. With the patch I just posted, we only have to
pay that cost when it's really necessary (which is when running stg
directly from a git tree).

> > Both git and we call git-describe with --abbrev=3D4, which I think
> > means "describe the commit uniquely with as few digits as
> > possible, but no less than four". So we'll get upgraded
> > automatically when it becomes necessary.
>
> OK, I didn't know this either.

I only found out when I wrote the first version patch.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
