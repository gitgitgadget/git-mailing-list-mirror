From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0gdDYwNDAgKGJyYW5jaCB0cmFja2luZyk6IGNoZWNrIOKAnHN0YQ==?=
	=?UTF-8?B?dHVz4oCdIGluc3RlYWQgb2Yg4oCcY29tbWl04oCd?=
Date: Thu, 12 Aug 2010 00:45:31 +0000
Message-ID: <AANLkTi=zQW=QjmBtDwwn51VCDPfJae6CQwSbx+9ATxNs@mail.gmail.com>
References: <20100725005443.GA18370@burratino>
	<20100725010230.GI18420@burratino>
	<201008110911.40133.trast@student.ethz.ch>
	<20100811073028.GA5450@burratino>
	<20100811074909.GC5450@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 02:45:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjLvd-0005VL-LE
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 02:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758743Ab0HLApp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 20:45:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64977 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758689Ab0HLApd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 20:45:33 -0400
Received: by fxm13 with SMTP id 13so527989fxm.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 17:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=91/zpjcEPLXuj9b0AuWXkPkwjsJliOFWO5e7YOIULNk=;
        b=CIGnLuqrSLEAwnY22winRQcsauUvA3gao1g1mwMc5APVW3zkaMOqlyWWTTLPnsg7yy
         Z+ZiWySiAIqj+Hih+milS5rYu1M1034tBu77NpfGAqyk30v+G60K6j5VBYJJ70DPbhkg
         bH8pGcJQLX/J/2k7GzeR5DwgWAHCR88KlXoVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RSoi3v7QdNPspFmHlaCLXC6SvC4bLgUMryTe+xkuCDIUQMRuP+dDwxxJgHXokBcpUf
         UXieg6ljinwhzA9vInB8H+1w5CuvI8YG7k/9JV2VGU9hXPUFyMzWq1yRZHjoM8xlwnOe
         cMQZXHPg1Ju31JMTyeKz5XP57qN1G0L4Fu1Ik=
Received: by 10.223.119.136 with SMTP id z8mr20911438faq.63.1281573931964; 
	Wed, 11 Aug 2010 17:45:31 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 11 Aug 2010 17:45:31 -0700 (PDT)
In-Reply-To: <20100811074909.GC5450@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153320>

On Wed, Aug 11, 2010 at 07:49, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Among the tests for correct branch tracking output is one that
> examines =E2=80=9Cgit commit=E2=80=9D output:
>
> =C2=A0$ git commit
> =C2=A0# Your branch and 'origin/maint' have diverged,
> =C2=A0# and have 9 and 69 different commit(s) each, respectively.
> =C2=A0[...]
> =C2=A0no changes added to commit (use "git add" and/or "git commit -a=
")
> =C2=A0$
>
> But we are experimenting with changing that output. =C2=A0So drop
> that test for now and replace it with a test for =E2=80=9Cgit status=E2=
=80=9D
> (which was not being checked yet and shares the same output
> format and wt-status backend).
>
> Reported-by: Thomas Rast <trast@student.ethz.ch>
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> =C2=A0Oops, wrong patch. =C2=A0Here=E2=80=99s the one I meant. =C2=A0=
Sane?
>
> diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
> index 1785e17..a5b4489 100755
> --- a/t/t6040-tracking-info.sh
> +++ b/t/t6040-tracking-info.sh
> @@ -68,8 +68,7 @@ test_expect_success 'status' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cd test &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout b=
1 >/dev/null &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # reports nothing =
to commit
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_must_fail git=
 commit --dry-run
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git status
> =C2=A0 =C2=A0 =C2=A0 =C2=A0) >actual &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0grep "have 1 and 1 different" actual
> =C2=A0'

This looks good. My patch should be dropped in favor of this. It looks
like the extra testing I did is covered by the "git commit --dry-run"
test in t7508-status.sh in your original patch.
