From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Promoting Git developers
Date: Wed, 11 Mar 2015 14:28:03 -0700
Message-ID: <xmqqbnjz5in0.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
	<CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
	<xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
	<CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
	<xmqqmw3kuuod.fsf@gitster.dls.corp.google.com>
	<20150311073129.GA5947@peff.net>
	<CAPc5daUVVk+SYgwCj9JftzXgV7=9kPprdBPCWHS5XQOa5uF69Q@mail.gmail.com>
	<20150311075429.GA10300@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jason St. John" <jstjohn@purdue.edu>,
	Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 11 22:28:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVoAn-0001R8-Sm
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 22:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbbCKV2K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2015 17:28:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751300AbbCKV2H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2015 17:28:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 609693FE89;
	Wed, 11 Mar 2015 17:28:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=S2yy0wnz1rJ7
	2PsBil9aMZS81kc=; b=C4jz+XepYeZmjA20e7FAc6RXMTjcS8/HKN2Zi82p5zak
	RwJWBVKKGrgyRSozR05oBEbO/AuU7ADMvy+iJTslRKWk4GmP7hN6BOXHjUdsyST2
	CZuaMALiOqNi5PklBCCPRk4grjbhozlMFlhKfOfMvp2bXkJ0mfku5vxzXIKcZYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wODCNk
	oe+uSWXF+TCu1PpDaa1Dk6lwyOG9ByZOMLFUmygR0jvG2xbNnF3hYJoQJ9KszuQM
	OChcnB9Chp0gnN+mdZREWkouOoxEq+ki8PfeF0PVhHiSWzuzBk6s4kwUvbCz2o6S
	J6LePeFPbVCrlLC7YhdNeIjLxN/EUpb/uw7eY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 58B513FE88;
	Wed, 11 Mar 2015 17:28:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CDF5E3FE87;
	Wed, 11 Mar 2015 17:28:04 -0400 (EDT)
In-Reply-To: <20150311075429.GA10300@peff.net> (Jeff King's message of "Wed,
	11 Mar 2015 03:54:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 80DA836A-C835-11E4-A72C-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265339>

Jeff King <peff@peff.net> writes:

> Or something along those lines. The wording and indentation of the
> message could probably use tweaking. And there is a bash-ism in the
> script. :)

OK, I've updated the Announce script on the 'todo' branch.  The
announcement for 2.3.2 I sent out earlier as $gmane/264975 would
have looked like this.

-- >8 --
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Bcc: lwn@lwn.net
Subject: [ANNOUNCE] Git v2.3.2

The latest maintenance release Git v2.3.2 is now available at the
usual places.  It comprises of 41 non-merge commits since v2.3.1,
contributed by 19 people, 5 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.3.2'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

New contributors who made this release possible are as follows.
Welcome to the Git development community!

  Aleksander Boruch-Gruszecki, Aleksey Vasenev, Patrick Steinhardt,
  Ryuichi Kokubo, and Tom G. Christensen.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Alexander Kuleshov, Eric Sunshine, Jeff King, Jonathon Mah,
  Junio C Hamano, Kirill A. Shutemov, Kyle J. McKay, Matthieu Moy,
  Mike Hommey, Ramsay Allan Jones, Ren=C3=A9 Scharfe, Stefan Beller,
  Torsten B=C3=B6gershausen, and =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=
=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2.

----------------------------------------------------------------

Git v2.3.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.3.1
------------------

 * "update-index --refresh" used to leak when an entry cannot be
   refreshed for whatever reason.

 ...

 * Even though we officially haven't dropped Perl 5.8 support, the
   Getopt::Long package that came with it does not support "--no-"
   prefix to negate a boolean option; manually add support to help
   people with older Getopt::Long package.

Also contains typofixes, documentation updates and trivial code clean-u=
ps.

----------------------------------------------------------------

Changes since v2.3.1 are as follows:

Aleksander Boruch-Gruszecki (1):
      merge-file: correctly open files when in a subdir

Aleksey Vasenev (1):
      wincred: fix get credential if username has "@"

=2E..

=D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=
=D0=B2 (1):
      do not include the same header twice
