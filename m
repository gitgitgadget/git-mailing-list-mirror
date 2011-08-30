From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 2/5] tree-walk: drop unused parameter from match_dir_prefix
Date: Tue, 30 Aug 2011 13:55:42 -0500
Message-ID: <CAEik5nOSd+r0orJK63v4TEL-eKyE9eHuVgpH-9n+UjpeMv3nxA@mail.gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
	<1301535481-1085-2-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 20:55:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyTTP-0000rF-Hc
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 20:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756026Ab1H3Szn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Aug 2011 14:55:43 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:54407 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755864Ab1H3Szm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Aug 2011 14:55:42 -0400
Received: by pzk37 with SMTP id 37so10730538pzk.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2011 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Sq0e8QLGTBuNLNNHT8GgAAwQn2kmEQCoqnGksBwk/i8=;
        b=UFp8LhtEOxx9ZOL1cqEe/3TCUeWT6c8gbevAKesDn+4CLusK3ubkfHYd0PSPDL1NoV
         2n34iXKiLRrGroguce+JPXeMwYRgadEOEYoUpQnuMjtUc7dvnjMkqR9x61LoWXwD3FZw
         4ygs7hiBjQqkGNDTiEuhwHjjdpj3VbCKIydqA=
Received: by 10.142.142.1 with SMTP id p1mr3285365wfd.71.1314730542250; Tue,
 30 Aug 2011 11:55:42 -0700 (PDT)
Received: by 10.68.40.34 with HTTP; Tue, 30 Aug 2011 11:55:42 -0700 (PDT)
In-Reply-To: <1301535481-1085-2-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180433>

On Wed, Mar 30, 2011 at 8:37 PM, Dan McGee <dpmcgee@gmail.com> wrote:
> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
> ---

This still seems to apply to the current code, ping?

> =C2=A0tree-walk.c | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tree-walk.c b/tree-walk.c
> index 322becc..9be8007 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -522,7 +522,7 @@ static int match_entry(const struct name_entry *e=
ntry, int pathlen,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> -static int match_dir_prefix(const char *base, int baselen,
> +static int match_dir_prefix(const char *base,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *match, int matchlen)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strncmp(base, match, matchlen))
> @@ -579,7 +579,7 @@ int tree_entry_interesting(const struct name_entr=
y *entry,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (baselen >=3D=
 matchlen) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* If it doesn't match, move along... */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!match_dir_prefix(base_str, baselen, match, matchlen))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!match_dir_prefix(base_str, match, matchlen))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto match_wildcards;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (!ps->recursive || ps->max_depth =3D=3D -1)
> --
> 1.7.4.2
