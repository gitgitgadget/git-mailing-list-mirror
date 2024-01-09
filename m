Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFAB3986E
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJIJUqBp"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d9b51093a0so2693115b3a.0
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 09:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704821090; x=1705425890; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg2RGaN8aUesG3GAU1WvE4oYhLTwr4XNRZyAdkA+qT4=;
        b=IJIJUqBp4BlNaxOojIJMxT2qjcNjCVH0sx6xoKm8p5IDSGoKJrcxOy80s/MniplRWu
         2MxxaEinDYfT/TRDrYrsGf6si/43yCFD5+i4BUuQvnyRzABD+V3bgnfesoLvaewW4AjG
         3oWjMI3rJlhDWs2y1vlrM6YtZVJV+5dcerVHgqwjX+QgSptpu/RwZYbEprdeJpXbu1ZA
         0uP/ccTcu3YT8v01y5Y0Z6eQHdtm5IBLZv5MH/deW/jQuOCsirGY9w8gDXZ5Id80XwWe
         b61CJGsfHisIFbm4kikyTsch/pDENZSpbjucNaDbmAPKBuhtCEr1tuUO/ChkYFrn/rbu
         /OwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704821090; x=1705425890;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gg2RGaN8aUesG3GAU1WvE4oYhLTwr4XNRZyAdkA+qT4=;
        b=tFJzknZW6dvPdQDDCPpqlX7mScJTERH6QQ1CaOkfl6w16qgiDG0OCxR343t+b6htAa
         l8ayhqFZu8vccDE2dXsX/SStBqTEVGmY1e6AGoW5FnWprPzn8CL9nx4SuWA1W1XNsj4v
         wtdqCy6lVW6pyIqU4M5Iuj8ToTVaA8NMGfxej59J1dVuUmgr3LKEnEFJo47NtHVbWfaw
         0KMjf2/X2hoX/+Jx1FT1YjLQ4odhcqNHnGGa4o/IeZ8HqO8s0SFQES6njGK4fUQ6zfso
         IxCZWTVUKE+cbpbEdDWRFabtmkw5JM2AAL+ZMwwtuBzCxh7Jx+Q8X27txq2Y5F+/coeB
         46pw==
X-Gm-Message-State: AOJu0Ywr/FRmbt8MkLi5EMYswfJv1lcV3UdKvpli5atIkUzjGgIb5baQ
	/O5fO+Hos0L/LCByUx/pwDQ=
X-Google-Smtp-Source: AGHT+IEq1a7mibHWHB7JH1izBvEqvmWtmg8dW+ACuB07xGoyKIZAt8NLx4NfL7iOXcO0SU4rJjt99Q==
X-Received: by 2002:aa7:98c3:0:b0:6d9:ce7d:d41e with SMTP id e3-20020aa798c3000000b006d9ce7dd41emr5916696pfm.40.1704821089927;
        Tue, 09 Jan 2024 09:24:49 -0800 (PST)
Received: from localhost ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id l8-20020a056a00140800b006d9ce7d3258sm1910369pfu.204.2024.01.09.09.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 09:24:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jan 2024 22:54:46 +0530
Message-Id: <CYACMZ0L7W54.1VITNQ1ZHLZDP@gmail.com>
Cc: "Christian Couder" <christian.couder@gmail.com>
Subject: Re: [PATCH 2/2] t7501: Add test for amending commit to add signoff.
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
 <20240109060417.1144647-4-shyamthakkar001@gmail.com>
 <2113e178-149b-49aa-9d78-ff1c480f754c@gmail.com>
In-Reply-To: <2113e178-149b-49aa-9d78-ff1c480f754c@gmail.com>

On Tue Jan 9, 2024 at 4:14 PM IST, Phillip Wood wrote:
> Hi Ghanshyam
>
> On 09/01/2024 06:04, Ghanshyam Thakkar wrote:
> > This commit adds test for amending the latest commit to add
> > Signed-off-by trailer at the end of commit message.
>
> If we're not already testing this then it seems like a useful addition,=
=20
> thanks for working on it. It would also be helpful to check that "git=20
> commit --amend --signoff" does not add a Signed-off-by: trailer if it=20
> already exists.

I hadn't thought of that. I have hastily sent the v2 without seeing this
comment. I will add this test in v3.
>
> > +test_expect_success 'amend commit to add signoff' '
> > +
> > +	test_when_finished "rm -rf testdir" &&
> > +	git init testdir &&
>
> As Christian said about the other patch in this series I don't think we=
=20
> need a new repository here. In our test files we use the same repository=
=20
> for the whole file unless there is a compelling reason not to.

Updated from v2 onwards.
>
> > +	echo content >testdir/file &&
> > +	git -C testdir add file &&
> > +	git -C testdir commit -m "file" &&
>
> I think these three lines can be replaced by
>
> 	test_commit --no-tag file file content

Thank you for the suggestion. I have updated the test to use test_commit.
>
> > +	git -C testdir commit --amend --signoff &&
>
> > +	git -C testdir log -1 --pretty=3Dformat:%B >actual &&
> > +	(
> > +		echo file &&
> > +		echo &&
> > +		git -C testdir var GIT_COMMITTER_IDENT >ident &&
> > +		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /" ident
> > +	) >expected &&
> > +	test_cmp expected actual
>
> This section of the test can be improved by using test_commit_message
>
> 	test_commit_message HEAD <<-EOF
> 	file
> =09
> 	Signed-off-by: $GIT_COMMITER_NAME <$GIT_COMMITTER_EMAIL>
> 	EOF
I have updated the test to use above approach.

Thank you for the review!
