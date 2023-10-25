Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170AF2D62A
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbtSfS9p"
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F3D187
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 01:04:02 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9c3aec5f326so122366366b.1
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 01:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698221041; x=1698825841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAhuPGp0AbQUSAhusVx+532T6usHaQvtFEDbxXzy2yw=;
        b=HbtSfS9pN4JSIxPobi1kXImGeLD48duG33dI3IY9DvNalVRD7MGhVrp5KZx2JwAuw2
         xep5/WGDZQIBL2iBD3/qemPSlhe3D9OZ1xrdb+ymhsF76nIp3COgBTHJtsvoC9kkHz1H
         lJf8cWcHlNKGtPpIO3He5XZijNk1jPtZgkgM3BDB62bx+53f6N3xEaE9Dl5iBnFL8itO
         0fCf4rvDuYBmgUVgmEF4tultyDYL+fj6M19MHXiylIZrFHh8vJ5jfEnV3IlQ2xI4ClDT
         0PqR9FN04Cgt5JkbfGO/ToX/5wL9XnRVXnf/aRUlGD7fSulCu6sbrrQGqkdKclnmn+1F
         czmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698221041; x=1698825841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAhuPGp0AbQUSAhusVx+532T6usHaQvtFEDbxXzy2yw=;
        b=ctafyyhWdZPK2BCChl5AYDQOnV6wunA3HdXzAf4Gu9GYVqagVchQErNIVwq+HpzY6E
         ZuZcylyTSkVXooiChtM4YGuy2haMKKlvj5i2I7cdQuj208xv93vFsmXAVM0Mtu+HRfD7
         rlLTfoGIKplvyipXD4xDrRZcubbZh4KPKu3J0Djw0XbHRj11vYQvA49HV7LUwv2+oAIS
         9+9T33s8QEM7/PcyZOPBKLbse2ahfkacvvJzCkFUeCNgxD5t+UlNXOT60IRLhCKI5i0a
         dqHcZ2Gc8LBtkntqwAkJaWUE74ncLz9lcmqU0qpZo6BM2D4aBbci0xJg0axNFHFoSeQP
         OPUA==
X-Gm-Message-State: AOJu0YwHs9pYJPfkzSIqTqr51H8gUwYAde3zTX76K2DpMP3ia8Bh56uh
	0gS1luDkh+bAreSeGx3hhSlCWowIY61ilXLnH7w=
X-Google-Smtp-Source: AGHT+IFnt7M5p28BO1iKlkpwXe9vWa8dUeFj0CpDM3x8lXiIA45Nvn6658QRQfDTH8E+SwFij7kiYwMu7fYaiDOHxRY=
X-Received: by 2002:a17:906:6a13:b0:9ad:8a96:ad55 with SMTP id
 qw19-20020a1709066a1300b009ad8a96ad55mr17255535ejc.14.1698221040691; Wed, 25
 Oct 2023 01:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACS=G2yJa3xvCPN6bqsa4+vSkwsdUouhqNvuH6y_CC2cJ0YSmQ@mail.gmail.com>
In-Reply-To: <CACS=G2yJa3xvCPN6bqsa4+vSkwsdUouhqNvuH6y_CC2cJ0YSmQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 25 Oct 2023 10:03:48 +0200
Message-ID: <CAP8UFD3athDOto3vMr_SgSTZG_3ny=yyZ22fGcV5yoWNjJo2fA@mail.gmail.com>
Subject: Re: [OUTREACHY] Final Application For Git Internshhip
To: Naomi Ibe <naomi.ibeh69@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 9:48=E2=80=AFAM Naomi Ibe <naomi.ibeh69@gmail.com> =
wrote:
>
> I'm Ibe Naomi Amarachi,I'm a Nigerian and I currently live in
> Lagos,Nigeria. I'm a graduate of the African Leadership Xcelerator
> Software Engineering program (ALX SE), with specialization in backend
> web development and I'm applying for the "Moving Existing Tests to a
> Unit Testing Framework" project
>
> Some of my projects that involve working with Shell,C and Git can be foun=
d here:
>
> https://github.com/Amarajah/alx-system_engineering-devops
>
> https://github.com/Amarajah/alx-low_level_programming
>
> Git has been a part of my software engineering journey from day one
> and it's allowed me to collaborate with peers and also keep track of
> my personal projects. Currently Git uses end-to-end tests for error
> conditions that could easily be captured by unit tests, the project is
> aimed at turning end-to-end tests to unit tests, and I'd love to be a
> part of it

Maybe a period is missing at the end of the above sentence. Otherwise Ok.

> My microproject contribution is here:
>
> https://public-inbox.org/git/20231009011652.1791-1-naomi.ibeh69@gmail.com=
/T/#u
>
> And here is my updated contribution link after review by the Git communit=
y:
>
> https://public-inbox.org/git/xmqqttqox5cp.fsf@gitster.g/T/#u

It could help to say if your contribution has been merged to 'master',
'next', 'seen' or not at all.

> Below is my project timeline:
> (Of course I'd be very much willing to work with the community and
> mentors to edit it so it perfectly meets up to the community's
> expectations)
>
> October 2, 2023 - October 30, 2023
>
> Familiarizing myself with the community , mailing list and
> contributing my microproject
>
> November 20, 2023 - December 4, 2023
>
> Familiarizing myself with the already existing tests and also the
> chosen unit test framework
>
> Do more research on the internship projects and find better ways to
> get it done in harmony with coding guidelines and community
> requirements
>
> December 4, 2023 - December 31, 2023
>
> First document the initial state of the test files, then make sure all
> test files conform to coding guidelines down to the tiniest details
> (e.g git/t/helper/test-write-cache.c and git/t/helper/test-advise.c
> have die() messages which do not conform to coding guidelines)

We don't advise spending a lot of time during your internship with
small things that could be part of someone else's microproject later.
You should be focused on the internship goal first.

Of course if you are migrating some code to the new unit test
framework, it's Ok to improve that code before migrating it. But no
need to improve everything under t/helper before starting to migrate
parts of the code there.

I think that one of the important tasks to be done early is to
identify what code in t/helper is unit testing C code and what code is
really about helping other tests in the t/t*.sh scripts. It would be
nice if you could give an example of each kind of code.

> January 2, 2024 - January 31, 2024
>
> Run the tests and verify they still work as originally intended
>
> Begin migrations of test files
>
> Test migrated files and make necessary changes based on feedback
> received from teammates and mentors

An example of how you would migrate parts of a test, or how a migrated
test would look like, would be nice.

> February 1, 2024 - March 1, 2024
>
> Continue testing migrated files and making necessary changes based on
> feedback received from teammates and mentors
>
> Document each step and request for reviews from teammates and mentors
>
> Tidy up the project,make sure all necessary files are migrated, they
> all work as intended, they are well documented and that there are no
> conflicts

Thanks,
Christian.
