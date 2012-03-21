From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: GSOC on designing a faster index format
Date: Wed, 21 Mar 2012 23:20:58 +0100
Message-ID: <87y5qtmw8l.fsf@thomas.inf.ethz.ch>
References: <CAAQUJYbr+RbcpRzKqK+s+9sXezQuFR-S=OdSdnTYTtURDqKRhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Calvin Deutschbein <deutschbeinc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 23:21:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SATuE-0004fs-GZ
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 23:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162Ab2CUWVG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Mar 2012 18:21:06 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:10281 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965102Ab2CUWVD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Mar 2012 18:21:03 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 21 Mar
 2012 23:20:57 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (80.219.158.96) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 21 Mar
 2012 23:20:59 +0100
In-Reply-To: <CAAQUJYbr+RbcpRzKqK+s+9sXezQuFR-S=OdSdnTYTtURDqKRhQ@mail.gmail.com>
	(Calvin Deutschbein's message of "Wed, 21 Mar 2012 15:39:45 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [80.219.158.96]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193624>

Hi Calvin,

Please also read/follow the other threads on the same topic

  http://thread.gmane.org/gmane.comp.version-control.git/193541
  http://thread.gmane.org/gmane.comp.version-control.git/193550

Calvin Deutschbein <deutschbeinc@gmail.com> writes:

> Verifying
> correctness, it would seem, can generally be done without a rewrite
> and isn't necessarily exhaustively necessary with every index edit if
> efficiency is becoming of utmost concern. =C2=A0This then, would seem=
 to
> indicate that hashing the index wouldn't always be necessary. =C2=A0I=
s it
> done then just for 100% security in index correctness?

It's basically the *easiest* way to make sure the index was not
corrupted.  It also happens to be plenty fast enough for not-so-big
projects.

> I also appreciate the later mention of the importance of being as eas=
y
> to parse as possible, as I tend to find such coding an intellectually
> engaging exercise and this represents a valid reason to invest
> resources in such a pursuit.  Unfortunately, I'm not entirely familia=
r
> with other git-reading programs.  Is there a specific set of such
> programs I should look into?

At least jgit and libgit2, the former because it represents a large use=
r
base (more or less everybody using Eclipse and/or Gerrit) and the latte=
r
because their life is already hard enough with the current git internal=
s
;-)

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
