Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5FD1095F
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ekOoUori"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1702D1BE4
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 04:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1699446361; x=1700051161; i=johannes.schindelin@gmx.de;
	bh=CE1FtxJUY+FMPU58NyMNdcOkIzSF+IQZjVyjvRyiMzc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=ekOoUoriTYwUxzjN/LII5FIQuzLzLGwMmnz1xZH1Cdm5f5YaQ4iG1JM2RbV6PRGA
	 ZNGnQ1YCD9acMFoTsfzcZu/9ZLXj+2cG1r9WPo9xy+0VDrwpMOoUncXXrCdlGr4B4
	 BeVA1l9pmIqtFvfA5LO+hKx+P2EmFFEPu1tVb1qc+PqM++NYJeALKuITCa86YXD/p
	 E7SCyyuw5iShxbAdReAfttOAKgCic+kjNYs8iZGDooUa/Ba0h8sXypWTArscGIlm3
	 Sn/ZID0v2WmKfa33NpFEFydihoOySDcSzHi4f5VT6v+Jf7oFGg6PWM9RSEOd8l8kG
	 iUJLWusB0/3Hy34ERA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.49]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAONX-1r6Qvy1U31-00BtJe; Wed, 08
 Nov 2023 13:26:01 +0100
Date: Wed, 8 Nov 2023 13:25:59 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <christian.couder@gmail.com>
cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org, 
    Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
    John Cai <johncai86@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, 
    Dragan Simic <dsimic@manjaro.org>, Linus Arver <linusa@google.com>
Subject: Re: [PATCH v5 00/14] Introduce new `git replay` command
In-Reply-To: <CAP8UFD09dZbrbebRFZvarY71q5Vc0YBfRQHbTg7A3H-qM2g8fg@mail.gmail.com>
Message-ID: <1f2959d7-6e0f-bc8e-8341-56a1221dd48d@gmx.de>
References: <20230907092521.733746-1-christian.couder@gmail.com> <20231010123847.2777056-1-christian.couder@gmail.com> <bd872b81-80a9-5e4e-dcb6-faebc9671848@gmx.de> <CAP8UFD09dZbrbebRFZvarY71q5Vc0YBfRQHbTg7A3H-qM2g8fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-963508088-1699446361=:511"
X-Provags-ID: V03:K1:DJI+o6rG6nhxPtiE84XR1QO6AmMTEeW0S+aV3z4cOb2Kx4YDhto
 Mnc076EDhWTqYPCMymKjZktahPKDlttWLrEuwQYGR7cddMHeKZ4w8OpoV8bBwEAp4m1yJDN
 A0t/qidF2jy/qXBdfdMQvzZR3J93o84qvN3jTIoGL0PznyBDi3PyR06m0WAW8qHwfnFK/Ik
 MCF6B/2ZmaYisJj8/598Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bLzAYl5WcnI=;BYHcEIvFacvYOnM/7b24kG2gEWl
 OY3VEvdWIQiZAaGAmqEt1nK/woLP4VDmXsxdeanxyDGpqxtUkxa9YiwwCVO7rtqkMI0xsZDMk
 hvJR1WksArYxU/yeF4EFNFGPrQPk6KnH/SCVWxS6hqtrI5MBALdaCn5oIOgQg8OlWteLjnXPy
 Oim6xiVwiArE8bP6heig6NQT7Yoxqy2jCAUmr07VE5UvFDA9kb/4jpEhKQc61OtyoMaTQN4Bs
 SyqOfliwZL6262H1TtBwUrV52KTFwtp8MqQM8J8rSYDv9RwhBVv4mhnt+VOtPBBKIU5KmmDmn
 KcLEhJQvqHxXuJzKtD8ggq8hKbNKRMWrWXxCBQdNu3NPv5Ab+GOXJPBpwHK+suh6fRA1eZeHS
 QdK1sbN/Fy+yEw4o4ripNI3lJ1RkFq0MgXzV0hN51Gk2kwjfID72YvWgkZQ+k0q/l626uEG/c
 medmhv/NY58kPdfL9OXVWFyPTjY6g9/TyMTobLnTTrpzWDRXgze/Lt9H70gzwfvSg2OXu1PjU
 ZLEZ/dpQTZgr0LE+jEXcsGPKjRQQzVsuY22rEtcNiFwKqRhedn+CcSO7VC5VsFH41OCq0XkBI
 DOwQL+pjxyRURwLJpTFrXwqWT3MjftB14lGUlQd4Uy10qO87zyaz5KrGaxS+0Bw6j4qAUTBL5
 +29hdFDSIy8oyQK8DHBKQJoNOkjl0NP1fyli69aqR2oB80YX8soQi7mqud1tT57OvMD2eeLGV
 8DMjYsokldOfgEPzhKYNaajJbfR5zJHMO4Ywu3g7+1KK3j7UDmw3z2MvZZWwYHiHxFpO6eonJ
 R4babuf2I4D/gWu6TMar6MRd2E1nUeMcWDMBTeP1ZiWg+yFJ3ivkl5PWR2mKvEzYP7X8TBaf7
 0AC7AD53PJ47Rt053z4yov7Ar+0qs2i9LhTjmNyrmPOqwtuQMAWrTVU4kGmVRVGy+oNLD7iuq
 ez1pAA==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-963508088-1699446361=:511
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Thu, 2 Nov 2023, Christian Couder wrote:

> On Thu, Oct 26, 2023 at 3:44=E2=80=AFPM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > In addition, I am still a bit uneasy with introducing both the manual =
page
> > and the test script in this commit (see my comments in
> > https://lore.kernel.org/git/03460733-0219-c648-5757-db1958f8042e@gmx.d=
e/).
> > It would be better to uphold our high standard and introduce scaffolds=
 for
> > both files in the first commit, then populate the file contents
> > incrementally in the same the patches that introduce the corresponding
> > options/features/changes.
>
> I have tried to improve on that in the v6 I just sent, but there are
> many patches implementing changes in behavior that I think weren't
> worth documenting and testing in `test-tool fast-rebase` (which had no
> doc and no test) and that aren't worth documenting and testing
> specifically in `git replay` either.

Thank you for putting in the effort. I appreciate it very much.

Ciao,
Johannes

--8323328-963508088-1699446361=:511--
