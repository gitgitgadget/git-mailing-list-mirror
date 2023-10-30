Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19E018AE9
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIds6rTD"
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B55AE4
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 16:30:34 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b3c2607d9bso4488251b3a.1
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 16:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698708633; x=1699313433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rE4uzsKgtKJWFXZBUTEa9fdvumSaV/lA7+K8T6aMHFw=;
        b=IIds6rTDR+8d68FSa4L4vdRix2SNwRRNA6YLUHdgntXDlZF+jYD4VaHQYRBCm9iuMG
         B3HNcp+y2VM+3lTR/y8gxwzvlaxA7rJKhf5grI9+EGZWhffSW1NC9aFF6IC++isVwaqi
         OXsRwTXGPk0Ea8TFNcZcoi3tCUtU5O42Xu2G4B/a3TvR9T/tFaDJFt/TygzXTF4M6bqp
         wYlI6rFvbsaOKxD1k4ulp8hnWWvXpyxs9TajJyHBYF/Xd5w26b24REY5DVJnYWJkldQi
         RxoyBdHcUJ9UldNn556dXeU++FviJNPKdrVskeC4ChCDVDQdl/kE+zza/m9FkxCdrAcf
         A0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698708633; x=1699313433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rE4uzsKgtKJWFXZBUTEa9fdvumSaV/lA7+K8T6aMHFw=;
        b=nOp/QOJxrR0oHbXFptKZ1ZgqXTeF+0V326Ffa7Xq3L+qsIeQtdLhmoqopM88M0HiMh
         Jeqe+53LNeQjJ1Vpz7u2mXmFSdSEoD6W3TjMskX+CfByKAkKjtAo6n+aMpZZ65vy5he3
         hsCUaCPexL89h64MiTd9cPgnzvSoyN7Pxblvk3WGPXdjIuRt7oIulZsVOjDeQk7pq0Gq
         ZL8GewrKU04WYV4eMO61Sv5ttJ9qmFtAnsIHzsmG2Fn9uVqHfQApttmRecVnoaX+MgsW
         UvSKwLvgLEhtTVvE0X990lyL/iQWgFu2bCUhMmxMMHd6t834DEoE4hnRgwJTP6t2+N97
         AUhQ==
X-Gm-Message-State: AOJu0YxWh0pxlqVAHDX0b4v49JbEkHmxQmhlpBCfhIqWgHPbrZf0gGpK
	GpaWWYLkGJuSNX5kCz2u0G/aYyvn1Z/bIA==
X-Google-Smtp-Source: AGHT+IGMPUZNoCOOaHXr9d89sVfP4eGYYqjZ23JLtRKC+iiNaPVVgx3XozeOZk1lM9r7cGcyX9BaDg==
X-Received: by 2002:a05:6a00:1387:b0:6bc:62d0:fffd with SMTP id t7-20020a056a00138700b006bc62d0fffdmr10454119pfg.15.1698708633431;
        Mon, 30 Oct 2023 16:30:33 -0700 (PDT)
Received: from ?IPV6:2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9? ([2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7960d000000b0068fe7c4148fsm63901pfg.57.2023.10.30.16.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 16:30:32 -0700 (PDT)
Message-ID: <9cec7307-a875-4b8c-9abe-81c8879d698b@gmail.com>
Date: Tue, 31 Oct 2023 10:30:29 +1100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Repository cloned using SSH does not respect bare repository
 initial branch
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <63eb269e-72b9-4830-98fc-aeef8b8180d7@gmail.com>
 <20231030093605.GE84866@coredump.intra.peff.net>
 <b310e254-f6d3-4715-b042-341bf5a98bbc@gmail.com>
 <20231030174307.GA854621@coredump.intra.peff.net>
From: Sheik <sahibzone@gmail.com>
In-Reply-To: <20231030174307.GA854621@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/10/23 04:43, Jeff King wrote:

> On Tue, Oct 31, 2023 at 02:24:46AM +1100, Sheik wrote:
>
>> Server version is same as client (v2.42.0) as I ran these commands all on
>> the same machine.
> OK. The next thing I'd check is running both commands with:
>
>    GIT_TRACE_PACKET=1 git clone ...
>
> to see the protocol trace, and how it differs between the two. What I
> suspect you may see is that the local clone is using the "v2" protocol
> (a capabilities report, followed by "ls-refs", which mentions the symref
> value of HEAD), and the ssh one uses the older "v0" (it goes straight to
> the ref advertisement).
>
> Quoting from 59e1205d16 (ls-refs: report unborn targets of symrefs,
> 2021-02-05), the commit I mentioned before:
>
>      This change is only for protocol v2. A similar change for protocol
>      v0 would require independent protocol design (there being no
>      analogous position to signal support for "unborn") and client-side
>      plumbing of the data required, so the scope of this patch set is
>      limited to protocol v2.
>
> So in v0 the server doesn't pass back sufficient information for the
> client to know about the name of the unborn HEAD branch.
>
> If that's the culprit, the next question of course is why we'd do v2
> locally versus v0 overssh. And that probably has to do with how we
> trigger the protocol upgrade. To see if the server supports v2, the
> client passes extra information "out of band". For git-over-http, this
> happens in an extra HTTP header. For local repositories, it happens in
> an environment variable ($GIT_PROTOCOL). For git-over-ssh it happens in
> that sameenvironment variable, which we instruct the ssh client to pass
> using "-o SendEnv". But:
>
>    1. If your ssh client doesn't look like openssh, we don't know if it
>       supports "-o" and may skip it. See the discussion in ssh.variant in
>       "git help config".
>
>    2. Some servers need to be configured to allow the client to set
>       environment variables. In the case of openssh, you'd want a line
>       like this in your sshd_config file:
>
>         AcceptEnv GIT_PROTOCOL
>
> Of the two, I'd guess that the second one is more likely to be your
> problem (since you're running Linux, where openssh is the norm).
>
> -Peff


Thanks Jeff, tracing and setting the AcceptEnv indeed did the trick and 
workflow now works as expected.

Test steps on Debian/OpenSsh:

Server
1. Edit /etc/ssh/sshd_config
2. Add AcceptEnv GIT_PROTOCOL
3. systemctl restart sshd

Client
1. Enable ssh logging:
    export GIT_SSH_COMMAND=ssh -v
2. git clone ...
3. Output from ssh shows variable being sent (although regardless if 
AcceptEnv was set or not):
    debug1: channel 0: setting env GIT_PROTOCOL = "version=2"
    debug2: channel 0: request env confirm 0

References
1. 
https://git-scm.com/docs/git/2.42.0#Documentation/git.txt-codeGITPROTOCOLcode 

2. https://git-scm.com/docs/gitprotocol-v2#_ssh_and_file_transport
3. 
https://git-scm.com/docs/git/2.42.0#Documentation/git.txt-codeGITSSHCOMMANDcode 


Thanks
Sheik

