From: David Tran <unsignedzero@gmail.com>
Subject: Re: [PATCH 1/8] Import =?utf-8?b?JExTX0NPTE9SUw==?= parsing code from coreutils
Date: Fri, 21 Mar 2014 20:01:52 +0000 (UTC)
Message-ID: <loom.20140321T205825-839@post.gmane.org>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com> <1395310551-23201-2-git-send-email-pclouds@gmail.com> <loom.20140320T200517-726@post.gmane.org> <CACsJy8A2gcKHtYVO1+RfGmu8M_rUBXqDE_kS4P5wgKnWRH+HmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 21:02:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR5eN-0005rH-RD
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 21:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbaCUUCX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Mar 2014 16:02:23 -0400
Received: from plane.gmane.org ([80.91.229.3]:43294 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbaCUUCV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 16:02:21 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WR5dy-0005FR-6x
	for git@vger.kernel.org; Fri, 21 Mar 2014 21:02:18 +0100
Received: from 50.23.113.239-static.reverse.uk2group.com ([50.23.113.239-static.reverse.uk2group.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 21:02:18 +0100
Received: from unsignedzero by 50.23.113.239-static.reverse.uk2group.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 21:02:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 50.23.113.239 (Mozilla/5.0 (Windows NT 6.2; WOW64; rv:21.0) Gecko/20100101 Firefox/21.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244732>

Duy Nguyen <pclouds <at> gmail.com> writes:

> On Fri, Mar 21, 2014 at 2:09 AM, David Tran <unsignedzero <at> gmail.=
com>
wrote:
> > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds <at> gmail.com> =
writes:
> >
> >> This could could help highlight files in ls-files or status output=
, or
> >> even diff --name-only (but that's questionable).
> >>
> >> This code is from coreutils.git commit
> >> 7326d1f1a67edf21947ae98194f98c38b6e9e527 file src/ls.c. This is th=
e
> >> last GPL-2 commit before coreutils turns to GPL-3.
> >>
> >
> > I don't know if this is something to consider but for my mac, I hav=
e another
> > variable CLICOLOR which shows the colors if it is set. This is also=
 true
with
> > FreeBSD[1] as well. I don't know if that should be checked if you'r=
e on
those
> > systems.
> >
> > I think it would be nice to have --color flag as well if you want t=
o enable
> > color output for just that one output.
>=20
> My plan is stick to how git handles colors (e.g. --color and color.*
> config variables). Is that enough or do you think git CLICOLOR should
> override --color and color.*?
>=20
I would say it is not an essential feature to have but something that m=
ight
be looked into once the color is implemented. If its not set, ignore it=
=2E If
it is set, check if it is truthy, is what I would do.
