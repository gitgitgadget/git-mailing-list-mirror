From: Stefan Zager <szager@google.com>
Subject: submodule update --force
Date: Wed, 9 May 2012 16:55:40 -0700
Message-ID: <CAHOQ7J9xCYL=x=_nbq-3ksC2nF7L0=kxu9JX6M60xM-Bxmyfag@mail.gmail.com>
References: <CAHOQ7J8r4m2rz57BdkM9CADHdHE1yDFwExyF87u=DCEXjqzcqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 01:55:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSGjU-0002st-Cx
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 01:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761304Ab2EIXzn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 19:55:43 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59855 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761292Ab2EIXzm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 19:55:42 -0400
Received: by lbbgm6 with SMTP id gm6so647773lbb.19
        for <git@vger.kernel.org>; Wed, 09 May 2012 16:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding:x-system-of-record;
        bh=i+vPpreLbWii8j7JCFg3q3UmpSwph1EpbfDC6UmtqME=;
        b=AE96+JNFg006tZrzaBy76nb40A52nkJlozA/B44+M1hFX/IuizO1TeVav6nDBqhKm3
         FXHQhxz239Ht/eThQaSugHblfyemRb0dQfNzPFM57Im8wjTtJ+g3a8eJxtlEbC4sRa+3
         ThcI3jBaw8wABj6y30pKtMMkyjO2ZMzZRp2Z0BjVdoDaCBQixi5qfBN996ClC/wIwAQE
         TE+JKufPf6W6Z5hYpQUuGzTgqty1uVndykc9TlA7NxSaCmezVEzJDhY04KfQ23oV7LwH
         00tg5G/fGs8NajaEfyE8KmQzx3m4hNoJ7xg/X6mS1Yk3zmtakUZ4a/szugYvUJYDUDao
         p6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=i+vPpreLbWii8j7JCFg3q3UmpSwph1EpbfDC6UmtqME=;
        b=RhfnTcOuB7bt6GaUFqwgY7v3rZ4mv4UBAPuHl5/9G5BtWOoJixiqI/WEyrBsEEIRkC
         z5/MlY23YVfo/wZneZejuiBfuxLIx5bk1ox1BFEwGz6W+s7+PQUSadLyZ3GvBBkZSHNo
         fZ8Sws9udCEZxliVc7XGLJhsExNPUbXDQvl2T9ij3F6PVicy3pRYYAi/I8IQkQtsqdU1
         guiva25WOH50HwzXLhbpRqfpw7c6U9HPH1+vUYpxPS+MeZvEBy17DEh6PA8slP6n2PiN
         XGjr0R3ybW5o9gC7sR72fTSH+VbxKoU/GFBcT4xLDiGI8qKLOxluXh58EBiK6wyTJxAd
         M4iw==
Received: by 10.152.147.100 with SMTP id tj4mr1949105lab.39.1336607740835;
        Wed, 09 May 2012 16:55:40 -0700 (PDT)
Received: by 10.152.147.100 with SMTP id tj4mr1949100lab.39.1336607740752;
 Wed, 09 May 2012 16:55:40 -0700 (PDT)
Received: by 10.112.59.135 with HTTP; Wed, 9 May 2012 16:55:40 -0700 (PDT)
In-Reply-To: <CAHOQ7J8r4m2rz57BdkM9CADHdHE1yDFwExyF87u=DCEXjqzcqw@mail.gmail.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQn1EtTEv2Fl5x72bS/phA6btjHZGwNE51bRVSra7b4J8bosplrmTUTjGofy/n4rRW59eFK2lvvXnv0viWMdag0NHNjbV1KQxw6NX/hdPJNi/ay3gKQfr4QgrjZvVIrYLb7uiGNRZWOvFzCgctMjfhLfp7IYmQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197532>

I have a situation where I have a full source tree -- top-level
repository and all submodules -- generated via `git clone -n`. =A0So,
the directory structure and .git directories are intact, but no actual
source files have been checked out.

If I run `git submodule update` from the top level, some submodules
get checked out, but not others. =A0Weird.

Root cause is in the cmd_update function in git-submodule.sh, which
does essentially this:

sha1 =3D submodule revision as registered in top-level module
subsha1 =3D HEAD revision in submodule checkout

if test "$subsha1" !=3D "$sha1"
then
=A0 =A0 git checkout $sha1
fi

In the submodule checkouts, HEAD is refs/heads/master. =A0In *some* of
the submodules, the revision registered in the top-level repository is
the same as HEAD. =A0So, for those submodules, `git submodule update`
run from the top level is a no-op, because $sha1 =3D $subsha1. =A0That'=
s
true even though there are no actual source files checked out in the
submodule.

=46or other submodules, $sha1 !=3D $subsha1, and `git submodule update`
checks out the source code as expected.

Confusing!

According to the docs for git-submodule:

=A0 =A0 =A0 =A0-f, --force
=A0 =A0 =A0 =A0 =A0 =A0This option is only valid for add and update com=
mands. When
running add, allow adding an otherwise ignored
=A0 =A0 =A0 =A0 =A0 =A0submodule path. When running update, throw away =
local
changes in submodules when switching to a different
=A0 =A0 =A0 =A0 =A0 =A0commit.

I'd like to propose amending the documentation thusly:

According to the docs:

=A0 =A0 =A0 =A0-f, --force
=A0 =A0 =A0 =A0 =A0 =A0This option is only valid for add and update com=
mands. When
running add, allow adding an otherwise ignored
=A0 =A0 =A0 =A0 =A0 =A0submodule path. When running update, throw away =
local
changes in submodules when switching to a different
=A0 =A0 =A0 =A0 =A0 =A0commit; if not switching to a different commit, =
a checkout
to HEAD will still be run.

=2E.. and here's the patch to implement it:

diff --git a/git-submodule.sh b/git-submodule.sh
index 64a70d6..8b045d9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -536,7 +536,7 @@ Maybe you want to use 'update --init'?")"
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "$(eval_gettext "Un=
able to find current
revision in submodule path '\$sm_path'")"
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi

- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test "$subsha1" !=3D "$sha1"
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test "$subsha1" !=3D "$sha1" -o -n "$f=
orce"
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 then
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 subforce=3D$force
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # If we don't already h=
ave a -f flag and the
submodule has never been checked out



Thoughts?

Thanks,

Stefan
