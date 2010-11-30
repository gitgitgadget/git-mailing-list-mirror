From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/6] CodingGuidelines: mention whitespace preferences for
 shell scripts
Date: Tue, 30 Nov 2010 09:11:20 +0100
Message-ID: <AANLkTin5KWZAHegFHykau6gWHbijA7B8q_7WjfnV2mus@mail.gmail.com>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291042075-19983-2-git-send-email-giuseppe.bilotta@gmail.com> <7vy68by7om.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 09:11:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNLJX-0005UR-LZ
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 09:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257Ab0K3ILn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Nov 2010 03:11:43 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46895 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975Ab0K3ILn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Nov 2010 03:11:43 -0500
Received: by iwn5 with SMTP id 5so1186833iwn.19
        for <git@vger.kernel.org>; Tue, 30 Nov 2010 00:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qaK/xaoikaLaSzlWCh4foO3usDzfbIMCpUkMtdxdsUQ=;
        b=vt5sVr0TdfAGCtmpwEdTI0+wDIBWNP/YZDK+AwjAhIfpz5FPsX8Ue4mf1085osB0G1
         jx9S0lYCfsWWT+DuM27+8s9kvKxvNr61wgzF0B+I8N6fBOc1zYCSPKeNOJSoKsVR+4WA
         XMpLiHOB9LylEripEGL9heSbOyIc+cV9XlGTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=G/Dj3ljMtOyDCYOVQw7GGggXLHxfW9Q01EYwwqMqzRbOx7ByyKLj+qRfVbCxTirqZj
         qY4ghWvP5nargBQnwQl1U569AO0K75bBd4Qi4YcAOq4vt444nHEA2l7qBHS5A1JAgxTJ
         pQf25ln3QfZuuLK5082qxMJRHdsHJE6YHXA2A=
Received: by 10.231.35.194 with SMTP id q2mr6871133ibd.26.1291104702434; Tue,
 30 Nov 2010 00:11:42 -0800 (PST)
Received: by 10.231.153.203 with HTTP; Tue, 30 Nov 2010 00:11:20 -0800 (PST)
In-Reply-To: <7vy68by7om.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162475>

On Tue, Nov 30, 2010 at 1:30 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> ---
>> =A0Documentation/CodingGuidelines | =A0 =A06 ++++++
>> =A01 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGu=
idelines
>> index 5aa2d34..7ecce51 100644
>> --- a/Documentation/CodingGuidelines
>> +++ b/Documentation/CodingGuidelines
>> @@ -31,6 +31,12 @@ But if you must have a list of rules, here they a=
re.
>>
>> =A0For shell scripts specifically (not exhaustive):
>>
>> + - We use tabs for indentation.
>
> Ok.
>
>> + - The choices in case ... esac statement are not indented with res=
pect
>> + =A0 to the the case and esac lines. The body of the choices howeve=
r _is_
>> + =A0 indented (by one tab).
>> +
>
> Nit; "choices" are called "case arms".

I'll rephrase.

> I don't think there is any need to emphasize your surprise that case =
body
> is indented with "however _is_", which implies "against common sense =
or
> normal convention" or somesuch. =A0The thing is, there is no single _=
right_
> convention, and we want people to folow the one just picked---we shou=
ld
> just describe what it is without being emotional nor emphatic.

Good point, I'll resend with a shorter commit message. Would you be ok
with me adding an example, or do you think it's unnecessary?

--=20
Giuseppe "Oblomov" Bilotta
