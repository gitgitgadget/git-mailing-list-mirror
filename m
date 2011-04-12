From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 7/7] i18n: mark checkout plural warning for translation
Date: Tue, 12 Apr 2011 09:54:58 +0200
Message-ID: <BANLkTimjYxz_7v8gyByjKX2Mf9vRzukWGw@mail.gmail.com>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
	<1302464048-21806-8-git-send-email-avarab@gmail.com>
	<7vipukq6m0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 09:55:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9YRI-0005ov-MT
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 09:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357Ab1DLHzA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 03:55:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57198 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab1DLHzA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 03:55:00 -0400
Received: by fxm17 with SMTP id 17so4100662fxm.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 00:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UmPl1Ebm103FwyCjqbrV3DGj7mGCfqXo4VAwUjcvukQ=;
        b=KwfC4unEie4LSC/aQz51leYW4p5OELpIgjqEr9Co3nvsPBZ/Sl2552oPuYMHghGa1O
         oZeKEdylYmzD0Sj6ODZTFrrhY1Ffj2YrufFbDY6lFH+Cc6dGbgC4JMJBJBQqjC5793LV
         NR5K8/ofIa6EUvQPMs7LZvZxMU408BUn+CxUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N1AG/wp55yWFm2tLwN9ra//EOvVnhUMy750s46mlw++YeO0kEn/CVlJPICn7rbbDSv
         We817TXKSEoULku2k1DpNQ5G7r7wgU2Z1d2zAjY0gHsQLZJ8nC+rn07BiMQLdXSqV82t
         Srm+mG4AZgSiUdeICMAIIPJLUqFKtGC0Yy2qQ=
Received: by 10.223.25.197 with SMTP id a5mr1066196fac.29.1302594898845; Tue,
 12 Apr 2011 00:54:58 -0700 (PDT)
Received: by 10.223.105.201 with HTTP; Tue, 12 Apr 2011 00:54:58 -0700 (PDT)
In-Reply-To: <7vipukq6m0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171381>

On Tue, Apr 12, 2011 at 09:19, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> Mark the "Warning: you are leaving %d commit(s) behind" message adde=
d
>> in v1.7.5-rc0~74^2 (commit: give final warning when reattaching HEAD
>> to leave commits behind) by Junio C Hamano for translation.
>>
>> This message requires the use of ngettext() features, and is the fir=
st
>> message to use the Q_() wrapper around ngettext().
>
> Thanks.
>
>> =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Q_(
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The singular version =
*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Warning: you are leavin=
g %d commit behind, "
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "not connected to\n=
"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "any of your branch=
es:\n\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "%s\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "If you want to kee=
p them by creating a new branch, "
>
> s/them/it/ as this is a singular case, no?

I just used the message as-is, we were using that for the singular befo=
re.

But maybe we should change that. Fix it up at your discretion.
