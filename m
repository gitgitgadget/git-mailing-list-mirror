From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGit hooks
Date: Wed, 28 Nov 2007 16:40:59 +0100
Message-ID: <20071128154059.GA19302@diana.vm.bytemark.co.uk>
References: <9e4733910711271512g790364e0ka4839b2be9fd4935@mail.gmail.com> <20071128093403.GB12977@diana.vm.bytemark.co.uk> <20071128101718.GA13940@diana.vm.bytemark.co.uk> <474D5482.5020609@op5.se> <20071128121905.GA15953@diana.vm.bytemark.co.uk> <474D69A7.6020404@op5.se> <20071128132605.GB15953@diana.vm.bytemark.co.uk> <474D7710.4090303@op5.se> <9e4733910711280653q119f2c2n173eaebdda6cd774@mail.gmail.com> <474D8205.8030401@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 28 16:41:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxP2Y-0007Qw-Cx
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 16:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756704AbXK1PlI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 10:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756615AbXK1PlH
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 10:41:07 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4399 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756404AbXK1PlH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 10:41:07 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IxP23-00053M-00; Wed, 28 Nov 2007 15:40:59 +0000
Content-Disposition: inline
In-Reply-To: <474D8205.8030401@op5.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66355>

On 2007-11-28 15:58:13 +0100, Andreas Ericsson wrote:

> Jon Smirl wrote:
>
> > I would expect 'stg init' to switch the branch to using the stgit
> > hooks and only those hooks. Branches that were not inited would
> > continue to use the user hooks. I don't have any user hooks, but
> > this is what I would expect to happen.
>
> Obviously the stgit-installed hook will have to check if the branch
> the user is operating on is managed by stgit before it prevents git
> rebase (or whatever it's supposed to do).

Yes. The point is, hooks are per repository, not per branch. So
there's no concept of "replacing the hooks for just this one branch".

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
