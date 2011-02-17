From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: How you can translate things now, and a plan for the i18n series
 going forward
Date: Thu, 17 Feb 2011 09:47:07 +0100
Message-ID: <AANLkTikij+hp7Q2Brfnp7ZiQgaZvhNcQBSijQozMtiH4@mail.gmail.com>
References: <AANLkTim+_zRisVRfnv_Xe69xof3e8rL_BAXxmAsCwins@mail.gmail.com>
	<7vipwpxbam.fsf@alter.siamese.dyndns.org>
	<AANLkTi=E0LYWp7ag8SD8LNCKkKopGczJL0QnuOiH2UEu@mail.gmail.com>
	<7v8vxfh4j7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, kev <kev@riseup.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 09:47:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpzWT-0005nV-EO
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 09:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab1BQIrJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Feb 2011 03:47:09 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54100 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab1BQIrI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 03:47:08 -0500
Received: by fxm20 with SMTP id 20so2346050fxm.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 00:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=10lX/YxzP7BF/0rxHihhbTUfKl2dghALJ91czytXjxU=;
        b=ts1icSct5bD1C0EDo0278XJpL2u6a4PlPvcnPVqempiwqrM/J+52nJK3uxen2e4lp3
         VzVlT0XdGbTLedMtuMAwNcZS3LWOits/8PBVZnYPKUswFxqFst1JxgbtmCZjrFF2Vav0
         Nky4vi0Z4JTj2QwaGk4cFzS3rU4U6mJj6m3a4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xHbX8o1lgcXBhIwXpX53wXhqRiSoOUVu6le0wwkzkltScv9xLbzpEykeIqEDvX6UAP
         p39bc19Bwr5fuGc25GXtC7ajHMdrIgziHijJ+Rlx882lO3mmQGAl/7oU6LLpQSCecZCr
         t4eKmsT/R1snCosfRQRg8CYomw2lhTMR3dPVE=
Received: by 10.223.96.12 with SMTP id f12mr2045628fan.79.1297932427246; Thu,
 17 Feb 2011 00:47:07 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Thu, 17 Feb 2011 00:47:07 -0800 (PST)
In-Reply-To: <7v8vxfh4j7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167057>

On Thu, Feb 17, 2011 at 01:46, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Here's a work-in-progress version of this:
>> https://github.com/avar/git/compare/master...ab/i18n-c-_-only
>>
>> I still have to:
>>
>> =C2=A0* Add NO_GETTEXT_POISON to more tests, some things have broken=
 due to
>> =C2=A0 =C2=A0new strings / changed tests.
>>
>> =C2=A0* Squash the !fixup patches in appropriately.
>>
>> But otherwise does this seem good? I.e. having just those stub macro=
s,
>> a lot of *.c patches, including gettext.h in cache.h.
>
> I only gave a cursory look to "git diff master..ab/i18n-c-_-only" out=
put,
> and things looked fine for a yet-to-be-completed WIP (I didn't see th=
e
> definition of shell version of gettext and gettext_eval, for example)=
=2E

I'm going to submit the C ones first, and do the shell and Perl ones
later if that's OK with you.
