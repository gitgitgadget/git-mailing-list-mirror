From: avarab@gmail.com
Subject: [PATCH 0/2] [PULL] ab/i18n-gettextize & translations
Date: Sat,  4 Sep 2010 00:49:25 +0000
Message-ID: <4c8197a9.1707e30a.3f10.7149@mx.google.com>
References: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Sam Reed <sam@reedyboy.net>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 04 02:50:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orgx9-0006Sz-5J
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 02:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab0IDAts convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 20:49:48 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:46695 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab0IDAts (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 20:49:48 -0400
Received: by wwd20 with SMTP id 20so13162wwd.1
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 17:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=bw7x77aRygx+bsW4yBHIeg4GmeXSos3qdRePo1RrII4=;
        b=tDCq+YG8ckyPQwl5LKHk7FZebQo2b53oYJ9lESdNsk5nVxZSJ2+Bwm2kp3+F1ZuJ7r
         upQk3XbokwhNYliC+gxtpGEGLQZqwOLbGeL0Jrc+ig5cMaQ6YMT6PxkVQHgwinJjpQw6
         Hg/zKXGNukV/NcjOa8c/crkfed62bU89dkTwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=nu2cdQMp75TOPiMBH7u32CPdOKKo0GKVMrSajtixJ0TAqFNY9vR5Tzfwzj+ou0nWH+
         6iF4RC9RHr7t3hkVXcN04S8osviGPvScbmJtXv5gQB1w5QUkkSUoattbJSfDIvwVileG
         FSIO6zufgmCqmSampjPGOandNN9kRPJxLwm70=
Received: by 10.227.129.13 with SMTP id m13mr208168wbs.105.1283561386405;
        Fri, 03 Sep 2010 17:49:46 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm2108432wbb.22.2010.09.03.17.49.45
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Sep 2010 17:49:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.336.g704fc
In-Reply-To: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155292>

=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

On Fri, Sep 3, 2010 at 18:22, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:

> What I'm working on, which should not be pulled at this time:
>
> ab/i18n-gettextize:
> http://github.com/avar/git/compare/ab/i18n...ab/i18n-gettextize
>
>  Updated version of the gettextize series rebased on master. No
>  longer needs its own builtin.h patches (since ab/i18n itself now
>  depends on it). I'm also fixing some minor issues raised on-list.
>
>  I'm also going to add the aforementioned GETTEXT_POISON
>  functionality to ab/i18n to make sure this series is OK.
>
> ab/i18n-add-translations:
> http://github.com/avar/git/compare/ab/i18n-gettextize...ab/i18n-add-t=
ranslations
>
>  Adds German and British English translations. More additions welcome=
=2E

The ab/i18n-gettextize series is now ready. And since I've tested it
with the new GETTEXT_POISON support I'm confident that it
works. Please pull it from:

    git://github.com/avar/git.git ab/i18n-gettextize

Web view:

    http://github.com/avar/git/compare/ab/i18n...ab/i18n-gettextize

Changes to the series since last time are this fixup patch:

    diff --git a/builtin/fetch.c b/builtin/fetch.c
    index fd0a40d..98fb202 100644
    --- a/builtin/fetch.c
    +++ b/builtin/fetch.c
    @@ -349 +349 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
    -                       kind =3D _("branch");
    +                       kind =3D "branch";
    @@ -353 +353 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
    -                       kind =3D _("tag");
    +                       kind =3D "tag";
    @@ -357 +357 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
    -                       kind =3D _("remote branch");
    +                       kind =3D "remote branch";
    @@ -397 +397 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
    -                               TRANSPORT_SUMMARY_WIDTH, *kind ? ki=
nd : _("branch"),
    +                               TRANSPORT_SUMMARY_WIDTH, *kind ? ki=
nd : "branch",

This changed what was stored in commit messages, so it was *really*
breaking the plumbing. This was turned up with the new GETTEXT_POISON
debug support.

Then there are these two commits which are new in the series:

    7cd45c32 * gettextize: git-fetch split up "(non-fast-forward)" mess=
age
    8b47940b * gettextize: git-fetch update_local_ref messages

Reproduced here for review:
   =20
    commit 8b47940bc4081a760eb772cdea76f89ca0be83cf
    Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
    Date:   Fri Sep 3 23:58:01 2010 +0000
   =20
        gettextize: git-fetch update_local_ref messages
       =20
        Translate a "[rejected]" message spotted by Jeff King, and othe=
r
        things in update_local_ref along with it.
       =20
        Reported-by: Jeff King <peff@peff.net>
        Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com>
   =20
    diff --git a/builtin/fetch.c b/builtin/fetch.c
    index 98fb202..3d2c45d 100644
    --- a/builtin/fetch.c
    +++ b/builtin/fetch.c
    @@ -265 +265 @@ static int update_local_ref(struct ref *ref,
    -                       what =3D "[new tag]";
    +                       what =3D _("[new tag]");
    @@ -269 +269 @@ static int update_local_ref(struct ref *ref,
    -                       what =3D "[new branch]";
    +                       what =3D _("[new branch]");
    @@ -275 +275 @@ static int update_local_ref(struct ref *ref,
    -                       r ? "  (unable to update local ref)" : "");
    +                       r ? _("  (unable to update local ref)") : "=
");
    @@ -288 +288 @@ static int update_local_ref(struct ref *ref,
    -                       pretty_ref, r ? "  (unable to update local =
ref)" : "");
    +                       pretty_ref, r ? _("  (unable to update loca=
l ref)") : "");
    @@ -300 +300 @@ static int update_local_ref(struct ref *ref,
    -                       r ? "unable to update local ref" : "forced =
update");
    +                       r ? _("unable to update local ref") : _("fo=
rced update"));
   =20
And:
   =20
    commit 7cd45c32ef93c949330b7899821f184ccae52900
    Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
    Date:   Fri Sep 3 23:59:27 2010 +0000
   =20
        gettextize: git-fetch split up "(non-fast-forward)" message
       =20
        Split up the "(non-fast-forward)" message from printf directive=
s and
        make it translatable.
       =20
        Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com>
   =20
    diff --git a/builtin/fetch.c b/builtin/fetch.c
    index 3d2c45d..792123c 100644
    --- a/builtin/fetch.c
    +++ b/builtin/fetch.c
    @@ -303,3 +303,3 @@ static int update_local_ref(struct ref *ref,
    -               sprintf(display, "! %-*s %-*s -> %s  (non-fast-forw=
ard)",
    -                       TRANSPORT_SUMMARY_WIDTH, "[rejected]", REFC=
OL_WIDTH, remote,
    -                       pretty_ref);
    +               sprintf(display, "! %-*s %-*s -> %s  %s",
    +                       TRANSPORT_SUMMARY_WIDTH, _("[rejected]"), R=
EFCOL_WIDTH, remote,
    +                       pretty_ref, _("(non-fast-forward)"));

And finally (and attached) to make use of this all the
ab/i18n-add-translations series adds German and British English
Translations:

    git://github.com/avar/git.git ab/i18n-add-translations

Web view:

    http://github.com/avar/git/compare/ab/i18n-gettextize...ab/i18n-add=
-translations

1771 lines for the British English one to translate 3 strings is a bit
of an overkill. But it seems that projects that use gettext usually
include the untranslated strings too. E.g. glibc.git does that for its
en_GB.po file.

Maybe we can prune out entries with msgstr "". That seems to work on
GNU, it probably works on all other gettext implementations.

Note that these patches might not appear at all on the list, since
they might bump into the maximum message length on the list.

Jan Kr=C3=BCger (1):
  po/de.po: add German translation

Sam Reed (1):
  po/en_GB.po: add British English Translation

 po/de.po    | 1888 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 po/en_GB.po | 1771 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 3659 insertions(+), 0 deletions(-)
 create mode 100644 po/de.po
 create mode 100644 po/en_GB.po

--=20
1.7.2.2.336.g704fc
