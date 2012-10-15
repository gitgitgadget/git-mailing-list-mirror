From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: add format-patch options to send-email
Date: Tue, 16 Oct 2012 01:57:03 +0200
Message-ID: <CAMP44s3T-kBgN7ihzLQJKZqFtAM6_ne2QF3+THU9z0YsqGp+hA@mail.gmail.com>
References: <1350231243-13485-1-git-send-email-felipe.contreras@gmail.com>
	<20121015224857.GA2156@goldbirke>
	<CAMP44s07iydg0aMDQMTX7qh4Kk8w--sp1DtmTUeu=95WzAXfRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 01:57:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNuX6-0004jN-MD
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 01:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860Ab2JOX5F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 19:57:05 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:54150 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab2JOX5E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2012 19:57:04 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so5617064oag.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 16:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=YC/QOGw3cX5rUBsACr4sCKCxF9xDqS3JQl2b239kJ9Y=;
        b=vU+xtQXOti+dtGyrWG1rD1dh/s12XZIvdYgNPw+S40/Rc7yM5QZn4GgWfT1aQjMQ8S
         fZr157qgjHTSr51EQHz3fKPUgVkh2ENN503LANnOaCcSAziSuaqmF80YxcMq0Ju81fQq
         YaIH58T4JtC/nKAHF5d1jnd0TkOo04G9ooMAyYfxru2uOIz6AK3NNXWLDaPjQFuwQjZV
         7DahDYVWhjxzuFL7k9XIwZK6zKcP3zVRyF4atQEiO6s4ho6UaEYaDrmqQzWJezVkSeLV
         cskw5+xb5xJjE8Y/+r+ZLTVS1zAHRUa2yezm1PlYqz4VxfzXGs/oNpMpbiO3Po0BSigV
         posQ==
Received: by 10.60.31.241 with SMTP id d17mr1855710oei.107.1350345423469; Mon,
 15 Oct 2012 16:57:03 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Mon, 15 Oct 2012 16:57:03 -0700 (PDT)
In-Reply-To: <CAMP44s07iydg0aMDQMTX7qh4Kk8w--sp1DtmTUeu=95WzAXfRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207789>

On Tue, Oct 16, 2012 at 1:37 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Oct 16, 2012 at 12:48 AM, SZEDER G=C3=A1bor <szeder@ira.uka.d=
e> wrote:

>>> +     cd test
>>
>> This 'cd' makes all subsequent tests to be executed in a different
>> repository than previously, which breaks 'checkout completes ref
>> names'.
>
> I don't know which test you are talking about, it's not on my repo,
> and all the completion test pass with this patch.

Maybe this then:

test_expect_success 'prepare' '
	git init &&
	test_tick &&
	git commit --allow-empty -m "Initial"
'

I originally created those for some push and fetch tests, but that
required too many reorganizations, and I got fed up with the review,
so I dropped the series[1].

Cheers.

[1] http://article.gmane.org/gmane.comp.version-control.git/197226

--=20
=46elipe Contreras
