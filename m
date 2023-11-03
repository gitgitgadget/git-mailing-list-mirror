Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FF71F92C
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSEYYhmJ"
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898A4D44
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 10:20:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc7077d34aso19160805ad.2
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 10:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699032016; x=1699636816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iMU0uRcKSDZAfEAk/g6KnYqOuX3Zwo/GLSiAgKdCGA8=;
        b=HSEYYhmJ0Z66d82Du2UwINTSD1/XN2MfE9YEIm76l1OYU4tTiqEPDCku7Bp9CSYIVy
         oXLr1OcmR9shVcnqxq12tzWcydQGM1m8fJp9M0v2bDkGTutwwj4w/4thCz/H0e7VjSjn
         PU5dPtdNCkkh8H41ECvCmC4lp6Q9oMLCqoXJnY3P4inUSiGa4EqUn74B+JvcKKWXlpRT
         aO4wxvzcuuKM7EZE9Y0hhRYEuEN/kdituaHfIlBnq/MK3MjUx9iXd3itCuNoJqiZZDlq
         IdDuoHJ0r0grAQMgLPux12Ug4EBLWkZyXBFDGmNNfkUdQJvBJAOU8CUxmXp9HL8/+t0T
         I7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699032016; x=1699636816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMU0uRcKSDZAfEAk/g6KnYqOuX3Zwo/GLSiAgKdCGA8=;
        b=SWD+aM3XBqxU46Ousx6lLIEBvnov9QXZxMfgilx+D4dbvM6e0MPDbkn71OaJZA5qm2
         ui6hOvL7lCBJ0o3kkTMKeKipXDmug6Yq33bxjOFc8m58fUQjD0ogXZAIXxZ6Fzk1vCuy
         xTfk6mLDA0DJs/ks2IUnz1DjceJVHON8LbvedF76HPeIJhixoXmkTqFWzKjBtiOPtXc1
         yJ11naWs5KA3Vmhia2ZPR32vRXAc0bngL32eT36MUPnifgcN8GS2ahKUsAQP73Q9/M02
         E7vOxuTigwo4zpwTQ8sqxyX7kB1SprEw3LgJzLCX+8VYpW9WZHhBE1v+A1/8EY/SljVz
         6SVg==
X-Gm-Message-State: AOJu0Yy9JtCAcQZF9wwxkSZ4zCyTvNBZ1UBzbrg332RF84FTyWbuYcXH
	0ZZQ8G9n2lMgeWXyNuHKXZpep5jPCEcrqg==
X-Google-Smtp-Source: AGHT+IFo++/f98JUQK7TFm8KhdhmgusAQZG74umJSBuQmBz/llmi5xLdgBlBY0PvHX69yIIX6qZgKw==
X-Received: by 2002:a17:903:7ce:b0:1cc:3ac5:57dd with SMTP id ko14-20020a17090307ce00b001cc3ac557ddmr13671352plb.9.1699032015721;
        Fri, 03 Nov 2023 10:20:15 -0700 (PDT)
Received: from five231003 ([2405:201:c006:31fd:a238:c639:fbf6:9b1])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001bf5e24b2a8sm1627411plh.174.2023.11.03.10.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 10:20:15 -0700 (PDT)
Date: Fri, 3 Nov 2023 22:50:12 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: Liam Beguin <liambeguin@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email
 addresses
Message-ID: <ZUUrzIRe7j_Mu_J6@five231003>
References: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
 <20231027184357.21049-1-five231003@gmail.com>
 <4e3a5661-cba0-4849-8340-06d8d4094f48@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e3a5661-cba0-4849-8340-06d8d4094f48@gmail.com>

On Fri, Nov 03, 2023 at 08:22:05AM +0000, Andy Koppe wrote:
> 
> On 27/10/2023 19:40, Kousik Sanagavarapu wrote:
> > So, if we have a domain-name, we grab it, else (the case where we don't
> > have '@') we grab it as-is. Looks good.
> 
> I'm not sure that this is the right way to handle a missing '@' here
> actually, because %al already returns the whole email field in that case,
> which makes sense as the likes of the 'mail' command would interpret it as a
> local username.
>
> And if someone was going to use %al and the new specifier together to format
> the parts of the email field differently, they probably wouldn't want the
> field to appear twice.
> 
> Therefore I think it would be more appropriate to expand to nothing in that
> case. Tools that consume this output would already need to be able to deal
> with the empty case, as it could also happen if there's a single '@' at the
> end of the email field, or if the field is empty.

I originally thought since localpart and the new domainpart are like
counterparts (or are symmetrical, like Peff mentioned), falling back
like in the case of localpart was the correct way here (again, symmetry).

Having read your reasoning though I think it makes sense to not fall back the
same way as localpart (%al) and return empty instead.

This goes in favor of what Liam said in the original commit message of this
feature being used to keep track of commits from different organizations (as
in from GitHub or GitLab) or at least domains that make sense. As, if we
return the whole email (where the email is with no domain-part or '@' is at
the end of the email), the whole purpose of our new feature is lost.

Thanks
