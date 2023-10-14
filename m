Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACDD125B0
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksLRxPkE"
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69A0BB
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 09:41:22 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53e2dc8fa02so3798857a12.2
        for <git@vger.kernel.org>; Sat, 14 Oct 2023 09:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697301681; x=1697906481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SUzK13Qn1PfXC3u9zSb3SW6KyC5d2HbISCOTAbAuk8=;
        b=ksLRxPkESj/sSkg42Y405OjwoGADcfRFUO7c4seLfCO9s/BIPwjLDf1dbbqSwRoHI8
         tJVRJycL2baSc4ntU23k/UVDwtMBvZt/OAz73MfX3z+Oqe7Z80lJODCuZZ+mum+6sH/C
         RWoFtdl54Pw6rZmAOvdVwscG9UBHja3KlARDPDhXwtfCVxT4k4Na3SBlOi85I8K1/49D
         tpc8wn24FPKE2Siyf1kAkChVQBSQId47/HItV3YG2qoBp50mnlX8khdN0kZJY2Ig/60T
         ADnfOQTzBILzIlUvfl/ML6xFUpk6OBwnhc/3QzDlYhDmdlYXCrCwDpoV+DITOWwphIj3
         ZBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697301681; x=1697906481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SUzK13Qn1PfXC3u9zSb3SW6KyC5d2HbISCOTAbAuk8=;
        b=CRslNib6FH8UKlALYkXlrrXfxfHo/9+HpMm5nwvvPf9fiiQS9+RzOxatu5RIC+DQ8d
         I5LPYX5yFrlJfhzwVLigeQmMjYJOSMyw+hYe/odcIZFJmRE6AlvzdPDOqrAa33UdeYhL
         qprc381zWrrI7mVNvXSudss4o+D+iIZve3BQDfsWj4YLJBgNuK+8ckNYbJ6XZj8p2eRb
         jQuJvBCQpyeCrKpijesozTH77Pj1fBwDVU6sMbyuDHSDMlwtB0u/WTWdGbJjH+xMhRWh
         7V52gMYFdGM+HpJPO2JNRLHPFnLkSw7tDVL/2wAverZzqsnjDYPPa/tPNYl1DrLyfquo
         FZng==
X-Gm-Message-State: AOJu0Yxw189EEluWzDEEnt5Ecp7LTeGDXcFeXdO+R4tJGmq/oYfdg9Km
	eUqe2FuS/alMslGIEnGNCrV0nQMFwJTHlUgEK7c=
X-Google-Smtp-Source: AGHT+IE/uB3CJuNrOd0gSz7jXmyE+tozGNFsvDN6YRDjiX5B/F7+Y7FwXJJUN6aIv/S+MX1z7u/Pufdah7hxWvu5VJ8=
X-Received: by 2002:a05:6402:3552:b0:53e:1375:33ce with SMTP id
 f18-20020a056402355200b0053e137533cemr6988952edd.30.1697301681067; Sat, 14
 Oct 2023 09:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <355182457.15373219.1697222676128.ref@mail.yahoo.com> <355182457.15373219.1697222676128@mail.yahoo.com>
In-Reply-To: <355182457.15373219.1697222676128@mail.yahoo.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 14 Oct 2023 18:41:07 +0200
Message-ID: <CAP8UFD0d9epQCqE6w+kVgBQ99Xw3RaWNYJAHNQUqLXcFsxVtPQ@mail.gmail.com>
Subject: Re: [Outreachy Applicant]
To: "estherugbiedah@gmail.com" <estherugbiedah@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Fri, Oct 13, 2023 at 8:44=E2=80=AFPM estherugbiedah@gmail.com
<estherugbiedah@gmail.com> wrote:
>
> Hello Git Community,
>
>  I am an Outreachy applicant for the 2023 cohort and I am thrilled to con=
tribute to the Git project.

Thanks for your interest in Git and welcome to the Git community!

> Having reviewed the available projects, I am particularly interested in t=
his project. I believe that contributing to this project will not only enha=
nce my skills but also allow me to make a meaningful impact.
>
> I am ready and excited to immerse myself in the project and make valuable=
 contributions.

Great, please take a look at the documentation we have on
https://git.github.io/, especially the pages and sections I mention
below.

First, we require that applicants make a small code contribution (we
call that a micro-project) to the Git project. This is explained here:

https://git.github.io/General-Microproject-Information/

and there is information about how to find micro-project ideas.

Now we have recently added a "Thoroughly check your eligibility in the
program" sub-section to that page. Please read it, check your
eligibility and confirm that you meet all the requirements soon.

Then there are links to tutorials and a number of other useful link
for Git developers on this page:

https://git.github.io/Hacking-Git/

Also the following page is useful as it contains more general
information about how to apply:

https://git.github.io/General-Application-Information/

Best,
Christian.
