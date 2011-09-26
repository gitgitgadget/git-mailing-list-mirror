From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.7.rc3
Date: Mon, 26 Sep 2011 10:48:56 -0700 (PDT)
Message-ID: <m3bou7p542.fsf@localhost.localdomain>
References: <7vhb42su6f.fsf@alter.siamese.dyndns.org>
	<CACBZZX77ZhdS1cyiYpjJcuvSnJsv15FUumPWeZOcwh_b41c2FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Sep 26 19:49:22 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1R8FIu-0003uU-NU
	for glk-linux-kernel-3@lo.gmane.org; Mon, 26 Sep 2011 19:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296Ab1IZRtC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 26 Sep 2011 13:49:02 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41190 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997Ab1IZRtA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2011 13:49:00 -0400
Received: by eya28 with SMTP id 28so3821921eya.19
        for <multiple recipients>; Mon, 26 Sep 2011 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=OHeKjaO/HqQ+csI8ncKhwe3SojoTCos/gSOKnDR6ZXE=;
        b=grLyaFlWnZlT/x7vi+W56cMemZxx2d68H3nkjFR8CmkFrkwaS32pICP0rlIHThHEvq
         PNRiQG5dMzHfozv0u8560r/Qqjg7ofV7IyBcfF2tz4+YFeEaLkuDv8doJsj6BPVMjU77
         cqSvD5pA4Ugsv4s2kMNnA5tx/eR58z9uHi2ao=
Received: by 10.14.17.212 with SMTP id j60mr832320eej.169.1317059337210;
        Mon, 26 Sep 2011 10:48:57 -0700 (PDT)
Received: from localhost.localdomain (abwm119.neoplus.adsl.tpnet.pl. [83.8.236.119])
        by mx.google.com with ESMTPS id e4sm62351790eec.10.2011.09.26.10.48.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Sep 2011 10:48:56 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8QHmOIl008898;
	Mon, 26 Sep 2011 19:48:34 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8QHmDqW008892;
	Mon, 26 Sep 2011 19:48:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CACBZZX77ZhdS1cyiYpjJcuvSnJsv15FUumPWeZOcwh_b41c2FQ@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182140>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Sat, Sep 24, 2011 at 01:41, Junio C Hamano <gitster@pobox.com> wro=
te:
>=20
> > Also the following public repositories all have a copy of the v1.7.=
7-rc3
> > tag and the master branch that the tag points at:
>=20
> The 1.7.7-rc* series still doesn't compile on older Red Hat machines
> because 4c1be38b4a236403a329187acb70591a7fd92150 hasn't been included
> in it.
>=20
> Could you please include that in the final 1.7.7? It would be a PITA
> to have to work around that.

It looks like I was too optimistic in

  "Re: What's cooking in git.git (Sep 2011, #06; Wed, 21)"
  http://thread.gmane.org/gmane.comp.version-control.git/181885/focus=3D=
181935

JN> Yes, that is what I mean... but that it is only because I use old
JN> version of asciidoc (7.1.2).
JN> =20
JN> "make doc" (which is part of "make rpm") fails on my box with
JN>=20
JN>       ASCIIDOC gitnamespaces.html
JN>   ERROR: gitnamespaces.txt: line 9: second section must be named SY=
NOPSIS
JN>   make[1]: *** [gitnamespaces.html] Error 1
JN>=20
JN> > If the reason the documentation fix for "master" is needed is bec=
ause a
JN> > new feature scheduled for the upcoming release has broken documen=
tation,
JN> > then wouldn't we need the fix before the release, whether you are=
 working
JN> > on your patch or not? How can it be not urgent if that is the cas=
e?
JN> >=20
JN> > On my boxes with recent Debian, Ubuntu, and F14, I am not sufferi=
ng from
JN> > the lack of the workaround, but if distros need the workaround, t=
hen the
JN> > time to apply it is now, not post release.
JN>=20
JN> I don't think _modern_ distributions need this workaround... asciid=
oc 8.4.5
JN> which fixed the issue with "Synopsis" section was released 2009-05-=
24:
JN>=20
JN> http://www.methods.co.nz/asciidoc/CHANGELOG.html
JN>=20
JN>   Version 8.4.5 (2009-05-24)
JN>   --------------------------
JN>   Additions and changes
JN>   ~~~~~~~~~~~~~~~~~~~~~
JN>=20
JN>     * Added manpage "Name" and "Synopsis" section title customizati=
on to
JN>       languages configuration files.
JN>     * "Synopsis" manpage section no longer mandatory.
JN>   [...]

--=20
Jakub Nar=C4=99bski
