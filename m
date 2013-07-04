From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH] gitweb: allow extra breadcrumbs to prefix the trail
Date: Thu, 4 Jul 2013 09:44:50 +0100
Message-ID: <alpine.LSU.2.00.1307040940400.26246@hermes-2.csi.cam.ac.uk>
References: <E1Uu3IT-0008U1-3c@hermes-2.csi.cam.ac.uk> <20130703215930.GT408@google.com> <CANQwDwcneUzzXS-Du-3Aca3-Vp8ycSzVqUv1rVRVhaNUWfeokw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870870024-182335467-1372927490=:26246"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 10:45:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uuf9v-00039p-BC
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 10:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933456Ab3GDIoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 04:44:54 -0400
Received: from ppsw-mx-f.csi.cam.ac.uk ([131.111.8.149]:46843 "EHLO
	ppsw-42.csi.cam.ac.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755550Ab3GDIow (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 04:44:52 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:40541)
	by ppsw-42.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:fanf2) id 1Uuf9m-0002go-9B (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 04 Jul 2013 09:44:50 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1Uuf9m-0006CH-EV (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 04 Jul 2013 09:44:50 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <CANQwDwcneUzzXS-Du-3Aca3-Vp8ycSzVqUv1rVRVhaNUWfeokw@mail.gmail.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229562>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870870024-182335467-1372927490=:26246
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
> On Wed, Jul 3, 2013 at 11:59 PM, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> > Tony Finch wrote:
>
> >> +@extra_breadcrumbs::
> >> +     Additional links to be added to the start of the breadcrumb trai=
l,
> >> +     that are logically "above" the gitweb projects list. For example=
,
> >> +     links to the organization and department which host the gitweb
> >> +     server. Each element of the list is a reference to an array,
> >> +     in which element 0 is the link text and element 1 is the
> >> +     target URL.
> >
> > Is arbitrary HTML permitted in the link text?

I had the same question when I was wondering about abusing $home_link_str
to do this without a patch :-)

> > I think it makes sense to permit it for consistency with $home_link_str=
,
> > but it might be worth mentioning in the manpage so the administrator
> > knows not to set it to something user-controlled --- e.g.:

I left this detail out of the man page for consistency with the
documentation for $home_link_str.

> Nb. it would be nice to have relation of @extra_breadcrumbs with
> $home_link_str explained.

I will make that clearer.

Thanks for reviewing the patch.

Tony.
--=20
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Forties, Cromarty: East, veering southeast, 4 or 5, occasionally 6 at first=
=2E
Rough, becoming slight or moderate. Showers, rain at first. Moderate or goo=
d,
occasionally poor at first.
--1870870024-182335467-1372927490=:26246--
