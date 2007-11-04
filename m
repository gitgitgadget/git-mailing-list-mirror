From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit RFC] A more structured way of calling git
Date: Sun, 4 Nov 2007 19:40:03 +0100
Message-ID: <20071104184003.GB6032@diana.vm.bytemark.co.uk>
References: <20071026192418.GA19774@diana.vm.bytemark.co.uk> <b0943d9e0711030356j4dcd31cbl54d838107240b3d0@mail.gmail.com> <20071103142851.GG26436@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	Git Mailing List <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 19:40:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IokOa-0004Ww-UX
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 19:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbXKDSkN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 13:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754111AbXKDSkN
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 13:40:13 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1476 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989AbXKDSkM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 13:40:12 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IokOB-0001of-00; Sun, 04 Nov 2007 18:40:03 +0000
Content-Disposition: inline
In-Reply-To: <20071103142851.GG26436@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63427>

On 2007-11-03 15:28:51 +0100, Yann Dirson wrote:

> This reminds me of someone suggesting that some patches could be
> represented by more than one commit.

You might be remebering me pointing out that the old infrastructure
supported (or at least not directly disallowed) this.

> But I'm not sure such a beast would be useful - I fear that would
> make StGIT much more complicated, but would it really make things
> better?

Yes, it makes everything much more complicated, and no, it doesn't buy
us anything new. After all, once we know the parent and the tree we
want a patch to have, we can just manufacture a commit that has that
tree and that parent.

My proposed new infrastructure cannot represent such patches, very
much by design.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
