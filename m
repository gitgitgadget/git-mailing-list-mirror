Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C8171C6
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NiV1grH1"
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C81D7
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 09:09:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so16645a12.0
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 09:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697818140; x=1698422940; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CF53732RURYKphBLu69DMvkYJcICdtdUM2ad3jiR744=;
        b=NiV1grH1X6JxTtsCkofomPiDu97yz8kEDTxhdU7/mLNdDAjE3PgpDhPN1ke633c0jJ
         9kw/3Ukf2bjzdZn2vIC6aFZHojv+4940AjTbHGxYn4V55ble2n9XbLYVxvTy4qjhcuNC
         +CR1ahqgXQiq0L48AQkFPLNcVODff9APLCwYhYIWAIe6U+jGGwgZ93lTbivekaqjlNXP
         ytlf5hCKT3GwL+Vaf20XzeJpsC7TQiTgabBT0GnfaYGHwjhr1FjJ4aifr+lQ0oCNUtB7
         j01/8A51LzO2zuRCruMTqcD4kpI34me0y5Ak59bA1vxCb9aCd4Q8DtfEf3JJu5O28fbQ
         zxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697818140; x=1698422940;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CF53732RURYKphBLu69DMvkYJcICdtdUM2ad3jiR744=;
        b=u/C7vGEjz1r0Yu2qoHF3km1x9p93Q6F/28OWvW6tJPTvUmnXhAVQZ6uTGVw4nAizP6
         flPVZx61MNPxTOZXTKEE+djzdUdJoiseRyuYtwDGyLyR/90PgrLIl9CBr8qtGKOqmznf
         3iObWWEUMYN+TGdUDj1cjVzdnwRp1R6hJyfH4iMmT2+li4ucxOCPVIAV7B0pgkFSyC/7
         Is9gB/p1Bq3q7wpZ/AM19o2dtLYzqHdjaetTbhtii14y/9K3Y/snlyH6SitDUVuwUjGZ
         uIg4SSf1HbtsZWZxnTM3qtUGqzJ5yMTmu/q3Hh/qbcv6GpirtZnXH41gFv04xNa0VKpr
         jd8A==
X-Gm-Message-State: AOJu0YxpSezLpdgkIIgTcV3G2/dpZtzXD0UZ9XI0+L3BykkzMHy4WZ5S
	yiAknlkGCodWRU7nh8JVMdKQArjy+Njs+wf6jcViILQh9yilZSlR4dRE04Ih
X-Google-Smtp-Source: AGHT+IGt9TtvdWTpvkifOCOJU9UL/yCpF/hiSATCQmspEKihdGFx1X+ujZGngD0jzPfLwoh5gAd6+pEzZwOrCyKRHqI=
X-Received: by 2002:a05:6402:332:b0:53f:c331:8708 with SMTP id
 q18-20020a056402033200b0053fc3318708mr128594edw.0.1697818140410; Fri, 20 Oct
 2023 09:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJoAoZkWWKGjv0-ANQJf7dMaiAJVnOMkvQpCcR8OpjZbop4rKw@mail.gmail.com>
 <1D0EE77C-6DEF-4509-9846-6897C73C7CDD@gmail.com>
In-Reply-To: <1D0EE77C-6DEF-4509-9846-6897C73C7CDD@gmail.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Fri, 20 Oct 2023 09:08:48 -0700
Message-ID: <CAJoAoZmdZFN+BexGSUCJaSi2nBJK3MoiTEBOWcY1qmZEGdh0vA@mail.gmail.com>
Subject: Re: Thanks and One Suggestion
To: Brock Whitaker <brock.e.whitaker@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding back the list - first I accidentally HTML'd my reply, and then
Brock replied directly to me :) In general, please make sure to keep
the mailing list CC'd on responses, Brock. (And turn off HTML in your
MUA. Don't be like me :) )

I agree looking in my own browser that the monospace - both inline and
blockquote - is a little difficult to read. Take
https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---amend
for an example of both. However, I'll leave it up to the git-scm folks
to recommend a fix.

 - Emily

On Fri, Oct 20, 2023 at 8:13=E2=80=AFAM Brock Whitaker
<brock.e.whitaker@gmail.com> wrote:
>
> The code examples are the hardest to read. My monitor probably isn=E2=80=
=99t helping.
>
> Brock
>
> On Oct 20, 2023, at 10:56=E2=80=AFAM, Emily Shaffer <nasamuffin@google.co=
m> wrote:
>
> =EF=BB=BF
> Hi Brock, thanks for your feedback. Could you specify which orange-on-whi=
te is difficult for you? There are a few different examples I see at a quic=
k glance - headings, fixed-width text, sidebar. Which is bothering you?
>
>  - Emily
>
> On Fri, Oct 20, 2023 at 7:20=E2=80=AFAM Brock Whitaker <brock.e.whitaker@=
gmail.com> wrote:
>>
>> Thank you for the git-scm site. It's an invaluable resource I use often.
>>
>> My only issue with it is the text isn't as easy to read as I would
>> like. The orange text on a white background is a little tough to read
>> sometimes. A higher contrast between text and background color would
>> help.
>>
>> Splitting hairs,
>>
>> B
>>
>> PS - Thanks again for a super useful resource!
>>
