Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7073F18C21
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3UG/Zb/"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3608cfa5ce6so28488655ab.0
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 17:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705110441; x=1705715241; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuxGGW2lJlD9dGUfyf8MsSyCqoix2U+cOR7PrhdZmss=;
        b=V3UG/Zb/rOV8v3ZqtMl9Pp2Zy7z2FLA51sxJLTAllTgMsemSAoftBKe+vzwL49qKR2
         ZXTEV9X+iW1xtNUZNV1CkRwJ7c3FLYe+wJD3KdENe0F3YovDWAtmV0G8PYfqq4KcKuI3
         AcEisAfRCB6qA4tAHFN480JjiL0MlpiQXCXsDz6f+jGj6q0VS7D9/bwXNcngXPWdOcar
         T8A6bwLF8M0lxn/dts7l8vdqCjyha/li2THCvmAPxwih3pGCwCOIbLwtjyNT81l5py/o
         uWDOofCyj+3iV0XMHBgwsjNj6m+LXYiT6/VTuHX0s3SHlmwks9Mh2U3QgqoFEXxpWlDq
         aZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705110441; x=1705715241;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tuxGGW2lJlD9dGUfyf8MsSyCqoix2U+cOR7PrhdZmss=;
        b=bDHxIVI6vhA5LlmCr3eWKwBYMPDBlsvy7FNErzAx+quQW/eszt7dlrspyxhMusRXtu
         wuCFv9kfYeknjd1gJP2alk4/gOyPrZGecIchZtir2qDV8z6kpyR3C2zlvSY5nKO7+Xqc
         NdVyOWyK2L6PiQ14SXjVLhsNg3/8WFA7THL8vhLdMeQQnFDkqkzlcUDOakwd4a3z3VZK
         23l7Ih4dUBr+2UAfY3X9t2FK6LG4AjIXpC5+L70vktE8uz1yhUsl+Y+zPB5fbBKwOvWZ
         mUvnbkH9Yq8qIqOYspun6C3SZPOksrFosJCMqmaSDOt8otiJMOsVI9eZ81vct0i/W+zP
         Xw9w==
X-Gm-Message-State: AOJu0Yz/Y/KDftpNRVWwnM/qui6p5j2RaRSgvoUOY5WxVNZYFZ80WMZC
	LNjIPzt1ZVPonTSASy6FUAE=
X-Google-Smtp-Source: AGHT+IHIZqb8Yxp/l3Vq+Ljr7iZQwvMdot8PJn8jXDOHs1hHz0t7DwjFYrTSZvYBGWBBbjIqN+xuWg==
X-Received: by 2002:a05:6e02:eca:b0:35f:ed80:9c7b with SMTP id i10-20020a056e020eca00b0035fed809c7bmr1862228ilk.44.1705110441271;
        Fri, 12 Jan 2024 17:47:21 -0800 (PST)
Received: from localhost ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id iy10-20020a170903130a00b001d3b7c5776asm3815681plb.160.2024.01.12.17.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 17:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Jan 2024 07:17:17 +0530
Message-Id: <CYD77D4H2KDG.R1QV6H1T89SN@gmail.com>
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: <git@vger.kernel.org>, <phillip.wood123@gmail.com>,
 <christian.couder@gmail.com>
Subject: Re: [PATCH v4 1/2] t7501: add tests for --include and --only
X-Mailer: aerc 0.15.2
References: <20240110163622.51182-2-shyamthakkar001@gmail.com>
 <20240112180109.59350-1-shyamthakkar001@gmail.com>
 <20240112180109.59350-2-shyamthakkar001@gmail.com>
 <xmqqmsta58ya.fsf@gitster.g>
In-Reply-To: <xmqqmsta58ya.fsf@gitster.g>

On Sat Jan 13, 2024 at 6:46 AM IST, Junio C Hamano wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
>
> > +test_expect_success '-i/--include includes staged changes' '
> > +	echo newcontent >file &&
> > +	echo newcontent >baz &&
> > +	git add file &&
> > +	git commit --include -m "file baz" baz  &&
>
> I may have said this already, but the command invocation that does
> not result in an error smells like a bug, and I doubt that we want
> to etch the current behaviour into stone, which may make it harder
> to fix [*].

Yeah, that is why baz is added in the index in the test before the one
you quoted. And as I understand it, when everything is in the index, it
works as intended. Therefore to not get in the way of amending this
behaviour, no untracked files are being (attempted to be) committed in
these tests (except 'fail to commit untracked files' test, but that is
not what you quoted above).

> Another related behaviour that I suspect is a bug is that if you did
>
>     git add -u baz
>
> instead of this "git commit -i baz", I think the command will
> silently succeed without doing anything.  They may be the same bug,
> because "git commit -i <pathspec>" is an equivalent to "git add -u
> <pathspec>" followed by "git commit" after all.  Both should say
> "there is no such path to update that matches the pathspec <baz>"
> and error out, I suspect.

Yeah, just checked, that also succeeds silently.

> Thanks.
>
> [Footnote]
>
>  * A reasonable way out to unblock this particular patch may be to
>    clarify that this test is only documenting the current behaviour
>    without necessarily endorsing it.  Perhaps
>
> 	echo more >>file &&
> 	echo more >>baz &&
> 	git add file &&
>
> 	# Note: "git commit -i baz" is like "git add -u baz"
> 	# followed by "git commit" but because baz is untracked,
> 	# only "file" is committed.
> 	# This test only documents this current behaviour, which we
> 	# may want to fix, and when it happens, this needs to be
> 	# adjusted to the new behaviour.
> 	git commit -i -m "file and baz" baz &&
>
>    or something, probably.

as stated above, baz is tracked from the previous test. In any case,
I will add a note just to document that untracked files also do not
give any error (when there are staged changes) but are not committed.

Thanks.
