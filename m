From: Yann Dirson <ydirson@altern.org>
Subject: Re: stgit: config option for diff-opts
Date: Thu, 24 Jan 2008 08:48:27 +0100
Message-ID: <20080124074827.GA29572@nan92-1-81-57-214-146.fbx.proxad.net>
References: <9e4733910801221904k5f66a231t9cb8330eff3861c4@mail.gmail.com> <20080123031829.GB25508@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 08:48:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHwoo-0000vR-E2
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 08:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbYAXHre convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 02:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbYAXHrd
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 02:47:33 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:60651 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbYAXHrd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 02:47:33 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 12E2B17B546;
	Thu, 24 Jan 2008 08:47:31 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id B4BBD17B537;
	Thu, 24 Jan 2008 08:47:30 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 0D8CE1F028; Thu, 24 Jan 2008 08:48:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080123031829.GB25508@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71595>

On Wed, Jan 23, 2008 at 04:18:29AM +0100, Karl Hasselstr=F6m wrote:
> On 2008-01-22 22:04:21 -0500, Jon Smirl wrote:
>=20
> > Could I get a config option added to stgit for diff-opts? So that I
> > can always have git diff -M set on renames.
>=20
> Good idea. I've often needed this myself, without consciously
> realizing it -- my bash is set to save an infinite amount of history,
> so Ctrl+R always helps me out ...
>=20
> Will whip up, unless someone beats me to it. It's getting sorta late,
> so I won't have time for at least a day or two.

I also think that some config stuff should be done, but I could not
come with a usable design.

See eg. http://marc.info/?l=3Dgit&m=3D118102609623481&w=3D4

Another problem not explicitely mentionned there is that we my want on
the same project to have different settings, eg. for viewing (as
compact as possible), exporting (GNU compatibility), and feeding to
other git commands (with --binary).

Best regards,
--=20
Yann
