Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127D14295
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DsKRsGsG"
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5670FE4
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 10:31:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b5e6301a19so108224b3a.0
        for <git@vger.kernel.org>; Wed, 01 Nov 2023 10:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698859914; x=1699464714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0OQV5cTqxwwoPtt2MUnHN7n3WF7HN4YWw3UaU/4FoM=;
        b=DsKRsGsGhhalCoVdzQrwEKqG0rTEdCSK2nxVunpn0K8vE+mwdLI11FHryB+yDKAa1i
         6Eq3gB4eTy4bNb8NeKMyhDDaCv08XnTVAtRAr9kOTKR900Y5NEf6/TuBUOqgcEHUcA1B
         6Xh8m+WjAuG2KU745UNZdceL5LtYT/CBL76qy1zg5vcPQvleFzkM/+8OdL6AiqErgVTr
         jIWqyPIanPXaai9KqB6nmMq9cBXp1x4OQWde7mM04Cue82yMeaq0/KfijGaP7h4SrlVr
         C8bEJAn5TUTb+R73N7GiUgtmOILikcUJPSpLoQky6Mc3gYg3bj9v0ZmVZG9WkGBCRqCq
         +/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698859914; x=1699464714;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0OQV5cTqxwwoPtt2MUnHN7n3WF7HN4YWw3UaU/4FoM=;
        b=EJhNQfsOGvMbdiVACYrPBwXpiMPn3okrlCVf+e+4OIqLEIQD4QQtKyKjLbxpmyI0b9
         gYLkuxZw1TMnmgPcNq3K5AxxmLemgMe6tB1rG1APb+Ge4S/oYBHwohGe3u1rqwJL7+vC
         vbVZhS9BxPSLl2u74cu24HuGBPiUDzrdyKakmOBY4aoOBAvvV1Uivq4VgluTT/P/B3gq
         Rc2CbcIkJSsqixtps27v2SthBbkH/hzWOT9IZ0C74vPFdHTb4/f795GVjAPbRLNPLxtn
         oVI4qQFmt48Zis1r/Ri9SRqEoid9HwQsl5KncXxQmcqUdfGbngwIFS8VkApBdpZtis72
         KD9w==
X-Gm-Message-State: AOJu0YxCwiW58KcXn+2ckx2JZ9NfQoVu0IF4t1eS7aR1EzjwcyHN2X7r
	ZVgCe8euukDyTZ3sgWAvoNtWJA==
X-Google-Smtp-Source: AGHT+IFZss0TQMVMMTAIw2vxgs+EQ5kOCAfy7CRSs4P64yXV5r0zHuSMDnBgEdDOVbqDp5j2PQm8vw==
X-Received: by 2002:a05:6a00:93a3:b0:68f:d1a7:1a3a with SMTP id ka35-20020a056a0093a300b0068fd1a71a3amr19175768pfb.8.1698859913393;
        Wed, 01 Nov 2023 10:31:53 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:22ea:81ca:f3ec:8bce])
        by smtp.gmail.com with ESMTPSA id fj16-20020a056a003a1000b006889511ab14sm1515725pfb.37.2023.11.01.10.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 10:31:52 -0700 (PDT)
Date: Wed, 1 Nov 2023 10:31:48 -0700
From: Josh Steadmon <steadmon@google.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, linusa@google.com,
	calvinwan@google.com, gitster@pobox.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v8 1/3] unit tests: Add a project plan document
Message-ID: <ZUKLhInUh19g11Dl@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org,
	phillip.wood123@gmail.com, linusa@google.com, calvinwan@google.com,
	gitster@pobox.com, rsbecker@nexbridge.com
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1696889529.git.steadmon@google.com>
 <81c5148a1267b8f9ce432a950340f0fa16b4d773.1696889530.git.steadmon@google.com>
 <ZSUR+YdzqNTSB0XC@ugly>
 <ZScQG5QHznMEGzhC@google.com>
 <ZScqLzGiDPZvLh2k@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZScqLzGiDPZvLh2k@ugly>

On 2023.10.12 01:05, Oswald Buddenhagen wrote:
> On Wed, Oct 11, 2023 at 02:14:03PM -0700, Josh Steadmon wrote:
> > On 2023.10.10 10:57, Oswald Buddenhagen wrote:
> > > On Mon, Oct 09, 2023 at 03:21:20PM -0700, Josh Steadmon wrote:
> > > > +=== Comparison
> > > > +
> > > > +[format="csv",options="header",width="33%"]
> > > > +|=====
> > > > +Framework,"<<license,License>>","<<vendorable-or-ubiquitous,Vendorable or ubiquitous>>","<<maintainable-extensible,Maintainable / extensible>>","<<major-platform-support,Major platform support>>","<<tap-support,TAP support>>","<<diagnostic-output,Diagnostic output>>","<<runtime--skippable-tests,Runtime- skippable tests>>","<<parallel-execution,Parallel execution>>","<<mock-support,Mock support>>","<<signal-error-handling,Signal & error handling>>","<<project-kloc,Project KLOC>>","<<adoption,Adoption>>"
> > > > the redundancy seems unnecessary; asciidoc should automatically
> > > use each
> > > target's section title as the xreflabel.
> > 
> > Hmm, this doesn't seem to work for me. It only renders as
> > "[anchor-label]".
> > 
> i thought
> https://docs.asciidoctor.org/asciidoc/latest/attributes/id/#customize-automatic-xreftext
> is pretty clear about it, though. maybe the actual tooling uses an older
> version of the spec? or is buggy? or the placement of the titles is
> incorrect? or this applies to different links or targets only? or am i
> misreading something? or ...?
> 
> regards

I think the issue may be that asciidoc is the default formatter in
Documentation/Makefile, not asciidoctor.
