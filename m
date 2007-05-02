From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT RFC PATCH] Don't use refs/bases/<branchname>
Date: Wed, 2 May 2007 08:50:54 +0200
Message-ID: <20070502065054.GA9919@diana.vm.bytemark.co.uk>
References: <20070429220832.5832.251.stgit@yoghurt> <b0943d9e0705010137q4a35f818m7dbbc9d2e77e2fcf@mail.gmail.com> <e5bfff550705010210i352ac9eej6ff7a78aae6535c9@mail.gmail.com> <20070501185615.GA32727@diana.vm.bytemark.co.uk> <e5bfff550705011259w567a98dj6d0a68b0fbe90994@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 08:51:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj8g9-0002fy-Sl
	for gcvg-git@gmane.org; Wed, 02 May 2007 08:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbXEBGvG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 2 May 2007 02:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754877AbXEBGvG
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 02:51:06 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4378 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788AbXEBGvE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 02:51:04 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hj8fv-0002ag-00; Wed, 02 May 2007 07:50:55 +0100
Content-Disposition: inline
In-Reply-To: <e5bfff550705011259w567a98dj6d0a68b0fbe90994@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46003>

On 2007-05-01 21:59:34 +0200, Marco Costalba wrote:

> On 5/1/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > (But if I were you, I'd look for the patches under patches/refs
> > anyway; they _have_ to be there to survive garbage collection, so
> > no amount of stgit refactoring will break qgit.)
>
> Well, I did. ;-)
>
> Actually I pushed a patch few hours ago to read patches sha under
> refs/patches.

Good. This was precisely what I was hoping to scare you into doing!
:-)

> The problem is that the patch (for now) is pushed only for the new
> development version of qgit, not the stable one and, worse, all the
> currently released versions will break if you remove
> <git dir>/patches/ directory.
>
> So please, if possible deprecate <git dir>/patches/ directory but do
> not remove for a while, so to let users to upgrade gracefully.

It's not near the top of my kill list by any stretch of the
imagination, so no need to worry. And even if it were, Catalin would
certainly stand as a wall of sanity between qgit and my chain saw. :-)

Thanks.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
