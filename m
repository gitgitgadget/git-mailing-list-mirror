From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGIT: stgitformatversion vs. stgit.formatversion
Date: Sun, 3 Jun 2007 14:17:18 +0200
Message-ID: <20070603121718.GA6507@diana.vm.bytemark.co.uk>
References: <20070602191641.GB6992@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 14:21:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hup57-0001FX-2h
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 14:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbXFCMVC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 3 Jun 2007 08:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758499AbXFCMVC
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 08:21:02 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3002 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755891AbXFCMVA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 08:21:00 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hup1L-0001rA-00; Sun, 03 Jun 2007 13:17:19 +0100
Content-Disposition: inline
In-Reply-To: <20070602191641.GB6992@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48982>

On 2007-06-02 21:16:41 +0200, Yann Dirson wrote:

> What about using branch.*.stgit.formatversion to store the version,
> to be consistent with other stgit-specific per-branch settings ?

Good idea. But we should probably fall back to stgitformatversion (or
better, upgrade from it) to be nice to those running Catalin's master.

It happens a bit too often that we find problems with patches only
after Catalin has published them on "master". (At least that seems to
be the case with patches coming from me!) Maybe a "pu" branch
(maintained either by Catalin or someone else) would be a good way to
smoke them out before they're written in stone and distributed to lots
of people.

If the stgitformatversion patch had been on such a branch, we could
just have edited it and not have to worry about upgrading old configs
(aside from posting a mail on how to upgrade manually).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
