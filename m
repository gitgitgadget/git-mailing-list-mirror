Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA5A6FAA
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZTjW+Pw9"
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC50A2
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 10:47:23 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc131e52f1so10138145ad.0
        for <git@vger.kernel.org>; Wed, 01 Nov 2023 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698860843; x=1699465643; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jcu3MHawR4js75+DYHn49TAcuQfGrr0R4qBZem9EdZM=;
        b=ZTjW+Pw9j0lgJFJ9gdjcsd7wxFKGcv5YD072I7avSpXydpWRq3BrakRh2+oEMD0wWp
         ee2eUEWpS3AP4ypjfJ2/GQ84dty3gJkFFlbjjD7bqQH5hlsFJua3peZ3VWxmEyjIDuOn
         zLNMHvXSK5vSHIVDjiGSKYgtU+BT5kl3c2HkchMpB0siuqAFP0o/0SaxnjOFnaQiUMiu
         oIr3FcL37DHok62kJKtcAniZl/LjOEC43EnWXQQjXtgP/4RgMgWyMBTBwKsul/SdMSep
         JqnFKb82w/HD3l8IuEhOcqCmr8G5QtHW30wIv6k8iLBeU2b2EBne89jW6jjQSUq10HTw
         M21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698860843; x=1699465643;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jcu3MHawR4js75+DYHn49TAcuQfGrr0R4qBZem9EdZM=;
        b=ty7KQjs7nKxIh8rsZ9UAe5fkh25c595F2Owhd6zFPaqLPwLiR2bverVElk4Svf7NGO
         ZGoygJEz4vhX6XdfUET09ryhSUcvgQPTAejmdaD+h0DY2vAGow+hffZ8PE64Igvl/K7x
         F7FZiyip0bP1XJF/iku5ymhnVE9VWcc9UonFW0MyFePQaCl8qMI3wBkYvGEtl4EWV2JM
         vU8tvwv/pOy1e+H71aywhdjbPnS729AEsOdjKnO8X9oK5DlsE1DGl3Uk3Jkr8KuhnRwD
         z7UXxmkjK/y/4Ev71Az3esWOchp2By14keeJn0sjSNkL2W7/oburQ3axzwc3MmBvuPuP
         PTEw==
X-Gm-Message-State: AOJu0Yw2vQQdD0c3go+VMIu8Rs7P99q7NUWfrik4D8q6DIGOo6ncGbOb
	jxHJJB5WhFitm3AUK32kFOIIBg==
X-Google-Smtp-Source: AGHT+IFCq6dOV8MA+fQolwc5b+PnrzWpfw0uJcjd8NKvhMtIniaqS9/bU7ClIpTMjkj5ml7U/wst3A==
X-Received: by 2002:a17:902:f816:b0:1c0:afda:7707 with SMTP id ix22-20020a170902f81600b001c0afda7707mr6254076plb.34.1698860843155;
        Wed, 01 Nov 2023 10:47:23 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:22ea:81ca:f3ec:8bce])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f7c500b001bdeb6bdfbasm1605205plw.241.2023.11.01.10.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 10:47:22 -0700 (PDT)
Date: Wed, 1 Nov 2023 10:47:18 -0700
From: Josh Steadmon <steadmon@google.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, linusa@google.com,
	calvinwan@google.com, gitster@pobox.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v8 1/3] unit tests: Add a project plan document
Message-ID: <ZUKPJsW1mT62Mcjy@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	phillip.wood123@gmail.com, linusa@google.com, calvinwan@google.com,
	gitster@pobox.com, rsbecker@nexbridge.com
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1696889529.git.steadmon@google.com>
 <81c5148a1267b8f9ce432a950340f0fa16b4d773.1696889530.git.steadmon@google.com>
 <CAP8UFD26X4MPbJs4KfNOgicLMb-wiuFZj3Hw17acMmmc_=vcqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD26X4MPbJs4KfNOgicLMb-wiuFZj3Hw17acMmmc_=vcqQ@mail.gmail.com>

On 2023.10.27 22:12, Christian Couder wrote:
> On Tue, Oct 10, 2023 at 12:22 AM Josh Steadmon <steadmon@google.com> wrote:
> >
> > In our current testing environment, we spend a significant amount of
> > effort crafting end-to-end tests for error conditions that could easily
> > be captured by unit tests (or we simply forgo some hard-to-setup and
> > rare error conditions). Describe what we hope to accomplish by
> > implementing unit tests, and explain some open questions and milestones.
> > Discuss desired features for test frameworks/harnesses, and provide a
> > preliminary comparison of several different frameworks.
> 
> Nit: Not sure why the test framework comparison is "preliminary" as we
> have actually selected a unit test framework and are adding it in the
> next patch of the series. I understand that this was perhaps written
> before the choice was made, but maybe we might want to update that
> now.

Fixed in v9, thanks.


> > diff --git a/Documentation/technical/unit-tests.txt b/Documentation/technical/unit-tests.txt
> > new file mode 100644
> > index 0000000000..b7a89cc838
> > --- /dev/null
> > +++ b/Documentation/technical/unit-tests.txt
> > @@ -0,0 +1,220 @@
> > += Unit Testing
> > +
> > +In our current testing environment, we spend a significant amount of effort
> > +crafting end-to-end tests for error conditions that could easily be captured by
> > +unit tests (or we simply forgo some hard-to-setup and rare error conditions).
> > +Unit tests additionally provide stability to the codebase and can simplify
> > +debugging through isolation. Writing unit tests in pure C, rather than with our
> > +current shell/test-tool helper setup, simplifies test setup, simplifies passing
> > +data around (no shell-isms required), and reduces testing runtime by not
> > +spawning a separate process for every test invocation.
> > +
> > +We believe that a large body of unit tests, living alongside the existing test
> > +suite, will improve code quality for the Git project.
> 
> I agree with that.
> 
> > +== Choosing a framework
> > +
> > +We believe the best option is to implement a custom TAP framework for the Git
> > +project. We use a version of the framework originally proposed in
> > +https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com/[1].
> 
> Nit: Logically I would think that our opinion should come after the
> comparison and be backed by it.

I intended this to be a quick summary for those who don't want to read
the whole doc. I clarified that and added a link to the selection
rationale.


> > +== Choosing a test harness
> > +
> > +During upstream discussion, it was occasionally noted that `prove` provides many
> > +convenient features, such as scheduling slower tests first, or re-running
> > +previously failed tests.
> > +
> > +While we already support the use of `prove` as a test harness for the shell
> > +tests, it is not strictly required. The t/Makefile allows running shell tests
> > +directly (though with interleaved output if parallelism is enabled). Git
> > +developers who wish to use `prove` as a more advanced harness can do so by
> > +setting DEFAULT_TEST_TARGET=prove in their config.mak.
> > +
> > +We will follow a similar approach for unit tests: by default the test
> > +executables will be run directly from the t/Makefile, but `prove` can be
> > +configured with DEFAULT_UNIT_TEST_TARGET=prove.
> 
> Nice that it can be used.
> 
> The rest of the file looks good.

Thanks for the review!
