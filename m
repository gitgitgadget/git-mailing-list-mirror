From: Thomas Ackermann <th.acker@arcor.de>
Subject: Re: Outdated and broken online versions of user-manual.html
Date: Sat, 11 May 2013 07:48:10 +0000 (UTC)
Message-ID: <loom.20130511T092853-808@post.gmane.org>
References: <20130510190229.GA31708@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 09:48:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub4Xo-0004H2-1Z
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 09:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957Ab3EKHs2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 May 2013 03:48:28 -0400
Received: from plane.gmane.org ([80.91.229.3]:60282 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596Ab3EKHs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 03:48:27 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ub4XY-00044M-SH
	for git@vger.kernel.org; Sat, 11 May 2013 09:48:24 +0200
Received: from dslb-094-217-022-251.pools.arcor-ip.net ([94.217.22.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 May 2013 09:48:24 +0200
Received: from th.acker by dslb-094-217-022-251.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 May 2013 09:48:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 94.217.22.251 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223938>

W. Trevor King <wking <at> tremily.us> writes:

>=20
> I'm also surprised that I couldn't find a more obvious link to the
> manual from git-scm.com (I ended up taking a =E2=80=9CSee Also=E2=80=9D=
 link from
> gittutorial(7) [3]).  I'm not sure if this is intentional or not,
> since git-scm.com does prominently link Pro Git, and that overlaps
> fairly significantly with the manual.
>=20
> Folks with Git installed will generally have man pages, so it's not a
> big deal, but having current docs somewhere online to link against
> would be nice.  I'm also curious if I should be linking against a
> particular location.
>=20

IMHO user-manual is a natural step for a Git beginner after reading one=
=20
of the books like "Pro Git" and before he is ready to digest the man pa=
ges.=20
But up to now there are several problems with user-manual besides the
problems described by Trevor:
(1) Very poor html formatting (document type "book" causes
ugly TOCs per section and there's a "Part I" without a "Part II")
(2) Partly outdated content
(3) Sub-optimal structuring (to-do list as part of the document,
glossary not at the end of the document)
(4) User-manual.PDF uses an independent tool chain which makes it
harder to do improvements for user-manual.html and also is the only
pdf doc we are creating. IMHO we should remove this altogether.
(5) Large overlapping with the tutorials. IMHO all of the=20
tutorials should be blended into user-manual

I am currently working on (1)-(4) and then aiming for (5).
Comments are welcome ...

---
Thomas
