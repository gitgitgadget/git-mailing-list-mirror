From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Should GIT_AUTHOR_{NAME,EMAIL} set the tagger name/email?
Date: Sat, 01 Sep 2012 17:57:21 +0200
Message-ID: <m2ehmlwxb2.fsf@igel.home>
References: <CACBZZX7Ud8Xx225ss6SYqZFXyW0FG2XJimBWdvW_NuMqn8yOnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 17:58:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7q5w-0007rT-FG
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 17:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580Ab2IAP6f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Sep 2012 11:58:35 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:54564 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755565Ab2IAP5a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 11:57:30 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3X8MX466xsz3hhdl;
	Sat,  1 Sep 2012 17:57:24 +0200 (CEST)
X-Auth-Info: 2oPAy0SrB6+OTSUy3of3jXe8PXcNlkN7P7HhktO/Z8I=
Received: from igel.home (ppp-88-217-112-52.dynamic.mnet-online.de [88.217.112.52])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3X8MX45h9kzbbgd;
	Sat,  1 Sep 2012 17:57:24 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 00697CA2A5; Sat,  1 Sep 2012 17:57:23 +0200 (CEST)
X-Yow: Now I can join WEIGHT WATCHERS!
In-Reply-To: <CACBZZX7Ud8Xx225ss6SYqZFXyW0FG2XJimBWdvW_NuMqn8yOnA@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 1 Sep
 2012 17:34:12
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204636>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>     git --no-pager show tag-name-1 | grep ^Author

A tag doesn't have an author, it has a tagger.  This shows the author o=
f
the *commit*.

>     GIT_AUTHOR_NAME=3D"Tag Test User"
> GIT_AUTHOR_EMAIL=3D"tagtest@example.com" git tag -a -m"another annota=
ted
> tag" tag-name-2

The tagger is controlled by the committer info.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
