From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 00/51] i18n: Shell script translations
Date: Sun, 10 Apr 2011 15:04:26 +0200
Message-ID: <BANLkTikhWpNfbRJDj5TXS9vokuHOnoibzw@mail.gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
	<7vhbafcg00.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 15:04:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8uJo-00088w-Lu
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 15:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab1DJNE2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 09:04:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50658 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab1DJNE2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Apr 2011 09:04:28 -0400
Received: by fxm17 with SMTP id 17so3084096fxm.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xJNlm5H/MVUmkMtVpOokGshYB0SA9HBYR5kqEFWr9fY=;
        b=u2An3Mrvc72hbTbGbSbo1+zhu6s2olbjVPh2bNivM+Ov/Td1Fcv35L39KHZ/r9Om2w
         vM+DNBcpRo4GzSYeCxuCwk5lVSJZUXaC+5tdG/HL5JLRJzUy5uWLNHb/USsYu7TcrfNL
         4Uny7S5yWf4z4BKtJ5iYfQrnOlKHV5UIigfwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KMtoq6RgPOgzzl7KPh3REZLri1BQI3YcSfrIA9aV6NakzUi/dorG6K/G8dhkWYvsKK
         0Dj4wExFzUlwIGIEprlzsRJN+lo1/o5ayYsuMvB57k6cPdMtdP3LoTQ3pYJ2N73kmhCv
         6SfJFV7E4VPdLwbEnHl7BzPsQg062EVc50zXU=
Received: by 10.223.60.81 with SMTP id o17mr1682816fah.48.1302440666675; Sun,
 10 Apr 2011 06:04:26 -0700 (PDT)
Received: by 10.223.105.201 with HTTP; Sun, 10 Apr 2011 06:04:26 -0700 (PDT)
In-Reply-To: <7vhbafcg00.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171251>

On Sun, Apr 3, 2011 at 21:05, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> Following the "i18n: Shell script translation infrastructure"
>> series. These are the actual shell script translations. Together the=
se
>> series add up to everything from:
>>
>> =C2=A0 =C2=A0 git://github.com/avar/git.git ab/i18n-sh-only
>
> I am obviously not going to queue these patches right at this moment,=
 but
> people with topics in flight or in their head need to take a look at =
the
> parts of this series that may overlap with what they are touching, an=
d
> plan to rebase their work when the time comes.

So would after 1.7.5 be a good time to submit them?

> What is more urgent at this moment in this cycle is to catch and adju=
st
> the fallouts from the merges of topics that started before ab/i18n to=
pic.
> You caught one in t2019 that didn't mark a test that examines the out=
put
> for a translatable string with C_LOCALE_OUTPUT (as there was no such =
thing
> when the topic started).
>
> There may be other similar adjustments that are needed in tests, and =
also
> I suspect there are messages that are not marked with the _() markers=
 that
> came from other topics. =C2=A0Because we shouldn't see too many new m=
essages in
> the code appearing from now on until 1.7.5 final, this is a perfect t=
ime
> to catch and adjust these kinds of issues.

I'll try to do this and submit it before 1.7.5.
