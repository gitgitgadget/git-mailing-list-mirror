From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 00/11] Add new git-cc-cmd helper to contrib
Date: Fri, 19 Apr 2013 20:34:14 -0500
Message-ID: <CAMP44s0rF+1_4hHUe_yEgP6rOPhQwVz=FrdiGm5defnYByqj1Q@mail.gmail.com>
References: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8Dt2++tRUYcJk3jXuHUAv9jRmYYSYyVwHXQeo5O_3WQLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 20 03:34:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTMh2-0003hc-Qu
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 03:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965392Ab3DTBeR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Apr 2013 21:34:17 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:44579 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965356Ab3DTBeQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Apr 2013 21:34:16 -0400
Received: by mail-lb0-f180.google.com with SMTP id t11so4175922lbi.25
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 18:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=Kb4lm3qvEVYr8Ngskent1NSr0t0JYq66UTOJNmHN0gU=;
        b=cOn1P24yyyprbSbqNRgsprlc0J2/4Gib1pHKb4uNGs0/X5PyUI7LWOo7WTViiQDFZm
         ZLdWGw5PCDUkAKNpspt/A0WHMI0WbaJ6cj1ZsdxTvFOhdC8Um8tJGwdtNQlT2pkChBrx
         fDEJIO/nePKc8vDaBmfp2Rhq7VRVxaVaDLSpEfCSh6HmeIU2kIHix6aPdHrWTG2J8nvX
         aSLbRbh86iKQ4J03OZ7gIhd24/HtJ0FFCXu/uvwyq5Sj2DiFwQRGqvRJK6+2vQJd2aNP
         md+ltKGlOhkl3P6hVq0fDLJ8YT12uftDluTMZ+CEFg+hNeaCT1fTCWRscu2taGOtLCW+
         0Amg==
X-Received: by 10.112.135.3 with SMTP id po3mr5989272lbb.103.1366421654848;
 Fri, 19 Apr 2013 18:34:14 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Fri, 19 Apr 2013 18:34:14 -0700 (PDT)
In-Reply-To: <CACsJy8Dt2++tRUYcJk3jXuHUAv9jRmYYSYyVwHXQeo5O_3WQLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221830>

On Fri, Apr 19, 2013 at 8:16 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Apr 20, 2013 at 5:30 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> This script allows you to get a list of relevant persons to Cc when =
sending a
>> patch series.
>>
>>   % git cc-cmd v1.8.1.6^^1..v1.8.1.6^^2
>>   "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" <pclouds@gmail.com> (a=
uthor: 30%, signer: 7%)
>>   Duy Nguyen <pclouds@gmail.com> (author: 7%)
>
> You see, I like to cause confusion. These two are the same person.
> Maybe you should check based on email only instead.

Should be easy to implement.

>>   "Jean-No=C3=ABl AVILA" <avila.jn@gmail.com> (author: 7%)
>>   Jean-Noel Avila <jn.avila@free.fr> (signer: 7%)
>
> And these two are like the same. Perhaps mailmap support will help?

There's already support for user-defined alias
(sendemail.aliasesfile), it shouldn't be too difficult to parse a
=2Emailmap file too.

Cheers.

--=20
=46elipe Contreras
