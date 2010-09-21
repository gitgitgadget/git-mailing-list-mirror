From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 000/160] [PULL] Update ab/i18n (again)
Date: Tue, 21 Sep 2010 09:09:59 +0200
Message-ID: <4C985A47.3030101@drmicha.warpmail.net>
References: <1285015029-23103-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?B?SmFuIEtyw7xnZXI=?= <jk@jk.gs>,
	Marcin Cieslak <saper@saper.info>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 09:10:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxwzL-0002jk-D0
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 09:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007Ab0IUHJy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Sep 2010 03:09:54 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48529 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755497Ab0IUHJx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 03:09:53 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BCC4A4D8;
	Tue, 21 Sep 2010 03:09:52 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 21 Sep 2010 03:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=anEf6TeMojXmquz6usMUyugSwls=; b=nSqvQvqYIRJvx4zHFNSP0O2H2lmWr0OgMkSZFY11t5p73+RQeaFE+Pa+UABuBt8bvernTv2j9vahfLnZ73NtOGIUo+rdhUtKz2WOxDA33Z32BOb431lKvPVvSUZ8MB18solZlXEhaP5axYl1Wt/ESQ269is4hfvA+4U59sAo6U0=
X-Sasl-enc: JmPW0410wOYobXIEFsM8hggCnu0znZOyHTTV3/NnwTtO 1285052992
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2127040AA33;
	Tue, 21 Sep 2010 03:09:51 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <1285015029-23103-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156692>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 20.09.2010 2=
2:37:
> Please pull an updated ab/i18n. The version you have now should be
> ejected in favor of it:
>=20
>    git://github.com/avar/git.git ab/i18n
>    http://github.com/avar/git/compare/87b5054...ab/i18n
>    http://github.com/avar/git/compare/87b5054...ab/i18n.patch
>=20
> Changes since last time, I can also send these to list on request. Bu=
t
> I don't think anyone wants a 160 patch flood:
>=20
>     http://github.com/avar/git/compare/ab/i18n-in-pu...ab/i18n
>     http://github.com/avar/git/compare/ab/i18n-in-pu...ab/i18n.patch
>=20
> The Gist of it is:
>=20
>   * I rewrote the huge monolithic commit that added NO_GETTEXT_POISON
>     prereqs to tests out of the series and added these changes to
>     individual tests instead. This was the practice I was using for
>     patches later in the series, but I hadn't updated the earlier
>     ones.
>=20
>     In the process of doing that I found some tests that were
>     mistakenly marked under NO_GETTEXT_POISON, mainly because the
>     tests failed due to earlier tests that rightly had
>     NO_GETTEXT_POISON. I did some re-arranging of test code to avoid
>     this.
>=20
>   * The PO files use line numbers again, and now have copyright
>     notices at the top.
>=20
>     It turns out that using msgmerge(1) is a major PITA without these
>     line numbers, msgmerge will compeletely screw up merges that
>     otherwise would have succeeded. E.g. it'll merge two similar but
>     unrelated messages together and mark them as fuzzy, but if it has
>     file/line number data it doesn't do this.
>=20
>     Our PO usage is now completely standard, i.e. we're not removing
>     anything that the normal GNU gettext tools add. I updated
>     po/README to reflect this.
>=20
>   * I did a msgmerge(1) on the existing PO files. This has left a lot
>     of messages marked as fuzzy. TRANSLATORS: Please check if this ha=
s
>     screwed up your translations.
>=20
> Further notes below. But here's a diffstat between this series and th=
e
> one that was merged into pu:
>    =20
>      command-list.txt          |    1 +
>      po/README                 |   43 +-
>      po/de.po                  | 1220 +++++++++++++++-
>      po/en_GB.po               | 2778 +++++++++++++++++++++++++++++++=
++++-
>      po/hi.po                  | 2777 +++++++++++++++++++++++++++++++=
++++-
>      po/is.po                  |   64 +-
>      po/pl.po                  | 2788 +++++++++++++++++++++++++++++++=
++++-
>      po/sv.po                  | 3492 +++++++++++++++++++++++++++++++=
++++++++++++++
>      t/t0201-gettext-poison.sh |   36 -
>      t/t0205-gettext-poison.sh |   36 +
>      t/t1200-tutorial.sh       |    3 +-
>      t/t2204-add-ignored.sh    |   45 +-
>      t/t3700-add.sh            |   15 +-
>      t/t5541-http-push.sh      |    2 +-
>      t/t7004-tag.sh            |   27 +-
>      t/t7500-commit.sh         |    3 -
>      t/t7501-commit.sh         |    7 +-
>      t/t7502-commit.sh         |   60 +-
>      t/t7508-status.sh         |   63 +-
>      wt-status.c               |    2 +-
>      20 files changed, 13143 insertions(+), 319 deletions(-)
>    =20
>=20
> Jan Kr=C3=BCger (1):
>   po/de.po: add German translation
>=20
> Marcin Cie=C5=9Blak (1):
>   po/pl.po: add Polish translation
>=20
> Peter Krefting (1):
>   po/sv.po: add Swedish translation
>=20
> Ramkumar Ramachandra (1):
>   po/hi.po: add Hindi Translation
>=20
> Sam Reed (1):
>   po/en_GB.po: add British English translation
>=20
> Thomas Rast (1):
>   gettext tests: locate i18n lib&data correctly under --valgrind
>=20
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (154):
>   t7004-tag.sh: re-arrange git tag comment for clarity

Would it be possible to split the infrastructure part from the actual
translations, i.e. have two or more dependent branches (which is
probably easier than reordering on a single branch)?

I know at least one locale where we're actually in the early stages of =
a
fundamental discussion about translation principles. Blocking the whole
series because of that makes no sense.

Also, the set of reviewers for infrastructure parts will be quite
different from that for individual translations.

Michael
