From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Add function to checkout a branch in git.el
Date: Wed, 13 Feb 2008 22:04:20 +0100
Message-ID: <20080213210420.GA9316@diana.vm.bytemark.co.uk>
References: <87wsp8u9m7.dlv@maison.homelinux.org> <20080213163002.GA5670@diana.vm.bytemark.co.uk> <20080213164356.GA5828@diana.vm.bytemark.co.uk> <87zlu4vhon.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: vanicat@debian.org, git@vger.kernel.org,
	Alexandre Julliard <julliard@winehq.org>
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 22:06:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPOnY-00009w-Jp
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 22:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbYBMVEy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 16:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752147AbYBMVEy
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 16:04:54 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3758 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbYBMVEy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 16:04:54 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JPOmC-0002TL-00; Wed, 13 Feb 2008 21:04:20 +0000
Content-Disposition: inline
In-Reply-To: <87zlu4vhon.fsf@osv.gnss.ru>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73818>

On 2008-02-13 21:23:52 +0300, Sergei Organov wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> >   * if the user enters a name that's not the name of an existing
> >     branch, display a prompt like this
> >
> >       Creating new branch "foo". Where should it start?
> >
> >     Tab complete on existing tags and branches, but accept any
> >     committish. Create the new branch and switch to it.
>
> It still doesn't allow to detach HEAD at arbitrary tag/committish,
> as far as I can see.

It wouldn't be hard. Just try to interpret the string supplied by the
user as a committish: if successful, check it out; if not, create a
new branch by that name. Of course, this makes it impossible to create
a branch with the same name as an existing committish, but that's
probably OK.

> I believe the interface should be designed more carefully. Here are
> some thoughts/suggestions:

Yes, having different commands that do one job each and do it well
isn't a bad idea either. I like my idea more, but obviously whoever
writes the code gets to decide ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
