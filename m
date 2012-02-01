From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] i18n: format_tracking_info "Your branch is behind" message
Date: Wed, 1 Feb 2012 18:39:43 +0100
Message-ID: <CACBZZX6ydnf2n2Y++DCS+ttJYRA_r1FGUzUH-MBVPof65w=Hig@mail.gmail.com>
References: <1328116914-61381-1-git-send-email-worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 18:40:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RseAG-00036D-Gg
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 18:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828Ab2BARkF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 12:40:05 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:55356 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753450Ab2BARkE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 12:40:04 -0500
Received: by lagu2 with SMTP id u2so792892lag.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 09:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=I8InXxpQdlvFCySO3wPoPvi14qr7HcBA1dOEUnFWe0A=;
        b=VRDQ2q+8+OJO/eWt6Ie7u2I7ZWoGvPhV3XTeOyoeNUVQEBN0MWmuQHMNjokm0QCD3d
         IW+5CPCpN6Vmm88nL2mWjtcDuFlNQO5zX0Yk/a20HombUVb3kX6yTTyo5qsT/XA2jKxi
         JE5C7dy2HtG9LnNk0EoLtTq/gxI7UMXnjFv1k=
Received: by 10.152.105.175 with SMTP id gn15mr13838841lab.23.1328118003097;
 Wed, 01 Feb 2012 09:40:03 -0800 (PST)
Received: by 10.112.30.67 with HTTP; Wed, 1 Feb 2012 09:39:43 -0800 (PST)
In-Reply-To: <1328116914-61381-1-git-send-email-worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189528>

On Wed, Feb 1, 2012 at 18:21, Jiang Xin <worldhello.net@gmail.com> wrot=
e:
> Function format_tracking_info in remote.c is called by
> wt_status_print_tracking in wt-status.c, which will print
> branch tracking message in git-status. git-checkout also
> show these messages through it's report_tracking function.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
> =C2=A0remote.c | =C2=A0 18 +++++++++---------
> =C2=A01 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 73a38..51853 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1572,18 +1572,18 @@ int format_tracking_info(struct branch *branc=
h, struct strbuf *sb)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0base =3D branch->merge[0]->dst;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0base =3D shorten_unambiguous_ref(base, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!num_theirs)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addf(sb, "Y=
our branch is ahead of '%s' "
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 "by %d commit%s.\n",
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 base, num_ours, (num_ours =3D=3D 1) ? "" : "s");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addf(sb, _(=
"Your branch is ahead of '%s' "
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 "by %d %s.\n"),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 base, num_ours, Q_("commit", "commits", num_ours)=
);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (!num_ours)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addf(sb, "Y=
our branch is behind '%s' "
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 "by %d commit%s, "
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 "and can be fast-forwarded.\n",
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 base, num_theirs, (num_theirs =3D=3D 1) ? "" : "s=
");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addf(sb, _(=
"Your branch is behind '%s' "
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 "by %d %s, "
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 "and can be fast-forwarded.\n"),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 base, num_theirs, Q_("commit", "commits", num_the=
irs));

These two should be something like:

 _Q("Your branch is behind '%s' by %d commit",
    "Your branch is behind '%s' by %d commits",
    base,
    num_theirs);

Otherwise we're imposing word order in the translation.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addf(sb, "Y=
our branch and '%s' have diverged,\n"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addf(sb, _(=
"Your branch and '%s' have diverged,\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"and have %d and %d different commit(s) eac=
h, "
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 "respectively.\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 "respectively.\n"),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0base, num_ours, num_theirs);

And this is a nice example of where gettext really can't do the right
thing, it only deals with messages with one numeric counter ;/

It's probably best to just pick one, probably the latter one.
