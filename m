Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A81801
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 02:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8uVJTT6"
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EDC115
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 19:15:06 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9e072472bso2495775ad.2
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 19:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697768106; x=1698372906; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahb8c91og6zFNKTdYJ6WW7Dhk4W12Svo5LeO05Sb5C4=;
        b=e8uVJTT6XZoA7jHojD+iG8ymVy9kkBNPxJ+YtTBVZVEEAFUOTXXOCLPOBX7PkvOniA
         DkMBwfdQlfdyOPFZxzc6U6A0gt3ffAyS77Po/NJoPAc0YI/b7fvmtNRIq8vs6yYw6wr2
         /sN9fc2yYSGflnPZB/41wa9xC+0Kmtlh34pKRAFw9ORgbUKk6T4JxHoSCHlt1Q7YSoUL
         m8wWRBTIbd9MbwziIBMyyhYPkapI4onZoP1ubVTyXXYK/XGWaN9vZsVGXBNmElTQc2hd
         T/uVVUCrkTY9Ed5hm8R6FwsWUO//Cq7WZUrmTmILBOZiHGLm0JWGR8Md/K06Rm/vXe+N
         0hgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697768106; x=1698372906;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahb8c91og6zFNKTdYJ6WW7Dhk4W12Svo5LeO05Sb5C4=;
        b=gkMlfa2F9P501Bndfji4JSF7aGmomMlexPE5ACv4cqOJT/DMHhAqWivDUZSDlH2U28
         Hj7NTqjSuS4stMTtIZdu7Z1O7YyErn6p6NqFCrPFoBu4pWV3tZx9GPiOs7QUrM9FA+hz
         gcLotohPm5A/2/5K6pxyWVp1HXBKiNRcd7elCg53Om7UMsbIpelCPYABRi6MIBK+j/Xh
         n+z9TA+v44ir/j30QFZ4tSJHt449yGjFEnM5XcKMMgwWcB65VRkdFRapzcPmmThPY7uM
         jXGh9ZYHdkDElHgL8vSnTv4iKkrhPOyZr+p1+0CRR6bwVcsEhu8t85rFaIDBeeTkgv/i
         FtnQ==
X-Gm-Message-State: AOJu0YzyLthC0YZ1HoxB6OSWsTQfp2E/L3jap4gxyDFSfDcyM3HFbLQ6
	uv4LqwhhA9/ab870NX+oggQ=
X-Google-Smtp-Source: AGHT+IGzcejT2fno3nunqsBxC9gf4AlpY4sp9k8xCJyOneA08L1wpM2WLDvtNwP1s71lxVG9HTvsXw==
X-Received: by 2002:a17:902:c74c:b0:1c5:8a0e:b01e with SMTP id q12-20020a170902c74c00b001c58a0eb01emr474731plq.63.1697768105702;
        Thu, 19 Oct 2023 19:15:05 -0700 (PDT)
Received: from smtpclient.apple (ec2-54-254-241-62.ap-southeast-1.compute.amazonaws.com. [54.254.241.62])
        by smtp.gmail.com with ESMTPSA id jo23-20020a170903055700b001bd99fd1114sm366893plb.288.2023.10.19.19.15.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Oct 2023 19:15:05 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] typo: fix the typo 'neeed' into 'needed' in the comment
 under merge-ort.c
From: =?utf-8?B?546L5bi45paw?= <wchangxin824@gmail.com>
In-Reply-To: <xmqq5y32zgnk.fsf@gitster.g>
Date: Fri, 20 Oct 2023 10:14:51 +0800
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <42D0A6FD-1314-4977-92E6-BF6535D82E8A@gmail.com>
References: <2DB9ED79-FE58-4072-91E0-B4C51A3F6C5B@gmail.com>
 <xmqq5y32zgnk.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

It is my official name. But the email address is not a valid one. Should =
I rewrite the commit message?

Best regards

> 2023=E5=B9=B410=E6=9C=8820=E6=97=A5 01:05=EF=BC=8CJunio C Hamano =
<gitster@pobox.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> =E7=8E=8B=E5=B8=B8=E6=96=B0 <wchangxin824@gmail.com> writes:
>=20
>> From: foril <1571825323@qq.com>
>>=20
>> Signed-off-by: =E7=8E=8B=E5=B8=B8=E6=96=B0 (Wang Changxin) =
<foril@foril.space>
>> ---
>=20
> Thanks. =20
>=20
> We want to make sure that the "Name <e-mail-address>" on the From:
> and Signed-off-by: lines match.  Is your official name/address the
> one on the Singed-off-by: line?
>=20

