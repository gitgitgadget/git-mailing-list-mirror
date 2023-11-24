Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxNgCP2i"
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CD31BDA
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 10:39:42 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-332c7d4a6a7so1452148f8f.2
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 10:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700851180; x=1701455980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sko5wbhJl4GoYA+N107vBSXel0j9gH2nHoYpOfIqlM4=;
        b=gxNgCP2iljfhi4IzyPR8jlcH/egDJGq64pRx4l227Oryb/eq4kAphemzwDRdq/rPNG
         O3jMU5RBoIjRks+OapijlO0cDNuZY9174GMX5Cq4nel8a+xnpBEMOXgqZ3/oCePqXNrV
         ONsClt1zUSBPYd/ro/yg5mXmilCqlippsyhR6TUkTf5FwxFnW6KmwGTxxzI3xKoAXUXZ
         JBHcj4AgPM7aEWIg/ljl77KA0y98leGsfn4WtD8HmwP67DuDR1+uyfSC8xajhNRht/9C
         pXQA1UBCRJFfY9n4VdwePhBHm+7TTB16R2O9KUmaycINVUCxSPL4n+SoRdBYKAInja/G
         4wQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700851180; x=1701455980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sko5wbhJl4GoYA+N107vBSXel0j9gH2nHoYpOfIqlM4=;
        b=SoGjfoKXL0lPcLGoc7wWaPxZuYJhOpA9un4+Uxem4nQTahJVyxNeJrOjevnx1J0c57
         TkWv3IEumy/DrEonjX8iibA9vfBqiRCB9xvocbIJeVMiHn2ajl8KCWQTcgil72TbqBOO
         92OwEfghshmBK9rooa88O9AAILA4Nfi/72f8kFxCAzO1Dg5R/b/yvJkvhRVC9YDfX1Sg
         HDG1glJlJH1WiICVuqCIqbYJq4NaDXchZPmhWlypyPCQ+TSeggz7tOoREVfSuzoZ25wV
         Y88EybSADwRcgPdu4Vr6OWrWtJ6dpK8ngbWvneYq71WN4GjW10v95GiW7Z9lWDpk5Mjd
         jYRw==
X-Gm-Message-State: AOJu0YyHFZdt5kfRaH4m/Rbv3Wv4lOwcicLwyDMrRjeI9H4ekrBmceKv
	k56LP4rQvU94fKFNyPeISNc=
X-Google-Smtp-Source: AGHT+IHOSs+nJs7/wou0ObNhG/GXSR9nhPsA/51np7GzBREBEvD1FcpoR3/NaJARo01/bC4pud1jHw==
X-Received: by 2002:a5d:5966:0:b0:32d:9a20:c9e0 with SMTP id e38-20020a5d5966000000b0032d9a20c9e0mr2910426wri.61.1700851180220;
        Fri, 24 Nov 2023 10:39:40 -0800 (PST)
Received: from localhost (62-165-236-105.pool.digikabel.hu. [62.165.236.105])
        by smtp.gmail.com with ESMTPSA id j15-20020adfff8f000000b00332f02123d2sm75820wrr.54.2023.11.24.10.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 10:39:39 -0800 (PST)
Date: Fri, 24 Nov 2023 19:39:38 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/4] completion: squelch stray errors in sparse-checkout
 completion
Message-ID: <20231124183938.GB11157@szeder.dev>
References: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
 <591c7b8d73b1a93feaa749d68156a198a7e32a9c.1700761448.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <591c7b8d73b1a93feaa749d68156a198a7e32a9c.1700761448.git.gitgitgadget@gmail.com>

On Thu, Nov 23, 2023 at 05:44:05PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> If, in the root of a project, one types
> 
>     git sparse-checkout set --cone ../<TAB>
> 
> then an error message of the form
> 
>     fatal: ../: '../' is outside repository at '/home/newren/floss/git'
> 
> is written to stderr, which munges the users view of their own command.
> Squelch such messages.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ba5c395d2d8..6fced40d04c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3014,7 +3014,7 @@ __gitcomp_directories ()
>  			COMPREPLY+=("$c/")
>  			_found=1
>  		fi
> -	done < <(git ls-tree -z -d --name-only HEAD $_tmp_dir)
> +	done < <(git ls-tree -z -d --name-only HEAD $_tmp_dir 2>/dev/null)

It would be better to use the __git wrapper instead, like the wast
majority of git invocations in our completion script, because it not
only takes care of squelching standard error, but also takes into
account any -C dir and/or --git-dir options present on the command
line.

e15098a314 (completion: consolidate silencing errors from git
commands, 2017-02-03)


>  
>  	if [[ $_found == 0 ]] && [[ "$cur" =~ /$ ]]; then
>  		# No possible further completions any deeper, so assume we're at
> -- 
> gitgitgadget
> 
> 
