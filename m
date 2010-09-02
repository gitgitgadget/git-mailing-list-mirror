From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 10/25] gettextize: git-merge basic messages
Date: Thu, 2 Sep 2010 20:30:46 +0000
Message-ID: <AANLkTiksZykH4zDbdDReYYgJZk7gmZ_2g0v=9X_MP73p@mail.gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
	<1283456446-22577-11-git-send-email-avarab@gmail.com>
	<20100902200940.GB2531@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 22:30:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrGQx-00033X-Dk
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 22:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757019Ab0IBUas convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 16:30:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46268 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757002Ab0IBUar convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 16:30:47 -0400
Received: by mail-fx0-f46.google.com with SMTP id 13so606840fxm.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 13:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=og1atuFz1rGXU9bso8OBzoVj2Zh+CaoMGFw4N2NZG+g=;
        b=sRscwbQ6fYmR1lEUwciV9Nyximbfrw4yPeLKcd55gM3urWERtAXPWIdlvbwEwzYOAk
         c55z/80rf8HFiaq29Z1Zon6jqGwK7v3lfQ+Yb7sxy0B9HqISKejx4A2DZjIQw7jALKAS
         jj2/2yNVtNYX6mPGsxVI187DOhm5dfVrdtXDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SVQohGWqKqBKBDUxSwkAhMxf5oVg4+b+uB3aBf9/LWGd80ogMnC7DcLuITZvLufNTN
         PZyittg1UCDRmY0zrDXMYNbb0xpEiKvOi1kctvpRBBkoyxV4XNJkNtHNcj615LgNZzq1
         ALyAvxh6f0dQ7CDGbVsFre5+Gik2yxBnlCBXI=
Received: by 10.223.107.82 with SMTP id a18mr9161780fap.86.1283459446422; Thu,
 02 Sep 2010 13:30:46 -0700 (PDT)
Received: by 10.223.120.14 with HTTP; Thu, 2 Sep 2010 13:30:46 -0700 (PDT)
In-Reply-To: <20100902200940.GB2531@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155198>

On Thu, Sep 2, 2010 at 20:09, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -116,13 +116,13 @@ static struct strategy *get_strategy(const cha=
r *name)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exclude_cmds(&main_=
cmds, &not_strategies);
>> =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 if (!is_in_cmdlist(&main_cmds, name) && !is_in_=
cmdlist(&other_cmds, name)) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, "Could n=
ot find merge strategy '%s'.\n", name);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, "Availab=
le strategies are:");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, _("Could=
 not find merge strategy '%s'.\n"), name);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, _("Avail=
able strategies are:"));
>
> Another basic question (sorry for my ignorance): do translators prefe=
r
> whole paragraphs or line-by-line messages like this? =C2=A0(Of course=
 that
> is not a topic for this patch; I am just curious.)

  _("We want whole paragraphs"
    " for stuff like this where"
    " the message actually is a"
    " single paragraph of text")

However, in this case the message is a stand-alone error message
followed by what's effectively new sentence (a header above
strategies) followed by a listing of strategies.

That sort of thing isn't a problem, because fortunately we only have
left-to-right languages, not bottom-to-top. At least it hasn't been an
issue in MediaWiki (whose i18n I've worked on) which is translated to
over 200 languages now.

>> @@ -513,7 +513,7 @@ static int git_merge_config(const char *k, const=
 char *v, void *cb)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int is_bool;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shortlog_len =3D gi=
t_config_bool_or_int(k, v, &is_bool);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!is_bool && sho=
rtlog_len < 0)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return error("%s: negative length %s???", k, v);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return error(_("%s: negative length %s???"), k, v);
>
> What branch are you translating? =C2=A0I am hoping the omgwtfbbq??! m=
essage
> gets a chance to be tweaked before release.

It's on top of pu, I've actually lost an up-to-date tip where gettext
was applied to a branch below that, and haven't worked my way back.

Maybe this'll be a problem for this series. Here's the builtin/*.c
changes between next and pu:

     builtin/checkout.c        |   14 ++-
     builtin/fetch.c           |   21 ++++-
     builtin/fmt-merge-msg.c   |   60 ++++++-----
     builtin/init-db.c         |   56 +++++-----
     builtin/log.c             |    7 +-
     builtin/mailinfo.c        |   10 ++-
     builtin/merge-recursive.c |   15 +---
     builtin/merge.c           |   62 +++++------
     builtin/notes.c           |   14 ++-
     builtin/remote-ext.c      |  257
+++++++++++++++++++++++++++++++++++++++++++++
     builtin/remote-fd.c       |   83 +++++++++++++++
     builtin/skew.c            |   50 +++++++++
     builtin/tag.c             |    2 +-
     builtin/version.c         |    7 ++
     14 files changed, 537 insertions(+), 121 deletions(-)

Some of these affect this series. But I was hoping that this would
make it into pu and after next gets released Any Day Now most of those
other tips in pu would be folded into next along with gettext, or at
least the merge conflicts wouldn't be too painful.
