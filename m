From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGit RFC] A more structured way of calling git
Date: Sat, 3 Nov 2007 15:28:51 +0100
Message-ID: <20071103142851.GG26436@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20071026192418.GA19774@diana.vm.bytemark.co.uk> <b0943d9e0711030356j4dcd31cbl54d838107240b3d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 15:35:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoK5s-0003rl-VD
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 15:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbXKCOfI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Nov 2007 10:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754217AbXKCOfI
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 10:35:08 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:40967 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754106AbXKCOfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 10:35:07 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 9B93F17B578;
	Sat,  3 Nov 2007 15:35:05 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 7326117B548;
	Sat,  3 Nov 2007 15:35:05 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id C1CC63007; Sat,  3 Nov 2007 15:28:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b0943d9e0711030356j4dcd31cbl54d838107240b3d0@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63276>

On Sat, Nov 03, 2007 at 10:56:36AM +0000, Catalin Marinas wrote:
> On 26/10/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > I wanted to build an StGit command that coalesced adjacent patches =
to
> > a single patch. Because the end result tree would still be the same=
,
> > this should be doable without ever involving HEAD, the index, or th=
e
> > worktree.
>=20
> Wouldn't HEAD need to be modified since the commit log changes
> slightly, even though the tree is the same. Or am I misunderstanding
> this?

This reminds me of someone suggesting that some patches could be
represented by more than one commit.  But I'm not sure such a beast
would be useful - I fear that would make StGIT much more complicated,
but would it really make things better ?

Best regards,
--=20
Yann
