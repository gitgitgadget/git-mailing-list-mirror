From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 5/9] for-each-ref: add %(tracking[:upstream]) for tracking info
Date: Sun, 19 May 2013 18:43:57 +0700
Message-ID: <CACsJy8DSH2Uq9-KhLVS=6Gu5L2q_gbHtrqmaQWE4_DJ6J2zQmQ@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
 <1368959235-27777-6-git-send-email-pclouds@gmail.com> <CALkWK0k5qM3CZoivC1GJaBfwxWwvpDVtU7mHmm3feiLKr4kxXw@mail.gmail.com>
 <CAMP44s1a5JH1T-ckvmFomoKKhFCE61CQ79YFxi4RiQLqeqhgTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:44:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue22S-0008GK-1s
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297Ab3ESLo2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 07:44:28 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:53876 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283Ab3ESLo1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 07:44:27 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so6689516oag.37
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=Ika4UWJysvwcA8Iu97iVaONo4N9XrSF6SJio0WdYnj0=;
        b=LAeDE7Io8UBiNKHnL+HXtUp3fNQa8IyN02EL90TVrnRpAx6zP6EYhdnCb88gRIomOw
         mMf6hXpzvwGcH4XPf8kxmn5VNBcT0kptFXayBUPnEuWYG4khQT0TN5w7ZtiZoKaGJS8i
         QZuPdY0NRYDaU5u115gU81MzpWCvm8YZE6JQbvPWCZP+n3rdsBRsDTOY73gyJI9Qew2z
         ARj/ruio3tmBT2bVnENEoeFRN1UCG8K72ZPjfgLKaZkcsRj3Pz04qmH7ob+CRSLmLG4W
         KY69K9Ztuc8k6uEV7a9L5OHXVQXsdJTYwh3Bk0mSpSznOfDz+8rroIjtuDz7ncR0SdaT
         U+nQ==
X-Received: by 10.60.17.231 with SMTP id r7mr11660281oed.13.1368963867242;
 Sun, 19 May 2013 04:44:27 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Sun, 19 May 2013 04:43:57 -0700 (PDT)
In-Reply-To: <CAMP44s1a5JH1T-ckvmFomoKKhFCE61CQ79YFxi4RiQLqeqhgTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224860>

On Sun, May 19, 2013 at 6:38 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sun, May 19, 2013 at 6:18 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
>>> index 498d703..b10d48a 100644
>>> --- a/builtin/for-each-ref.c
>>> +++ b/builtin/for-each-ref.c
>>> @@ -76,6 +76,8 @@ static struct {
>>>         { "symref" },
>>>         { "flag" },
>>>         { "current" },
>>> +       { "tracking" },
>>> +       { "tracking:upstream" },
>>>  };
>>
>> You just threw the upstream atom (and "upstream:short") out the wind=
ow :|
>
> Huh? Those don't print the tracking information, do they?
> "tracking:upstream" prints the upstream, but other things as well I
> suppose.

Exactly. I already explained why %(upstream) can't be used in 00/09.
"tracking" may not be perfect. Somebody might want
"tracking:upstream:short". It does not look quite nice.
--
Duy
