From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH 3/4] gitweb: omit the repository owner when it is unset
Date: Mon, 5 Aug 2013 12:36:54 +0100
Message-ID: <alpine.LSU.2.00.1308051220170.6019@hermes-2.csi.cam.ac.uk>
References: <20130714234915.GB19057@google.com> <E1Uyete-0003Sv-OI@hermes-2.csi.cam.ac.uk> <CANQwDwdA5VnywJmoNpCX7s=hH7tmUDUmRuak12W7BXOQtqRoQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870870024-408836588-1375702614=:6019"
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 13:37:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6J5w-0002kH-9f
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 13:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926Ab3HELg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 07:36:56 -0400
Received: from ppsw-mx-f.csi.cam.ac.uk ([131.111.8.149]:54437 "EHLO
	ppsw-42.csi.cam.ac.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752392Ab3HELg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 07:36:56 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:39500)
	by ppsw-42.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:fanf2) id 1V6J5q-0002Bx-7S (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 05 Aug 2013 12:36:54 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1V6J5q-0005yb-8B (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 05 Aug 2013 12:36:54 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <CANQwDwdA5VnywJmoNpCX7s=hH7tmUDUmRuak12W7BXOQtqRoQw@mail.gmail.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231648>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870870024-408836588-1375702614=:6019
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
> On Tue, Jul 2, 2013 at 6:24 PM, Tony Finch <dot@dotat.at> wrote:
>
> > On the repository summary page, leave the whole owner line out if
> > the repo does not have an owner, rather than displaying a labelled
> > empty field..
>
> Note that if $omit_owner is true, whole _column_ is skipped.

There are two places where the owner is displayed: on the list of
projects, and on each project's summary page. This change affects the
summary page (where it removes a row, not a column) and it leaves the
projects list alone. I'll make that clearer in the commit message (and fix
the extraneous dot).

Tony.
--=20
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Forties, Cromarty: East, veering southeast, 4 or 5, occasionally 6 at first=
=2E
Rough, becoming slight or moderate. Showers, rain at first. Moderate or goo=
d,
occasionally poor at first.
--1870870024-408836588-1375702614=:6019--
