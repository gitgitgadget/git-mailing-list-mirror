Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963468F44
	for <git@vger.kernel.org>; Sat, 30 Dec 2023 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbwDVzmv"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2772011f8dso191431766b.2
        for <git@vger.kernel.org>; Sat, 30 Dec 2023 06:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703946107; x=1704550907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpnTmbIJqgpOUPtxyTMkYAOxnqjYJDbV45T1wtg+3Do=;
        b=KbwDVzmvp8QoxEMNeFqHgJScmWKPtHmzGCLkPELn+Grk3MG/S00vMWfWo72sziCCId
         Zyer0QwlrRYwKNmcl4ZFLbtP6bsU6yscekhoKvAlrSw7h8neZWDHlrVxtRtWyay5Y9js
         Byi5kUjAPYjt5yqRgwO4OqB9iqOiwRqYTi7wSyZm2fEARczgcQXOJ7Mi2k2FcTxUcRIn
         RSmMagQ1QBkQlq5BnTLZouH6+svcaXfQnydT6iLqqZOjSjNXjipvh8295m8FJ52yU7VA
         mQdc8BSy3eITLfqCLfAFiRsxajc5VcDhClGdhBWMPLiWK8JzO6A6zU6ydZNJk+i50aZq
         W1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703946107; x=1704550907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpnTmbIJqgpOUPtxyTMkYAOxnqjYJDbV45T1wtg+3Do=;
        b=PUn8Br1h1CCKzDsgWTrSp1EcBVI1ULHT1YV74YGRTJPkbOqoiVxR8jpTquGyQQ/De8
         miep11wnd3YikvdEXN6vftj331bn9zB6wZVTrDKPx3CKsdm/oCS9BC0+khvPDl5CZQ+k
         fxmhr/BPU5++b9Xa6Y8rlnyX3st+IxQwRFGyO7l+kp3VztDasaLtGGupf36b5qiyx7um
         2+9oRDoCAcuGCYFIpM99RHCOe41SGFDG1ajia6NIoTYwiQApereV1OSO/pqXmgrGdrSM
         rabZvfdotXWXwPQrUVc/QUQqaTadfvu26F7ve4PwcEmYxoK5MFmUU9mwWfOH94+MDd4N
         q/Jg==
X-Gm-Message-State: AOJu0YxcZVXd6O/4ZPnqlAs6eBH5k5xO1HNxbpu/5FYC8eTRFRSufdD5
	77oh7XUFUsKBngo6KRTF1nBBHCpj4UvfAELr3BCqatZ/ep8=
X-Google-Smtp-Source: AGHT+IFA03gLRCUQI3VypeDfaIr2jOaIkSECcJdaVnPc5y1x0qdtPNnVqibBmfp9oreBgl9fkWeTxiNJIgDyLO3eLZk=
X-Received: by 2002:a17:906:a892:b0:a27:99ca:856e with SMTP id
 ha18-20020a170906a89200b00a2799ca856emr1138072ejb.10.1703946106442; Sat, 30
 Dec 2023 06:21:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7aefb4c3-da1b-429b-a519-044084265994@infohubinnovations.com>
In-Reply-To: <7aefb4c3-da1b-429b-a519-044084265994@infohubinnovations.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 30 Dec 2023 15:21:34 +0100
Message-ID: <CAP8UFD1uRia7csCjtRuUVySPjwN=W_BgKweU=KW4nd-5rK796w@mail.gmail.com>
Subject: Re: You are marked as spam, and therefore cannot authorize a third
 party application.
To: Ramesh <ramesh@infohubinnovations.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Dec 30, 2023 at 1:34=E2=80=AFPM Ramesh <ramesh@infohubinnovations.c=
om> wrote:
>
> Hi GitHub Team,

This is a mailing list about Git, the command line tool, not GitHub.
Please don't post here about GitHub specific issues.

> I am trying to clone my repository from local machine.But i am getting
> the follow exception that  "You are marked as spam, and therefore cannot
> authorize a third party application.". Can you please suggest the same.I
> have deleted all my accounts except this account.

A quick Google search pointed to this which might help you:

https://github.com/orgs/community/discussions/67196

Anyway, please don't discuss this issue here further. The GitHub
support team is not using this channel to help people having issues
with GitHub. So we cannot help you further.

Best,
Christian.
