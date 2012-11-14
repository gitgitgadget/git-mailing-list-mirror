From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2012, #03; Tue, 13)
Date: Wed, 14 Nov 2012 11:02:29 -0800
Message-ID: <20121114190228.GA3860@sigill.intra.peff.net>
References: <20121113175205.GA26960@sigill.intra.peff.net>
 <50A2B14C.9040608@web.de>
 <50A2F17D.4010907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 20:02:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYiEb-0000BE-Iq
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 20:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423163Ab2KNTCf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2012 14:02:35 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48541 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423156Ab2KNTCf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 14:02:35 -0500
Received: (qmail 5390 invoked by uid 107); 14 Nov 2012 19:03:23 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Nov 2012 14:03:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2012 11:02:29 -0800
Content-Disposition: inline
In-Reply-To: <50A2F17D.4010907@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209739>

On Tue, Nov 13, 2012 at 08:18:53PM -0500, Mark Levedahl wrote:

> On 11/13/2012 03:45 PM, Torsten B=C3=B6gershausen wrote:
> >>* ml/cygwin-mingw-headers (2012-11-12) 1 commit
> >>  - Update cygwin.c for new mingw-64 win32 api headers
> >>
> >>  Make git work on newer cygwin.
> >>
> >>  Will merge to 'next'.
> >(Sorry for late answer, I managed to test the original patch minutes=
 before Peff merged it to pu)
> >(And thanks for maintaining git)
> >
> >Is everybody using cygwin happy with this?
> >
> >I managed to compile on a fresh installed cygwin,
> >but failed to compile under 1.7.7, see below.
> >Is there a way we can achieve to compile git both under "old" and "n=
ew" cygwin 1.7 ?
> >Or is this not worth the effort?
> >
> I found no version info defined that could be used to automatically
> switch between the old and current headers. You can always
>=20
>     make V15_MINGW_HEADERS=3D1 ...
>=20
> to force using the old set if you do not wish to update your installa=
tion.

Should we keep the code change, then, but not flip the default (i.e.,
make people on the newer version opt into it)? I am not clear on how
common the newer include system is. Of course, auto-detecting would be
the ideal.

-Peff
