From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] stripspace: Call U+0020 a "space" instead of a "blank"
Date: Tue, 9 Feb 2016 14:53:19 -0800
Message-ID: <CAGZ79kao-DWwn2j4aO8ArSPHAX65KeL7NyD=ONkB6qjOrDZNSQ@mail.gmail.com>
References: <1454037056-26355-1-git-send-email-alexhenrie24@gmail.com>
	<xmqqvb5x1q01.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Tobias Klauser <tklauser@distanz.ch>,
	Alex Henrie <alexhenrie24@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 23:53:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTH9z-00026k-KY
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 23:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755534AbcBIWxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 17:53:23 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:36489 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933080AbcBIWxU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 17:53:20 -0500
Received: by mail-io0-f170.google.com with SMTP id l127so3527651iof.3
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 14:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZdY+jbm4z/aSUXTHvd7VpI9Ic9xQOdJnj2lokUHpeZc=;
        b=Cm+Sy/5SNSGeu3i0HaNOFm9Y2uC8xD9h+F46tHLcjIhapB/5jX0QBnyrswVBISVqyp
         SFQGHNhUocwpkC/PMU2PTGwHFBeA6nVmQgQNvqTJhZjGv4wSpI+ufps8p60oLnfs0ltw
         D/oc73mVNXjW1M5RyaTQu6cVzhPA0sDyj75XjP9CxmwYZwd73ztct54i725V1JaBJot9
         gwOKAjSmK+9ViTew99S4RzuWe7/5BCjHbUNUJad7a4TTXR/pKA8tGJBLc9dzKSwF/LM7
         J+7MXWASE4w/D9zBqVSPXdjgMY/GAdtPZoYvM15g5DwrAaOasbhYwTTMXml9CItgA1Z5
         JI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ZdY+jbm4z/aSUXTHvd7VpI9Ic9xQOdJnj2lokUHpeZc=;
        b=a2+qAt0uuxUamCVuxm6S9b6QkbpCFd+sQ8T4IuoNJOhKFoaHQ0ZNVbLj/8vmH+msRb
         ZH+jm14ruxoChIJCarXX18WMlv+BycUx6QqjlY2QaRVs+W3D8URvo3vfogf8xGkVSNuD
         H3X8bUkgpwR3+8SpnV5NjX1LgytRLid44VEkyQBuwMiLskOcJlwHkBZQO89fQafYITXp
         Ti8jAurplzOW6mJdlUV3+hXmwNz1GWKq/0cYchxPJG6m8+LQrkd796RDlQNWCePEnMKY
         d/OkIDPT6Jo1WaqswBK7xoFkdswVlE71ai0l9IdS2Z8tdwno71Jm3RVxBLxwE+HMbBvN
         +14w==
X-Gm-Message-State: AG10YOQEqXuljsu5ZNqin2H7Uji1OTNNoL+THeWyf6x16tDrtAXbtMbqlY35AwbCuuQBV35v6VNSUwzjJt/HDSul
X-Received: by 10.107.158.81 with SMTP id h78mr14221857ioe.174.1455058399957;
 Tue, 09 Feb 2016 14:53:19 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Tue, 9 Feb 2016 14:53:19 -0800 (PST)
In-Reply-To: <xmqqvb5x1q01.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285881>

On Tue, Feb 9, 2016 at 2:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
>> I couldn't find any other examples of people referring to this character
>> as a "blank".
>>
>> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>> ---
>
> Any comments on this from anybody other than the author that I
> missed to support this change?

I remember "blank" being used in my early days of computing.

The blank was somehow more accurate as it described the exact
thing (i.e. char U+0020 as commonly produced via the space bar
on the key board)

A space however could refer to any kind of indentation.
 * tabs would qualify for that
 * other tricks of your (wordprocessor-) editor would qualify for that
   (indent by 2 inches in footer section or other weeirdness)
 * any other character not using any ink in a printer[1]

[1] https://www.cs.tut.fi/~jkorpela/chars/spaces.html

Looking at that table in there, U+0020 is officially called "space",
so I guess the patch is technically correct.

Orthogonal to this discussion, I'd suggest adding an "a"
into the string

     N_("prepend a comment character and a {space, blank} to each line"),

>
>>  builtin/stripspace.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/stripspace.c b/builtin/stripspace.c
>> index 7ff8434..15e716e 100644
>> --- a/builtin/stripspace.c
>> +++ b/builtin/stripspace.c
>> @@ -35,7 +35,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
>>                           N_("skip and remove all lines starting with comment character"),
>>                           STRIP_COMMENTS),
>>               OPT_CMDMODE('c', "comment-lines", &mode,
>> -                         N_("prepend comment character and blank to each line"),
>> +                         N_("prepend comment character and space to each line"),
>>                           COMMENT_LINES),
>>               OPT_END()
>>       };
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
