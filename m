From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] Command names should not be translated.
Date: Mon, 20 Sep 2010 10:22:06 +0000
Message-ID: <AANLkTin8FR7+N-zCTWYpd=ygtJ6=0m+6iVWXoaok_na=@mail.gmail.com>
References: <0001.Command.names.should.not.be.translated.20100920@softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Sep 20 12:22:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxdVq-0000Bl-LR
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 12:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874Ab0ITKWI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 06:22:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52137 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786Ab0ITKWH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 06:22:07 -0400
Received: by iwn5 with SMTP id 5so4160285iwn.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 03:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=J04XpTMN0hrMV3Dctfx51+iU2SQM4ngqISV+pbiZXhs=;
        b=ZgwBpKNXv25ByGjwn3VUiQKUsRljzzKAtn8E3QKm3T0ILdzc0a1Nb/uBDnU946Cujh
         jmabVbHbXcdsOlOzDrX651IZ8+gpV3vALWnmS22/OSxRfkKMB967lBcSXNMJjCt0mdYh
         vNXN6GC2Z3Y2g0RkOhcTh711hV0P0lTLPdy+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=p9k2UfznoulkHE1f8THcisBWRPp750biQU0EB4xjdGSJimqOcOPFYGnqcYbj0WPqLG
         bHSMqXHLtYFkTXSxZkvHRytX3XAy+hsZ+Iwe1qMW8X4zxqjClDhNdICWE4DAnQUt2yHI
         Op4lSp1fKauaMsmz5OCXMh889KIB2PyH1qKOI=
Received: by 10.231.145.1 with SMTP id b1mr10227296ibv.69.1284978126429; Mon,
 20 Sep 2010 03:22:06 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 20 Sep 2010 03:22:06 -0700 (PDT)
In-Reply-To: <0001.Command.names.should.not.be.translated.20100920@softwolves.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156611>

On Mon, Sep 20, 2010 at 08:00, Peter Krefting <peter@softwolves.pp.se> =
wrote:
> Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
> ---
> =C2=A0wt-status.c | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> Re-sending with proper Message-Id. Sorry for the noise.
>
> diff --git a/wt-status.c b/wt-status.c
> index f6946e1..7d4719f 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -663,9 +663,9 @@ void wt_status_print(struct wt_status *s)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wt_status_prin=
t_submodule_summary(s, 1); =C2=A0/* unstaged */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s->show_untracked_files) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wt_status_print_ot=
her(s, &s->untracked, _("Untracked"), _("add"));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wt_status_print_ot=
her(s, &s->untracked, _("Untracked"), "add");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s->show_ig=
nored_files)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 wt_status_print_other(s, &s->ignored, _("Ignored"), _("add -f")=
);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 wt_status_print_other(s, &s->ignored, _("Ignored"), "add -f");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (s->commitable)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(s->fp,=
 _("# Untracked files not listed%s\n"),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0advice_status_hints

Hi. I already squashed this and many other things as part of the next
version of ab/i18n that I'm working on now. I'll be sending a message
to the list soon with a pull request for it.

I *thought* I mentioned that somewhere, but if not sorry for making
you do un-needed work, and thanks a lot for the report about this
issue.
