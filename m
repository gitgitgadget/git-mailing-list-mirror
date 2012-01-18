From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT defined
Date: Wed, 18 Jan 2012 15:25:54 +0100
Message-ID: <CALxABCYXWxp=wVahbPjt9V4n5P7EQnqFFT3S5Dc7Co-P9BGJFQ@mail.gmail.com>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <7vfwfervt9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 15:26:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnWT7-0006l0-1j
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 15:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757695Ab2ARO0T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jan 2012 09:26:19 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:37311 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757648Ab2ARO0R convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 09:26:17 -0500
Received: by obcva7 with SMTP id va7so7316165obc.19
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 06:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=FAmYt9odgRyeLDtZ2XcIpBKPUjqNjsmrK62Zh2faM2g=;
        b=UhDkliQN1KpDoXC0FCe/0DPhWydMeZmC4sw0Yd0YKJUioTO1ABGgrswcS+MrnGk/Nx
         c5gw7sz1trKmf5RMHl5sbNVExS6tkuMI47WwNhfv4jgGeAgw8qqXO3HHRYrWRzgpQ8aX
         2Qjydo86cLlxhmwtkSfppdsClTvXYF2sl7GzA=
Received: by 10.182.38.70 with SMTP id e6mr346416obk.13.1326896777283; Wed, 18
 Jan 2012 06:26:17 -0800 (PST)
Received: by 10.182.226.41 with HTTP; Wed, 18 Jan 2012 06:25:54 -0800 (PST)
In-Reply-To: <7vfwfervt9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188747>

On Tue, Jan 17, 2012 at 20:08, Junio C Hamano <gitster@pobox.com> wrote=
:
> Alex Riesen <raa.lkml@gmail.com> writes:
> Thanks for spotting. I agree that we should honor NO_GETTEXT here.
>
> But the result of the patch looks almost unreadable. could we restruc=
ture
> the script like this instead?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# Decide what to do...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dfallthrou=
gh
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if test -n "@@NO_GETTEXT@@$GIT_INTERNAL_GE=
TTEXT_TEST_FALLBACKS"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0then

Oh, it is much nicer indeed. I shall redo the patch as soon as I get of=
f
this crappy winxp computer.
