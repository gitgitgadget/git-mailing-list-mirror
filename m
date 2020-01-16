Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BD6C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3032072E
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Bm5AU/W8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgAPVqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:46:42 -0500
Received: from mout.gmx.net ([212.227.17.21]:50129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729388AbgAPVqm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 16:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579211197;
        bh=t1KdGqRkZwMXdsw1HuuzvcUq183DRomihEFDdufz1uM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Bm5AU/W8ZPb6urDh8oeRNoTIUlqZh96MG6Y+JUZ8rTGkM/0/4P23St2OYg2R/zpFp
         Nkq4mT+3tOeTmmQpaZg2/idNsqZaobTQ6G1EgIp07sDc3qka9TjpmMn6NypU+tSt6M
         5+hH6LSXFzy1UeBADu3tVTEPBvTKvU0UpXU+bTh0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbzuB-1jVOCo16xr-00dZyS; Thu, 16
 Jan 2020 22:46:37 +0100
Date:   Thu, 16 Jan 2020 22:46:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 0/3] t6025: updating tests
In-Reply-To: <20200116203622.4694-1-shouryashukla.oo@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001162243100.46@tvgsbejvaqbjf.bet>
References: <20200116203622.4694-1-shouryashukla.oo@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4P25qt2ycOiMaPQlzneoMsMSi1RmZkNji2og6eIXxpOGXBpRb4o
 jfROyZM1v8YEbzKEi1aLfSBO9zbsC0hMPco1QuG5GceI4ZY0JsXvByfHAcO05NgAxLwbb0X
 9dfBOGkYgqXSpsJXUcvfuUbcUE3dgMWTVZgLR4Y54FgvxdnROhKzU/vk1rwL2VDBl6R57TL
 ZKaGNjcAWpSbh7BiWrtyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:URM54kArEbU=:/02Y4V7ES9dHTeN383HIv2
 dwChulLi4tBnPzMVjxtrzf9vfwFcQFp2PhbD+vVckKb4KonY4/mHOTeHO6d76LP3q2SBFzL8n
 lCa82n8xst52i38LJEuoD1OVp1WZ+UAJyJn+acaCqRWGb5ft460SZJMQ2AEA4QU5U0gjzodQB
 o28zy1stB1ma5Omdhf2Sj19q/5dBafYepxZ3ZKAxjolfG3zcKgks7SEmeOB27cwXl5MbGuSSW
 unlCjGYiyYBjzS9oBxgTc5hG5F86FPhpmg1rVg684loDYQDu+YbCxTDIVFFPSWOFvg5OEtykz
 1yg4Mp55OHiDHTuYnuR2oZw2/SXa730JYU7nCFtTiIJLcmKbVXT5YKeaE0j6Eg0QQZcgk8cYR
 4PmPDmoYovDwTy5ExfIl7gM8Gi2IeA0hpoJcGHSsPV+i033nz3Vkgw6RAD0Q9lwvl/P4PDC9C
 22lSnheJppWApwLzLbRsnJzEIsL7TFaP/sTFxcY4Ml+vFdrJzHHbrx6NQidFfJg7QGQEChJPQ
 m8g+actGjB0HgxcRDnGwQJpXrObR/28nin2opg1Yc6FhDxxKrvwBFp1u7lARqeTReHdkDV4Op
 yv8Z2Gr+D6VxaiJ3WpwNSD3DY148LNWD8g6bE/ekxPU4a8QEYWxTKYejo8wpTbOOqRyDhqOhf
 MUdrIgYSS7u3FucTeGBQtpNcN4cDKoFWH5V94Kk8PtUEyvtqY17du3dXm12HIjymhZwu+rjHz
 Y47DqTmxpDMWFrnek/IpkO6PzAH3fTvvpaoXUaW5oc5fuO1765YkZqvMejMl/YSmxnhJf9uNe
 6cD4EZAQWyyuWjkXmzu8Ub/eSBLMHsxVh0mHZEAZRf282GAmx7Xfn8XCgz6pG4CKYUP3FIas7
 531TRE5Sd2WLNfuqpfbWZ32m1HMndfBrW+12inboOaykONdheG7sVOWev9Si5Z8xmSxvRmGPw
 6oVUGXjMP52bPByrraL+HLY+0V+DQLm94aV9uW59R8L2YIMufCKCDTLqf/KZdTDboPBEpJ1+m
 TLDf4LVUabWb3u5pEQGau374E4ZCSHN3wXJyq0oc7A8gLdDRpvQR7JRhQCyOGh5CGhAYa2hhv
 hiqi0He4boE/h4uRA2q6/jfROnkolIYMP4QLG9knoPK2nTpkfBaSgUYYyMSkGKt2WgtiGmFV0
 /0/yW/7drxwKM/fsLxhQpTU6rT5Zud3gJn6DtC+idjDqCztDcJwlaN0EcsNHuGPHJCJBfVoiB
 gCmJqzmaRa0Q0o/tDiVz4RL7jrqRJajclNubPq5LXQ4l6sFu51QiQkwi6+tM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 17 Jan 2020, Shourya Shukla wrote:

> Greetings everyone!
>
> This is my first ever contribution in the Open-Source Community and I ch=
ose Git
> for this purpose as I have been using this important tool to maintain my=
 projects
> regularly.
>
> In this patch, I have:
>
>   - modernized these tests so that they meet current Git CodingGuidlines=
[1]
>   - replaced the pipe operator with the redirection operator so that one=
 can
> 	detect the errors easily and precisely
>   - used helper function 'test_path_is_file()' to replace 'test -f' chec=
ks in
> 	in the program as it improves the readability of the code and provides
> 	better error messages
>
> Also, I have some questions to better my understanding of the code:
> 	- In the statement,
> 		> git hash-object -t blob -w --stdin
> 	  is it necessary to explicitly specify the type 'blob' of the hash-obj=
ect?
> 	  I have this question because it is the default type of hash-object.

It is the default type, but:

1) the code is not broken, so why fix it?

2) it _might_ be possible that the default changes, or can be configured
   in the future. The original author might just have wanted to stay safe.

> 	- In the statement,
> 		> l=3D$(printf file | git hash-object -t blob -w --stdin)
> 	  I have not used the redirection operator as this sub-shell will be ex=
ecuted
> 	  separately, hence its error cannot be captured therefore the presence=
 of '>'
> 	  will not matter. Will using '>' improve the code?

It will be enhanced, though:

	printf file >file &&
	l=3D$(git hash-object -t blob -w --stdin)

will have a non-zero exit code if the `hash_object` call fails.

>
> Thanks,
> Shourya Shukla
>
> Shourya Shukla (3):
>   t6025: modernize style
>   t6025: replace pipe with redirection operator
>   t6025: use helpers to replace test -f <path>

Apart from one little issue in the first patch, this all looks very good
to me.

Thanks,
Johannes

>
>  t/t6025-merge-symlinks.sh | 97 ++++++++++++++++++++-------------------
>  1 file changed, 50 insertions(+), 47 deletions(-)
>
> --
> 2.20.1
>
