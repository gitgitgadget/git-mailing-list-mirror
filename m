From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 2/3] t7507-commit-verbose: make test suite use write_script
Date: Fri, 25 Mar 2016 13:04:41 -0400
Message-ID: <CAPig+cQLOwAimmHeUmi5+KScgOP0hr9-MiX8gyGcEk6Zj0U_jQ@mail.gmail.com>
References: <01020153a7ba4eae-9b88e119-0505-418f-a137-595250edaa9d-000000@eu-west-1.amazonses.com>
	<1458817259-11675-1-git-send-email-szeder@ira.uka.de>
	<CAPig+cQJ1yK8WhXE0sxSmDenMt1DMZCoJypTu_wkDsDyuBsAWg@mail.gmail.com>
	<20160325154638.Horde.LzlsD6cZcQfmt894cll_0Tl@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Mar 25 18:04:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajVAF-00058E-IK
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 18:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbcCYREn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 13:04:43 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34509 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851AbcCYREm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2016 13:04:42 -0400
Received: by mail-vk0-f65.google.com with SMTP id e6so8352707vkh.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=IEPbmrEKrs0zcg0JMcJbhXIZDesPrPLASCncIFtDoig=;
        b=06JB3EPMzyc0VRRCddDOuDO2F/VWWKHFoIbpr1YHfi0rxQpOmZknRrVRM0QrGx8Ryc
         8rAwSuB0LlL/7jlWooMy5Dt80DToBBfrJLm2aXuXkw46ESVyusRz/oFHA48sVTwDWv7F
         C7i61yboattULhd6ZaGk5DkoVho9eO0siaEkZwyTgpIPJArueA3BHt2d8/ED+ioW1gxp
         wxZh3eIwZIIcYGcl7zotDzDfSrqYczfF9n8z+G9qaBpkyzYOi5G54bEyomAgw5bJmenO
         +yfAxcea9+qTySPy9xXYgtqSpHTbr1BVhAMQvcj4EFuyNJUQdwQxsAfyizlssVlrC2ql
         gVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=IEPbmrEKrs0zcg0JMcJbhXIZDesPrPLASCncIFtDoig=;
        b=D7vKKbUC9ubxOpVpNVpgdLP2Ch3bQkqHGhyIH5kzm3qO9SPzVllBANw5VuclCOQyx/
         YfGLLaFFXvF5gRQZV/WeqyjNYP3Z95NUCEHzaZZzQ0s1kq6Lyjl/MheGMbVir/X10UHI
         vwBXN8NKR0S5w9oDjfvyd0UZvJqpaaHdeWC1PtGa9BaGsEJ1ujeHpewdNNXGYctkAw5R
         spCJqfqidobA/76rodquKzChjiHNVpx49N+0Qf6pBOUKTcMTL1En4wA2lUz7Y/V3JfTr
         9HfAd2wNmYZtuTRKMWm5wOl7FRvHHp6dw0JBq5SgzPxMg/dxKcGPuk7139Vibx2DqElW
         XYnA==
X-Gm-Message-State: AD7BkJI297KJZiCS3Luk5atfOOANxphekkxHOD/IkV1QxjPLQQM892aBYhkZ1ZpHUlKPa4fWKLUFlF47JuWqMQ==
X-Received: by 10.176.2.238 with SMTP id 101mr7121675uah.139.1458925481704;
 Fri, 25 Mar 2016 10:04:41 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Fri, 25 Mar 2016 10:04:41 -0700 (PDT)
In-Reply-To: <20160325154638.Horde.LzlsD6cZcQfmt894cll_0Tl@webmail.informatik.kit.edu>
X-Google-Sender-Auth: PcU3YaJEggPYeXWvm-G4BdWwBR4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289908>

On Fri, Mar 25, 2016 at 10:46 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:
> Quoting Eric Sunshine <sunshine@sunshineco.com>:
>> On Thu, Mar 24, 2016 at 7:00 AM, SZEDER G=C3=A1bor <szeder@ira.uka.d=
e> wrote:
>>>> -cat >check-for-diff <<EOF
>>>> -#!$SHELL_PATH
>>>> -exec grep '^diff --git' "\$1"
>>>> +write_script "check-for-diff" <<-\EOF &&
>>>> +grep '^diff --git' "$1" >out &&
>>>> +test $(wc -l <out) =3D 1
>>>
>>> Our test lib offers the test_line_count helper function, which
>>> outputs a helpful error message in case the number of lines do not
>>> match.
>>
>> test_line_count() was mentioned in [2], however, this line counting =
is
>> done in the fake "editor" script, not in the test script proper, so
>> the spelled-out form $(wc ...) was proposed[2].
>
> Ah, yes, of course.
>
> But then the question is: why is the line counting in the editor scri=
pt
> in the first place?
>
> By redirecting grep's output to a file in the editor script, like thi=
s
> patch wanted to, we can count the lines in the test script itself aft=
er
> 'git commit' finished.  This way we could use test_line_count, with
> all its error reporting benefits, and we could use the same editor
> script for all tests.

That works too, simplifying the overall implementation, and
eliminating the need for the introductory patch which moves
'test_set_editor' into each test.

> And if you insist on doing the line counting in the editor script, th=
en
> why redirecting grep's output and 'wc -l' separately, why not 'grep -=
c'?

Ugh, I utterly forgot about -c.
