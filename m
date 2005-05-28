From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: More gitweb queries..
Date: Sat, 28 May 2005 10:42:55 +0200
Message-ID: <20050528084255.GA32614@vrfy.org>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org> <20050527235924.GB19491@vrfy.org> <f0796bb705052718035cd5dbe2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 10:41:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbwsQ-00073J-8p
	for gcvg-git@gmane.org; Sat, 28 May 2005 10:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVE1InD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 28 May 2005 04:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbVE1InD
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 04:43:03 -0400
Received: from soundwarez.org ([217.160.171.123]:13019 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262494AbVE1Im7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 May 2005 04:42:59 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 85FA450F5; Sat, 28 May 2005 10:42:55 +0200 (CEST)
To: Daniel Serpell <daniel.serpell@gmail.com>
Content-Disposition: inline
In-Reply-To: <f0796bb705052718035cd5dbe2@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, May 27, 2005 at 09:03:24PM -0400, Daniel Serpell wrote:
> Hi!
>=20
> On 5/27/05, Kay Sievers <kay.sievers@vrfy.org> wrote:
> > On Fri, May 27, 2005 at 12:24:20PM -0700, Linus Torvalds wrote:
> > >   Combining some of the features of the two (that =C3=BCber-cool =
revision
> > >   history graph from gitk rules, for example) might be cool. I ge=
t the
> > >   urge to do octopus-merges in the kernel just because of how goo=
d they
> > >   look in gitk ;) ]
> >=20
> > I would like to show something like the graph too, but I don't real=
ly know
> > how to do this in html. Seems slippery if not impossible.
> > If anybody has a nice idea how to represent that, I will give it a =
try.
>=20
> Well, you could draw them in javascript, using
> http://www.walterzorn.com/jsgraphics/jsgraphics_e.htm :-)

You know how that stuff works? :) It is a very nice idea for
small stuff, but it uses a <div> for every pixel/line you draw and
places this in the background and I expect it to kill your browser if
you try to draw things like gitk does.

> Alternatively, you could use a fixed set of little images, a bar "|",=
 a
> dot "o" and branches like "Y", "7" and "\". Obviously, octopus-merges
> are very difficult to draw using only those.

Did you look at gitk? With a all the crossing and long lines, you defin=
itely
need to draw the lines with colors. Otherwise you will see _nothing_, b=
ut
random characters. :)

> BTW, I tried searching on gitweb, and I think that found a problem, s=
ee:
> http://ehlo.org/~kay/gitweb.cgi?p=3Dgit/git.git;a=3Dsearch;s=3Dcheck
> At the bottom of the page, highlighting of the search term stops and =
the
> commits are all the same color.

Well, you see a list of files which contain the text, not the text
itself. I can print the filename in red. :)

Thanks,
Kay
