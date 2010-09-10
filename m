From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How do I .gitignore files starting with "#"?
Date: Fri, 10 Sep 2010 21:33:17 +0200
Message-ID: <201009102133.19427.jnareb@gmail.com>
References: <AANLkTimaPrDX4rn2xRYyLn-bh2rB-TgKaEtGSQ+JxSnM@mail.gmail.com> <m38w39mnyd.fsf@localhost.localdomain> <AANLkTimw5pzdGjiPps-CE1PJS1sBXYw3dE4vhdwm1CYP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bruce Korb <bruce.korb@gmail.com>, git@vger.kernel.org
To: "=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason" 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 21:33:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou9Lq-0004x5-88
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 21:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab0IJTd3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 15:33:29 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:32941 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178Ab0IJTd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 15:33:28 -0400
Received: by eyb6 with SMTP id 6so1993514eyb.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 12:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AaRYN/nuB1uE4BfC4kdsLiTVszDjKRpoXEfH7Xnz00s=;
        b=MZgL25A1IbSwJBgcxWvaBduNNdDln7+Jc9WREzucskwQP9mPohfroG0mmXKYBmYtZu
         tnaXU8AAnUhUVy/zlVStbrK7PMpA5TxzdvxkaOlXeo5A1ouwRCdcQnB0aA0mxVuRExGO
         5s46YYkgV68zOFz0MDBPVRg98imXrS4e2+o+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=W9lBE5p1rgVOrm79YfDjJsrQfNtFOszee6uL5m2R+wG4dFhC0RZeVrbnGU8HNBtV94
         5X05CynYELEKfyjiAU2EyF1ZK/EKW8GA0uMQgAgxFuwcMr1pnn+ryBkk6kUy/6MXf62x
         X0OEYB40CyuKr5K8tOaSaYMjQFfTdxC8GUpBs=
Received: by 10.14.127.74 with SMTP id c50mr679744eei.14.1284147206868;
        Fri, 10 Sep 2010 12:33:26 -0700 (PDT)
Received: from [192.168.1.13] (abuz124.neoplus.adsl.tpnet.pl [83.8.197.124])
        by mx.google.com with ESMTPS id u9sm4402064eeh.17.2010.09.10.12.33.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Sep 2010 12:33:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimw5pzdGjiPps-CE1PJS1sBXYw3dE4vhdwm1CYP@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155959>

On Fri, 10 Sep 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Fri, Sep 10, 2010 at 18:52, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> > Bruce Korb <bruce.korb@gmail.com> writes:
> >
> > > After trying lots of variations, I found it to be:
> > >
> > > \#*
> > >
> > > Not obvious and not easy to look up. =C2=A0Please add it to your
> > > .git/info/exclude sample text. =C2=A0Thanks!
> >
> > Well, it is quite obvious to me, as escaping special characters usi=
ng
> > backslash is typical in Unix tools. =C2=A0But you are right that th=
is needs
> > to be documented.
> >
> > Perhaps something like this? =C2=A0I am not sure about example in
> > .git/info/exclude skeleton
> >
> > -- >8 --
> > Subject: [PATCH] Document escaping of special characters in gitigno=
re files
> >
> > Requested-by: Bruce Korb <bruce.korb@gmail.com>
> > Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> > ---
> > =C2=A0Documentation/gitignore.txt | =C2=A0 =C2=A06 ++++++
> > =C2=A0templates/info--exclude =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
> > =C2=A02 files changed, 7 insertions(+), 0 deletions(-)
> >
> > diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.=
txt
> > index 7dc2e8b..67ae4d0 100644
> > --- a/Documentation/gitignore.txt
> > +++ b/Documentation/gitignore.txt
> > @@ -98,6 +98,12 @@ Patterns have the following format:
> > =C2=A0 =C2=A0For example, "/{asterisk}.c" matches "cat-file.c" but =
not
> > =C2=A0 =C2=A0"mozilla-sha1/sha1.c".
> >
> > + - You can escape special characters using backslash.
> > + =C2=A0 For example, "{backslash}#*" matches files beginning in `#=
`
> > + =C2=A0 (otherwise it would be considered comment),
> > + =C2=A0 and "{backslash}!*{backslash}?" matches files starting wit=
h `!`
> > + =C2=A0 (negate pattern prefix) and ending with `?` (glob wildcard=
).
> > +
>=20
> Maybe fix this too in the same manpage:
>=20
>     A line starting with # serves as a comment.
>=20
> To:
>=20
>     A line starting with # serves as a comment. Use \# for a literal =
#
> character. See ...

Something like this?
-- >8 --
Subject: [PATCH] Document escaping of special characters in gitignore f=
iles

Requested-by: Bruce Korb <bruce.korb@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/gitignore.txt |    6 ++++++
 templates/info--exclude     |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 7dc2e8b..67ae4d0 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -98,6 +98,12 @@ Patterns have the following format:
    For example, "/{asterisk}.c" matches "cat-file.c" but not
    "mozilla-sha1/sha1.c".
=20
+ - You can escape special characters using backslash.
+   For example, "{backslash}#*" matches files beginning in `#`
+   (otherwise it would be considered comment),
+   and "{backslash}!*{backslash}?" matches files starting with `!`
+   (negate pattern prefix) and ending with `?` (glob wildcard).
+
 An example:
=20
 --------------------------------------------------------------
diff --git a/templates/info--exclude b/templates/info--exclude
index a5196d1..2ebaf0d 100644
--- a/templates/info--exclude
+++ b/templates/info--exclude
@@ -4,3 +4,4 @@
 # exclude patterns (uncomment them if you want to use them):
 # *.[oa]
 # *~
+# \#*#
--=20
1.7.2.1
