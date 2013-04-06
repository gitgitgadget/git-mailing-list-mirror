From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/4] remote-helpers: trivial test fixes
Date: Sat, 6 Apr 2013 11:58:53 -0600
Message-ID: <CAMP44s0tAmXxGLnKJ=+xvbMUJW_bqiK75-hKo9M3jh8J=YX-4g@mail.gmail.com>
References: <1365089779-9726-1-git-send-email-felipe.contreras@gmail.com>
	<51605546.3080503@web.de>
	<CAMP44s0Lbg-_JKPR6WF6Qhkz7cgweHejA-T_V3mCO73a4iXpNA@mail.gmail.com>
	<51605F32.7080303@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>,
	Antoine Pelisse <apelisse@gmail.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 06 20:26:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOXOG-0007ri-8m
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146Ab3DFR6z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Apr 2013 13:58:55 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:61569 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631Ab3DFR6z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Apr 2013 13:58:55 -0400
Received: by mail-wi0-f179.google.com with SMTP id hn17so1477558wib.0
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=BpOgpnA4ce19hCZFkXAADq7PbwTObs64w/EW8Qswh40=;
        b=jQgUrJ7nFlCGNvhjbopmzMDCwHzFkEcUSYas07CSDEvQxM9lXdRPNYCwx2yGHaTbKu
         em5+C0nNHxEMD2UMipFbhEn/9k9hG/qCowXEzaxb7UH7iM7ra2vRPOUaxCbQZJvF4YE4
         92MPCtE2IAgNX89FI8U8LevUAb/MR5e5Ld98QPiTCjQWqoSMZ9K1ts3qpdCSO4UoYIFN
         QumMJV3pZmz0tmSxQsFR1nHNj3M/m9cSVdM9lybsxQULbBUCy9H8VglTX9aihY/yJvDg
         Z8hGGTqVV5Mb1b+I2SOA5gDXqmmy+6NEQHOtzYjueRngJEcwPrwZM887cfGCVowXNj/R
         AfeQ==
X-Received: by 10.194.109.35 with SMTP id hp3mr23463885wjb.15.1365271133842;
 Sat, 06 Apr 2013 10:58:53 -0700 (PDT)
Received: by 10.194.41.2 with HTTP; Sat, 6 Apr 2013 10:58:53 -0700 (PDT)
In-Reply-To: <51605F32.7080303@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220264>

On Sat, Apr 6, 2013 at 11:45 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 06.04.13 19:29, Felipe Contreras wrote:
>> On Sat, Apr 6, 2013 at 11:03 AM, Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:

>>> --- a/contrib/remote-helpers/test-hg.sh
>>> +++ b/contrib/remote-helpers/test-hg.sh
>>> @@ -115,7 +115,7 @@ test_expect_success 'update bookmark' '
>>>    git push
>>>    ) &&
>>>
>>> -  hg -R hgrepo bookmarks | grep "devel\s\+3:"
>>> +  hg -R hgrepo bookmarks | egrep "devel[[:space:]]+3:"
>>>  '
>>
>> I would rather use [ \t] instead.
> That doesn't work on e.g. Mac OS.
> [:space:] is actually portable

Why wouldn't it work? This is from their manpage:

A bracket expression is a list of characters enclosed by [ and ].  It
matches any single character in
that list; if the first character of the list is the caret ^ then it
matches any character not in the
list.  For example, the regular expression [0123456789] matches any
single digit.

--=20
=46elipe Contreras
