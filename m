From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [bug] Possible Windows 'git mv' bug
Date: Mon, 1 Feb 2016 07:32:19 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602010723510.2964@virtualbox>
References: <CANkmNDd8GJmKGw9zToKS1ML3tg9Cx2iYQM0E8iHCO2TuQfwmAQ@mail.gmail.com> <56AE2DBF.1010502@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1115973888-1454308341=:2964"
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 07:32:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQ82G-0007cm-MK
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 07:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbcBAGcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 01:32:24 -0500
Received: from mout.gmx.net ([212.227.15.19]:62049 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734AbcBAGcX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 01:32:23 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MOwbP-1aT8ZG16nf-006LHV; Mon, 01 Feb 2016 07:32:21
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56AE2DBF.1010502@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:a9tlAKTRAI1K7prQGAhQSaqU4nM9Zx0PT3i5uQzLHPnraYRsrbQ
 AF+645vn78XsG0HaipHu6TrDMVJwUJWWplhIludyEEtVkWGXX9fv05+8Onc+iT+QhQWy3gq
 PjuptcoM5gv0R9/PeZPjknPxU3N/AF568sRBmNncqrmtk+/03Ku13xXxyuoF7S/ejcprUFL
 lZKWzzxXgl1iZoWSz5stQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3zp652MHM5Q=:jHV2UhSRqEVvpo7DJFJ0KH
 +SNGu4V5yXMZpwIvQUVnr98311oZZ6mkw31j+skNJokwXUG//FZQmxkkK4RVwogSxvdh2Q46c
 r7jPsRCq1dwoq/d3WhXyIUfyoaJUOICBWM9o0Rp1Y6WekLmOKPVl02R/5vl1iCd1gaa9gbu3T
 jtPbVf4MrSAGeK8A6tzIONmwFE0gWmKFVD2xw54sny7wFpssj7YcHGam1K9IcbSerFT2ZCiMO
 7Qj0MVIE1vJmCOoh2iffnaEyM2OWIXW1gdmDu+JHuRMg2NUmmo3+U2W75QFEnEjpHXFlMPkaT
 bPsl/g7xbJJpYGdIlJBDxs+Q7A5zwuBJPLj9dVR8pjhpMK7BI/Iy7ZVNPrzhiB+5V3h8XIQkS
 B093we1nGsmwC10rZA4s8VOqjjZvf+pykOV9fFwg1/dkGBEhZgLjW/kfTj5PNivHe/t5UYj2Y
 qSI41LGfAFIJ8cGFrrSSkykFAzbM9tyHie+/lcLd4TBQdir8M0kNmSUVy521Y+icFhfDT5jVY
 g+bwW/gmToDeCIdbl4PPd68rQDfnksnUp4Quj23gCBzA8MF8PNqKceOPck+j11dKa7pQedJch
 Aizp04HdWdd3470D1YcanojqdYwGZRjdTOpeLWb68EziqgjXOnUDOijgr2XmJlM492nQMjsdv
 iYf3Q8xAwpBthlTDfIRojD6PWRvLbI9igu9d1S97U0MFJ0OUNJLjaEIeZvYwhOUDUSG8aV4I1
 Z/Sjxr7aC3e69OnhAg5ta68aIy11zpWzbEcH1XSlCN1tmHRgU/PdGu7J5AYTpwGwbSqogZtx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285189>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1115973888-1454308341=:2964
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Aaron,

On Sun, 31 Jan 2016, Torsten B=C3=B6gershausen wrote:

> On 2016-01-31 15.03, Aaron Gray wrote:
> >=20
> > I think I have found a possible difference in behaviour between
> > Windows git commandline distro and Linux git
> >=20
> > basically If I do a :-
> >=20
> >     git mv logger.h Logger.h
> >=20
> > I get the following :-
> >=20
> >     fatal: destination exists, source=3Dlib/logger.h, destination=3Dlib=
/Logger.h
> >=20
> > It looks and smells like a bug to me !

Thanks for your bug report. Having said that, I would like to suggest a
couple improvements for future reference:

Git for Windows' home page (https://git-for-windows.github.com/#contribute)
asks explicitly to please open tickets on Git for Windows' bug tracker
(https://github.com/git-for-windows/git/issues).

Also, at least one crucial bit of information is missing: the Git for
Windows version. Typically this is enough, but the Windows version is
often also crucial. To prevent crucial bits of information from missing, I
highly recommend volunteering information up front (in my mind, a good
rule of thumb is: spend as much care crafting your bug report and thinking
about what to include as you would wish the combined readership would
spend on helping you). If I may say so, I provided a good list of advices
to help crafting bug reports:
https://github.com/git-for-windows/git/wiki/Issue-reporting-guidelines

> Which version of Git are you using ?
> Because it is fixed in the latest version in Git and Git for Windows.

Another piece of advice I detail in our issue reporting guidelines is to
search the existing bug tracker (one purpose of the tracker is to keep
track of what has been reported and what has not yet been reported, after
all).

And indeed, I opened this ticket:

=09https://github.com/git-for-windows/git/issues/419

=2E.. whose initial report incidentally also lacks the crucial information
mentioned above! So I have to step up my own game, too.

This report *also* includes detailed information, though, in particular
that Torsten fixed this issue a long time ago, which suggests to me that
you are somehow still stuck with the 1.x train (run `git version` to find
out).

Ciao,
Johannes
--8323329-1115973888-1454308341=:2964--
