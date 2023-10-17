Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C45E41AA4
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaxRLhBq"
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89233FB
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 04:37:58 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7b91faf40so67398107b3.1
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 04:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697542678; x=1698147478; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZSHbqiVJ91MdEAgp+ZDTsYRfgO7hB6nwafZ7PNdsiA=;
        b=eaxRLhBqiy9V8g07L2+TjlEmGhHOjdAWo5W1QX+fhUbuotTzyerrhmTrrB1MfRG8WS
         qirhkoxdLX5EJp+Zip4edQDJHaI1RryX6Xe5kwj0qNTpF5rICY2G0/jjvjfSs/tM8+LA
         E9jyYQIPhbNS/t1nHsrlNYrvmWGfqGcg6IWSbu8109/aNqDXNHg27p4qeY4Uc6N10WVy
         LFxPWXLt7nu4OXqoLT1+wBOQ40R6agE0BulUzxvd1SQQSQ/s9mVPaKMAlqYMdPnKHqDd
         yRzUZuvSpEKd66eECPCBINYSs6/9fxAvwxL+Qxnf1CW63X3HK0D4ixX269Uy5yswJIcd
         p2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697542678; x=1698147478;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZSHbqiVJ91MdEAgp+ZDTsYRfgO7hB6nwafZ7PNdsiA=;
        b=WAqjF3knwnYN6aYJvSqqAH08lIYfczisAopaOmVgso3cvd2CO4Zb/7ouPoIzzPIBHv
         oWgU1i6Z1l2M3OrygaVAaD5eq9NfjnjhBc+fnUGn/ZWC2TwbofGVvKb27tzz0fPn/3FB
         pBZU3jltmGbLF7ERJJKHG3uzldRW2T7dNqhP5EOtgxkKWf4+JItuQLTqyCIt1jiLzJ+j
         qL5N0YAuYThRP/uWKvKc958CXhCEHuo/dlSgekbcDICsNCfF5rFEcq+XLcVZ6tLyzf9o
         rpBYF6jwZPd3kNPYKTV7myiPZDeM0J8+IsT2RxPcjCD0I2IXdbtZV38ssgBzzHMhHpzY
         JoyA==
X-Gm-Message-State: AOJu0YyTx5C1l69RYqqHWfBBLMWknq/p0KdHaLBC4W4poGoPuzBwQlOs
	VL2pSMqmnSI6firRK6/WgWFEbpjG3z3R5uQ5u+8=
X-Google-Smtp-Source: AGHT+IGJfAjSzn1p1zeeVHbct9/7W6ITkVcdXELPIKsxggBqze7B2NHEHNg10miUPPLLY31KNS+8qJ2o6zOwEHjw07Y=
X-Received: by 2002:a0d:c802:0:b0:589:e7c1:96f2 with SMTP id
 k2-20020a0dc802000000b00589e7c196f2mr1771186ywd.46.1697542677755; Tue, 17 Oct
 2023 04:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGP6POKg4mSFv-Z+dD1aXDFDbxH9Xu1WCdCA5TGfCAM3NUUQLw@mail.gmail.com>
 <ZS2qZtYDvItovjqg@tapette.crustytoothpaste.net>
In-Reply-To: <ZS2qZtYDvItovjqg@tapette.crustytoothpaste.net>
From: Hongyi Zhao <hongyi.zhao@gmail.com>
Date: Tue, 17 Oct 2023 19:37:46 +0800
Message-ID: <CAGP6PO+SeZPzD21nErX=Vq=+d6oy-kg+diu=irot3enOhpQNMg@mail.gmail.com>
Subject: Re: Method for Calculating Statistics of Developer Contribution to a
 Specified Branch.
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Hongyi Zhao <hongyi.zhao@gmail.com>, 
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 5:26=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2023-10-16 at 14:10:01, Hongyi Zhao wrote:
> > Dear Git Mailing List,
> >
> > I am a developer currently working on a project and I wanted to
> > establish statistics for each team member's contribution to a specific
> > branch.
> >
> > Say, for a user "JianboLin", I am currently using the following method:
> >
> > $ git clone https://github.com/OrderN/CONQUEST-release.git
> > $ cd CONQUEST-release
> > $ git log --author=3D"JianboLin" --stat --summary origin/f-mlff | awk
> > 'NF =3D=3D4 && $2 =3D=3D"|" && $3 ~/[0-9]+/ && $4 ~/[+-]+|[+]+|[-]+/ {s=
+=3D$3}
> > END {print s}'
> >
> > Using the above command, I am able to calculate the number of lines
> > contributed by a specific author on a specific branch, which allows me
> > to quantify the contribution to a branch by each team member.
> >
> > However, I would like to know if a more efficient or accurate method
> > exists to carry out this task. Are there any other parameters,
> > commands, or aspects I need to consider to get a more comprehensive
> > measure of contribution?
>
> Can you maybe explain what you want to measure and what your goal is in
> doing so?
>
> The problem is that lines of code isn't really that useful as a measure
> of contribution value or developer productivity, which are the reasons
> people typically measure that metric.  For example, with three lines, a
> colleague fixed a persistently difficult-to-reproduce problem which had
> been affecting many of our largest customers.  That was a very valuable
> contribution, but not very large.  I've made similar kinds of changes
> myself, both at work and in open source projects.
>
> Certainly you can compute the number of lines of code changed by a
> developer, but that is not typically a very useful metric, since it
> doesn't lead you to any interesting conclusions about the benefits or
> value of the contributions or developer in question.  However, perhaps
> you have a different goal in mind, and if you can explain what that is,
> we may be able to help you find a better way of doing it.

I want to calculate a certain developer's contribution based on
different standards of code line count and the importance of the code.

> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA

Regards,
Zhao
