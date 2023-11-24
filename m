Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfsGR5Np"
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5141FC8
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 10:28:07 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-332e42469f0so1154568f8f.1
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 10:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700850485; x=1701455285; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=96hHvRPJopVDvCVA0QpQWn4+QD/w6sYfMK0CogYHHXw=;
        b=IfsGR5NpuNbOGPOZzEPleAJGoKtAs9hdTKIO+3zdvoIIpYhccND8d9xcK0UDK8hGNo
         ou3z4fGoT7GRZ7pF9AWCEzCR0IVLriZkCaF1ebGfyCyfYWM5PzbXHLTNYzX7FnlRlh7I
         yNt9F4qcUFlGNxdiI9802GKl7p5LYIac0/MsUXjYLrvixIJMAamRGcTBtCEGf9vilwrH
         9bgTq4tdMwol0vuUSixn3I40JSwqISTLJwB9dcllHHDb8+gkC1rO+5SBPB+l+wBv2rPk
         aGx0+shume23ogRRO4tzaE1TOUekc3vl3AS6l/ym4dcuBUxWrlvlDpJ9lnDmOLxdx9Oo
         C2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700850485; x=1701455285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96hHvRPJopVDvCVA0QpQWn4+QD/w6sYfMK0CogYHHXw=;
        b=PpbViYm6gwasd+nokR6f5FKlM+PBTEo1hqVPA8K1PO+n0o6YVVsxXw6WHEe6sZjNEy
         9vEEEmbsidjVv9X6YbKcIxdfywWMcH3u/aebjegWa88/ckCCUNsSUPyQMYig3EU7dNj+
         4HWtfqCiXq68TuiGs2jb2iPvFNAGs8q+SFb2VYN7ZqaecjL1y7vNp1PwOb6VoJO/nJ8W
         Com3Hrt5zbNWhSDo6RcUvsQ308dAQqnx3DlqaP9+P2rV/ye4t6Wn8aEBRqVD5EG2SZ5j
         ol0rcFtoregUva9OMXZdZLRwr5WSOPv7YSF3DxC6xIFbfX0iVuYaAezMnM4cjscMAxJZ
         traA==
X-Gm-Message-State: AOJu0YwQhAuQLmuW9ecnyz6ZJAcVkkbcDFZi5INBfLudzDewLoUqS5bQ
	zKVA+rcBk+t3PIDFqxTgiBnQCOH0p3w=
X-Google-Smtp-Source: AGHT+IEvqEhZairtJ0JRqIhcJQ0sRvB4sIO/uQ9x//gqZ7+480k5jA4eL9yC98R14M5EK0MUxsJwZw==
X-Received: by 2002:adf:b1d2:0:b0:332:d288:30de with SMTP id r18-20020adfb1d2000000b00332d28830demr2338779wra.6.1700850485238;
        Fri, 24 Nov 2023 10:28:05 -0800 (PST)
Received: from localhost (62-165-236-105.pool.digikabel.hu. [62.165.236.105])
        by smtp.gmail.com with ESMTPSA id bg11-20020a05600c3c8b00b0040b2c195523sm6536948wmb.31.2023.11.24.10.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 10:28:04 -0800 (PST)
Date: Fri, 24 Nov 2023 19:28:03 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] git-prompt: stop manually parsing HEAD
Message-ID: <20231124182803.GA11157@szeder.dev>
References: <cc902954f30c2faa92d1c5a4469f0dcc23e4acfe.1700825779.git.ps@pks.im>
 <CAPig+cSa9zxEhKXtXHrVuB3Eb6=vnD1Ppnfj59rA+nPEO-9j-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSa9zxEhKXtXHrVuB3Eb6=vnD1Ppnfj59rA+nPEO-9j-w@mail.gmail.com>

On Fri, Nov 24, 2023 at 01:09:03PM -0500, Eric Sunshine wrote:
> On Fri, Nov 24, 2023 at 6:37 AM Patrick Steinhardt <ps@pks.im> wrote:
> > We're manually parsing the HEAD reference in git-prompt to figure out
> > whether it is a symbolic or direct reference. This makes it intimately
> > tied to the on-disk format we use to store references and will stop
> > working once we gain additional reference backends in the Git project.
> >
> > Refactor the code to always use git-symbolic-ref(1) to read HEAD, which
> > is both simpler and compatible with alternate reference backends.
> 
> This may get some push-back from Windows folks due to high
> process-creation cost on that platform. As I recall, over the years, a
> good deal of effort has been put into reducing the number of programs
> run each time the prompt is displayed, precisely because invoking Git
> (or other programs) multiple times became unbearably slow. In
> particular, optimizations efforts have focussed on computing as much
> as possible within the shell itself rather than invoking external
> programs for the same purpose. Thus, this seems to be taking a step
> backwards in that regard for the common or status quo case.
> 
> Would it be possible instead to, within shell, detect if the historic
> file-based backend is being used in the current repository, thus
> continue using the existing shell code for that case, and only employ
> git-symbolic-ref if some other backend is in use?

Thanks for sharing my worries :)

I sent a patch a while ago to Han-Wen to make our Bash prompt script
work with the reftable backend without incurring the overhead of extra
subshells or processes when using the files based refs backend.  He
picked it up and used to include it in rerolls of the reftable patch
series; the last version of that patch is I believe at:

  https://public-inbox.org/git/patch-v4-21.28-443bdebfb5d-20210823T120208Z-avarab@gmail.com/

