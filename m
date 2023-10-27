Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D54374F8
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezPVnCEP"
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC89DAC
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 08:41:25 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-66d03491a1eso15092636d6.2
        for <git@vger.kernel.org>; Fri, 27 Oct 2023 08:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698421285; x=1699026085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2CT9Nvl+IECBRBBgL+TCoW4Asql923ybD2nQsc/iZI=;
        b=ezPVnCEPuU9BgWpVA1C6ajIflPTq6E8urzObIQanQwx0FiDpIaiS6hWf5ycVXaf9I7
         x4auJixSnbzz+tT9HJ69YG3eA+VQLClwsKPozA4qX8ucLUFUIu7xVLeiqRFn0MIVFSGq
         fIVHJnrrH9eiWPT5l1uv85DigR7JIslPmGtxBp8VDjtmHbnO+Xt6jDHN0Abl3WXcyuce
         nbJyBSU49GmyScWW5Q6PiJ+x1Oak3VBL4U2vm33kYweeoszC5v2Kq03JyCATW92jykAq
         5RP8EhLS3W+c+iISVs4aeAs5+jDVZP1BEbP6Q82lG6kMb8P4BQyAwl9nkRWMpPCbMS0v
         8jKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698421285; x=1699026085;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2CT9Nvl+IECBRBBgL+TCoW4Asql923ybD2nQsc/iZI=;
        b=fwcQHqBPGercpR0ireMA4wEd9QrbRSYRpbB3T77nxbAe+PaqwLrxxEW16No8TlSe3h
         BLxLO3bLC+tcAssMJIrS5cZRzIHq6ilyCcwhcIXNkBnHt2Dq5rBAt7cFqUY4oswAwn3K
         P7HbfUN6gCBKq8IKz94oUy4/KV/nHC8r43KSSX6t4KhKEwpeHujMEommGSy9XgErUPTo
         IYDc/o+vGZMQkRSV2q5w+QNyDrBLAoyBCjiqOr6BBSpIahYrSxYv3+FWEU9mf1Wm13RA
         sIkQ7qUoCdBmcgbLfQ7W1S8uJM8KLbWwEVa4LLPvjQasOSH3+7kkKD0sFHbEVnMLbC4P
         hNkQ==
X-Gm-Message-State: AOJu0YyXIukTl/3YjSCsmQ/i2pWLMLvl6tZS4DT2evKU9J5sNp8u5gx5
	HzVNCuAaZvZ7i6y0DOILW0qzxdOKuqE=
X-Google-Smtp-Source: AGHT+IGLXf9XNS3HJ0dv1lM3RHGR0gQFWdl9VByw/9K2TbGeVVDsMkcP1774len4g1wRQbC4aWVhyg==
X-Received: by 2002:ad4:5967:0:b0:66d:6406:1301 with SMTP id eq7-20020ad45967000000b0066d64061301mr3503512qvb.20.1698421284568;
        Fri, 27 Oct 2023 08:41:24 -0700 (PDT)
Received: from ?IPv6:2606:6d00:11:3bb7:88c4:23f7:df08:ae30? ([2606:6d00:11:3bb7:88c4:23f7:df08:ae30])
        by smtp.gmail.com with ESMTPSA id do10-20020a05622a478a00b004181b41e793sm673862qtb.50.2023.10.27.08.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 08:41:24 -0700 (PDT)
Subject: Re: Constant recompilation when GENERATE_COMPILATION_DATABASE is set
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <ZTui2NcJ3Ax_PIGO@tapette.crustytoothpaste.net>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <76c5f401-0b29-b19a-8424-5bca5df2252e@gmail.com>
Date: Fri, 27 Oct 2023 11:41:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZTui2NcJ3Ax_PIGO@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi brian,

Le 2023-10-27 à 07:45, brian m. carlson a écrit :
> I typically use clangd with Git for the nice language server protocol
> (LSP) support.  I noticed that when GENERATE_COMPILATION_DATABASE is set
> (which is used so clangd can find the proper flags), `make` rebuilds all
> of the files every time, even if I do it back to back.  This persists
> even after a `git clean -dxf`.
> 
> Obviously, this is not great, since it means the turnaround time to
> compile changes is slower.  Unfortunately, I'm not a huge expert in make
> and I'm unsure what the right solution is here.  I'd appreciate anyone's
> thoughts on how to improve this.
> 
> This is on a Debian sid (unstable) amd64 system with the following
> configuration.  The version of clang in use is Debian's 16.0.6.
> 
> ----
> NO_OPENSSL=1
> DC_SHA1=1
> NETTLE_SHA256=1
> DEVELOPER=1
> NO_SVN_TESTS=1
> NO_PYTHON=1
> USE_ASCIIDOCTOR=1
> USE_ASCIIDOCTOR_MANPAGE=1
> CC=clang
> GENERATE_COMPILATION_DATABASE=yes
> CSPRNG_METHOD=getrandom getentropy
> ----
> 

Indeed, with GENERATE_COMPILATION_DATABASE=yes and CC=clang I can reproduce with:

make clean
make -j
make -j # this rebuilds everything
make -j # this does not rebuild anything

so the second 'make' invocation is buggy, but not subsequent ones.

I took a look at the 'make -d' output and we can see it is the dependency on 
the 'compile_commands' directory that is the culprit, on the second invocation
it is newer than the the first object file that makes checks.

This makes sense since each time we compile an object we put the JSON fragment in 
compile_commands, so the directory is updated each time an object is built, so
clearly its modification date will be newer than the one of the first object built.

One way to fix this is to use the same trick that is used for the '.depend' directories
created to hold the Makefile dependencies: 

diff --git a/Makefile b/Makefile
index 5776309365..f6f7255dd1 100644
--- a/Makefile
+++ b/Makefile
@@ -2701,7 +2701,7 @@ endif
 compdb_dir = compile_commands
 
 ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
-missing_compdb_dir = $(compdb_dir)
+missing_compdb_dir = $(filter-out $(wildcard $(compdb_dir)), $(compdb_dir))
 $(missing_compdb_dir):
 	@mkdir -p $@
 
That is, we define missing_compdb_dir to 'compile_commands' only if the directory
is not yet created.

I'll try to send a proper patch for this.

Thanks for the report,

Philippe.
