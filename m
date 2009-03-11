From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: git-p4 workflow suggestions?
Date: Wed, 11 Mar 2009 08:03:12 +0100
Message-ID: <200903110803.12736.chriscool@tuxfamily.org>
References: <20090309142108.GK12880@zoy.org> <200903100815.53847.chriscool@tuxfamily.org> <20090310095729.GA27280@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sam Hocevar <sam@zoy.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 08:05:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhIVX-0005Gj-2K
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 08:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbZCKHEL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 03:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752502AbZCKHEK
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 03:04:10 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:35149 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbZCKHEI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 03:04:08 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 9086D940099;
	Wed, 11 Mar 2009 08:03:59 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id A72139400A4;
	Wed, 11 Mar 2009 08:03:57 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20090310095729.GA27280@zoy.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112890>

Le mardi 10 mars 2009, Sam Hocevar a =E9crit :
> On Tue, Mar 10, 2009, Christian Couder wrote:
> > >    I have modified git and git-p4 to a point where they are usabl=
e in
> > > my work environment. I am now faced with a new problem: Perforce'=
s
> > > composite workspaces. They allow you to "mount" parts of the repo
> > > onto other directories, even nonempty ones.
> >
> > It looks like SVN externals. So I think you should read about "git
> > submodule".
> >
> > There is this related link on the wiki:
> >
> > http://blog.alieniloquent.com/2008/03/08/git-svn-with-svnexternals/
>
>    Unfortunately submodules are considered separate repositories, so =
if
> I have /include and /src as submodules, I cannot commit atomically to
> both. Or can I? That's probably my strongest requirement.

I thought that you can commit in /include then in /src and then in the=20
supermodule. This way you should have an atomic commit in the supermodu=
le=20
with both changes. But I don't know much about submodules.

> > You may also want to search the mailing list as this subject has of=
ten
> > been discussed.
>
>    I did skim through the archives, but couldn't find much. There was
> this discussion: http://kerneltrap.org/mailarchive/git/2006/11/28/231=
515
> where the idea of Perforce-like workspaces was apparently dismissed a=
s
> being "a mess".

Perhaps. Anyway I think there are patches about submodules quite often =
on=20
the list and it seems a hot topic as there is an entry on the GSoC2009 =
idea=20
page:

http://git.or.cz/gitwiki/SoC2009Ideas

On this page you may also be interested by the "Narrow and Sparse clone=
=20
support" idea.

Best regards,
Christian.

PS: it would be nice to put me in the CC header of your emails when you=
=20
reply to me.
