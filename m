From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 43/44] builtin/apply: add a cli option for be_silent
Date: Sat, 11 Jun 2016 12:16:31 +0200
Message-ID: <CAP8UFD3AAfvu6j0ROUSZGs5hpEh5MyE9Cgzcp_Ej_y0C7jvubQ@mail.gmail.com>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
 <20160610201118.13813-44-chriscool@tuxfamily.org> <575B2A2E.3000403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Jun 11 12:16:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBfy4-00076o-2c
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 12:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbcFKKQf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jun 2016 06:16:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34349 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbcFKKQe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jun 2016 06:16:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id n184so3735660wmn.1
        for <git@vger.kernel.org>; Sat, 11 Jun 2016 03:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kXQaHFA38spdYFYFH//JWLxln+4uVLFhbsLLHpvcsKM=;
        b=F9XHd8CLZ4+1vz/qq9nIamrE69fGh+oLi+1ywz9P+3uuwlI1TBOGzoxwuqE88jFFMo
         /3kVzNgy+gaXlhZIQDBq9xoMzMtUPPW8vsfkQu/kscI67GF1vXxTvnTEb6XqJoaN0cpe
         xWOwZTdG+AEJS1BuRRc0m4j0LDM18M7C9SWeBG1WKN8ZHpyxIIrTYiMmVt8cTGq4oFp9
         uuJQdrVyTIqaA1bWlzB0d4RarYwGzP1AhoDO6TdoVaPTwKVOg9ZmhnHKNcQqTDMd4fSM
         qnYUK5biyKoC3SN/3P8g0khSajS+TueGCP8SNjN67Hm65upcQHzWkH4tj3wSEBifJPeK
         6+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kXQaHFA38spdYFYFH//JWLxln+4uVLFhbsLLHpvcsKM=;
        b=ZVhrc8LE3+6v8+FXfzVZMPi84g3GCgyexDN7NLhULbti/UVBvVJyCxlW76RoN/oysw
         10cz0z817sPyiQ/uxSVU6GJMvNAqT42gnSuFR02kDbRxkRxWUS8bQEICcDNYE2+yZq/a
         7kqxrXNDNu8lrRcckeZIPdG1zq63Y5nDw5WVd+/G15bnI5j7+R4kVHVjse7VK7KsPAqg
         jCoNQWQd2O94HWwKVH+vKXTcyI9v8LpXt3ZANOSl9oJNq6whU37cZcQZHWT9+zNJ5hSj
         ZauBu3g5A/TGawu1tTvChHMl1kotLwI7Xioy++CppuSditEI+7/GIh+Wy1nY92ICmp6t
         a3WA==
X-Gm-Message-State: ALyK8tJgbTL+ahQHEVCiMegmXDOY+VsedEbo6ud3ZC5T9KFmE7JgLK6ThcJHYfSULtsV7JWLPUyJcn5PCPO0wg==
X-Received: by 10.28.183.8 with SMTP id h8mr2774370wmf.79.1465640192628; Sat,
 11 Jun 2016 03:16:32 -0700 (PDT)
Received: by 10.194.25.197 with HTTP; Sat, 11 Jun 2016 03:16:31 -0700 (PDT)
In-Reply-To: <575B2A2E.3000403@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297093>

On Fri, Jun 10, 2016 at 10:59 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrot=
e:
> Am 10.06.2016 um 22:11 schrieb Christian Couder:
>>
>> Let's make it possible to request a silent operation on the
>> command line.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>   builtin/apply.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> index ddd61de..93744f8 100644
>> --- a/builtin/apply.c
>> +++ b/builtin/apply.c
>> @@ -74,6 +74,8 @@ int cmd_apply(int argc, const char **argv, const c=
har
>> *prefix)
>>                 OPT_BOOL(0, "allow-overlap", &state.allow_overlap,
>>                         N_("allow overlapping hunks")),
>>                 OPT__VERBOSE(&state.apply_verbosely, N_("be verbose"=
)),
>> +               OPT_BOOL(0, "silent", &state.be_silent,
>> +                       N_("do not print any output")),
>>                 OPT_BIT(0, "inaccurate-eof", &options,
>>                         N_("tolerate incorrectly detected missing ne=
w-line
>> at the end of file"),
>>                         APPLY_OPT_INACCURATE_EOF),
>
> Why not -q/--quiet as for most other commands?

=46irst as I say in the cover letter, I am going to discard this patch.
That is because it is not necessary, and it appeared a bit
controversial whether I should use -q/--quiet or not in the v2
discussions.

> Furthermore, you could use OPT__VERBOSITY, which causes -v and -q to =
update
> the same variable variable and thus lets parseopt handle their intera=
ction.
> Perhaps verbosity =3D=3D 1 could mean verbose, 0 normal, -1 no infos,=
 -2 no
> warnings and -3 no errors?

Yeah, that could be done.

> And if you add the ability to silence the apply functions before usin=
g them
> you don't have to export and unexport dup_devnull().

Yeah, I will do something like that in the next version.

Thanks,
Christian.
