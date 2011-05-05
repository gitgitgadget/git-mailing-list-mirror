From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (May 2011, #02; Wed, 4)
Date: Thu, 5 May 2011 09:52:59 +0200
Message-ID: <BANLkTin=oNQX7U4UpPQO3BTFa+GTqf-iVA@mail.gmail.com>
References: <7vsjstc1pp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 09:53:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHtMx-0007St-FN
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 09:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab1EEHxC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 03:53:02 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45185 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab1EEHxA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 03:53:00 -0400
Received: by fxm17 with SMTP id 17so1347319fxm.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 00:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JaWDeIzPG7XC6J7mVWcpYIyCuC7dj4o6JY6+1gOYtxg=;
        b=XhUajAIz70fpyemlD2aaqlc0YkDLdFgpAYaDmDL5jHMcwWN4qWgHr8yk43SCetQ+83
         wucpSnESwKywVq/Q1NZk1SYZYErahlPRKE8Nqt68hPVZe622f3RXM6r1EYmBcvR+6q8y
         AB9OmJk57Msr4x40McW7N//raXQUxzSTMk2y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fz3T8BAC9T6a3rfYcUb2ZRDAWFmFLaCPMDi4GRL502iIksKF/UT9VqWiQg1WlCm4N0
         R3+4f9K92Gy99/S4jf9t+4HV1y01JKiEHYEqRmDYpu2EmtjDPumWzaEuefw673ZfJlVm
         frlIPsZTeL/aExRHVoqkVEN5vf+Smui8yECUQ=
Received: by 10.223.54.219 with SMTP id r27mr2345105fag.124.1304581979659;
 Thu, 05 May 2011 00:52:59 -0700 (PDT)
Received: by 10.223.105.9 with HTTP; Thu, 5 May 2011 00:52:59 -0700 (PDT)
In-Reply-To: <7vsjstc1pp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172816>

On Thu, May 5, 2011 at 04:37, Junio C Hamano <gitster@pobox.com> wrote:
> [Graduated to "master"]
>
> * ab/i18n-fixup (2011-04-14) 24 commits
> =C2=A0(merged to 'next' on 2011-04-25 at 32fef07)
> =C2=A0+ i18n: use test_i18n{cmp,grep} in t7600, t7607, t7611 and t781=
1
> =C2=A0+ i18n: use test_i18n{grep,cmp} in t7508
> =C2=A0+ i18n: use test_i18ngrep in t7506
> =C2=A0+ i18n: use test_i18ngrep and test_i18ncmp in t7502
> =C2=A0+ i18n: use test_i18ngrep in t7501
> =C2=A0+ i18n: use test_i18ncmp in t7500
> =C2=A0+ i18n: use test_i18ngrep in t7201
> =C2=A0+ i18n: use test_i18ncmp and test_i18ngrep in t7102 and t7110
> =C2=A0+ i18n: use test_i18ncmp and test_i18ngrep in t5541, t6040, t61=
20, t7004, t7012 and t7060
> =C2=A0+ i18n: use test_i18ncmp and test_i18ngrep in t3700, t4001 and =
t4014
> =C2=A0+ i18n: use test_i18ncmp and test_i18ngrep in t3203, t3501 and =
t3507
> =C2=A0+ i18n: use test_i18ngrep in t2020, t2204, t3030, and t3200
> =C2=A0+ i18n: use test_i18ngrep in lib-httpd and t2019
> =C2=A0+ i18n: do not overuse C_LOCALE_OUTPUT (grep)
> =C2=A0+ i18n: use test_i18ncmp in t1200 and t2200
> =C2=A0+ i18n: .git file is not a human readable message (t5601)
> =C2=A0+ i18n: do not overuse C_LOCALE_OUTPUT
> =C2=A0+ i18n: mark init-db messages for translation
> =C2=A0+ i18n: mark checkout plural warning for translation
> =C2=A0+ i18n: mark checkout --detach messages for translation
> =C2=A0+ i18n: mark clone nonexistent repository message for translati=
on
> =C2=A0+ i18n: mark merge CHERRY_PICK_HEAD messages for translation
> =C2=A0+ i18n: mark merge "upstream" messages for translation
> =C2=A0+ i18n: mark merge "Could not read from" message for translatio=
n

=46antastic, so would this be the right time to submit the series with
the shellscript i18n series?
