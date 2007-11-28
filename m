From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGit hooks
Date: Wed, 28 Nov 2007 18:21:52 +0100
Message-ID: <20071128172152.GB21310@diana.vm.bytemark.co.uk>
References: <20071128101718.GA13940@diana.vm.bytemark.co.uk> <474D5482.5020609@op5.se> <20071128121905.GA15953@diana.vm.bytemark.co.uk> <474D69A7.6020404@op5.se> <20071128132605.GB15953@diana.vm.bytemark.co.uk> <474D7710.4090303@op5.se> <9e4733910711280653q119f2c2n173eaebdda6cd774@mail.gmail.com> <474D8205.8030401@op5.se> <20071128154059.GA19302@diana.vm.bytemark.co.uk> <474DA01C.8010901@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 28 18:22:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxQc4-0002rt-FZ
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 18:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757825AbXK1RV4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 12:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757109AbXK1RV4
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 12:21:56 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4973 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbXK1RVz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 12:21:55 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IxQbg-0005f6-00; Wed, 28 Nov 2007 17:21:52 +0000
Content-Disposition: inline
In-Reply-To: <474DA01C.8010901@op5.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66391>

On 2007-11-28 18:06:36 +0100, Andreas Ericsson wrote:

> True, but there are ways of figuring out which branch you're on,
> using the arguments passed to the hook.
>
> The rebase hook (which is where this discussion started) gets the
> branches passed to "git rebase" as arguments. Figuring out if either
> of those branches are actually under stgit control shouldn't be
> overly tricky for one so familiar with stgit as yourself.

No, that part is trivial. The hard part is not messing up the user's
existing hook scripts.

If I do go ahead and do this, I have a feeling I'll be beefing up
git's hook dispatch mechanism first -- if I can get it past Junio,
obviously. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
