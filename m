Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE6918053
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFLWajzZ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28c9d424cceso2861770a91.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2024 14:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704233242; x=1704838042; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U13yF7ptkMxg4C8fUXe03vzoLg4Zd3YskBGUtG1zdWk=;
        b=IFLWajzZMpHQkur4TUS6u/x5TjmS6DvxFlOSWLJ0FkGsU5F5M0BQiRoBsTu6uZdS3B
         YLW0HNkvh2e+Db56uOtbd1SgzSQlCl/qC5WdMjvY3WQ18c1AjnGlfvaUZdmQw9XwC5t1
         mm6fnCXeyGUpwpCA0ruJHrfy8zCcoX8GZYQTuvQfM9JljW/5ybScAzdQfXoD3p3RHWUI
         0TBBTd2DtcegwrtumLAIjWvXFShdaBllrgd2JE2ady0DBVyLgE2bXy6KR7IWrkB+9slU
         IWo+RyAFsLTFXSK2SXrl3HRsIYjmsJ8qAMFWmaF/Hx48e38N77xy7o8fQKC1SShRm/ue
         2l8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704233242; x=1704838042;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U13yF7ptkMxg4C8fUXe03vzoLg4Zd3YskBGUtG1zdWk=;
        b=aX+QF/5ngi0Cd1sJn1s27n1Jt5nMPuHokH8kPVVONj76TgTSPEDzirMckrOGl+yj5O
         IrWbpX1PHtmZaRHUQDwh6ZcPfgYPga/IxpXnv1ZX6zY7Noo0x9KNFMwmH7S04iY+HtjO
         0W1+kYE6fuC8Zh1JWbk0IFieLOgjDnlVpgeMp92enelW4n2LqEymTJFDmNIRoXxLmer/
         kXZ0Ybvue/5jjsZePmeFU9o/vPH/zsoa5IzaO6vtb3dHXqCJX38+E/iNXJVdY4wlwrHp
         cbqooDUjB25+8LX1+jxGU790xa4SjnQWpY1gONbrTkYnEEgv9U8BWzqpYw0pS9vFYYH6
         Tftg==
X-Gm-Message-State: AOJu0Yx4qCjUxen3FKKdcZ5InN2MaqdoD7GIkuhIMnzge3b8LrUPfKgR
	XzI8nBjsIsi57WDjBBJxxgqTmTgGxWtXm60Xj5o=
X-Google-Smtp-Source: AGHT+IE5IVN9G6jvjlzAqNKgbHJGeMk0f8zs+lR/uNnnF7d5qbYCTc637pCCsByyD36n2kVrnizg0w==
X-Received: by 2002:a17:90a:db94:b0:28c:a5ff:ea4d with SMTP id h20-20020a17090adb9400b0028ca5ffea4dmr142340pjv.1.1704233242567;
        Tue, 02 Jan 2024 14:07:22 -0800 (PST)
Received: from ?IPV6:2402:a00:401:a99b:65e8:f5a4:7adb:5726? ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090264c800b001d1cd7e4ad2sm22918866pli.125.2024.01.02.14.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 14:07:22 -0800 (PST)
Message-ID: <85d4e83c-b6c4-4308-ac8c-a65c911c8a95@gmail.com>
Date: Wed, 3 Jan 2024 03:37:18 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
Cc: newren@gmail.com, gitster@pobox.com, johannes.schindelin@gmx.de
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [GSOC][RFC] Heed core.bare from template config file when no command
 line override given, as a microproject.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm currently an undergrad beginning my journey of contributing to the
Git project. I am seeking feedback on doing "Heed core.bare from
template config file when no command line override given" described
here 
https://lore.kernel.org/git/5b39c530f2a0edf3b1492fa13a1132d622a0678e.1684218850.git.gitgitgadget@gmail.com/
by Elijah Newren, as a microproject. I would like to know from the
community, if the complexity and scope of the project is appropriate
for a microproject.

Approach:
As described by Elijah in commit message that fixing this cannot be
done in the create_default_files() function as it occurs too late.
This is because both clone and init have different checks and steps
for working with bare flag, like clone creates a new directory
[name].git and sets the GIT_DIR_ENVIRONMENT to it (when not provided
with an explicit dir name arg), while init sets the
GIT_DIR_ENVIRONMENT to the current working directory (when not
provided with an dir name arg). Also there are other steps like
setting no_checkout in a bare repository in builtin/clone.c. These are
all command specific steps which occur in builtin/clone.c and
builtin/init-db.c ,before we ever hit the TODO comment via
[builtin/clone.c]cmd_clone()->[setup.c]init_db()->
[setup.c]create_default_files().

Therefore, rather than centralizing the code in setup.c and adding a
bunch of if-else statements to handle different command specific
scenarios related to bare option, I propose to add a check for
template file config just after parsing of the flags and args in
builtin/init-db.c and builtin/clone.c.

e.g. in builtin/init-db.c :

static int template_bare_config(const char *var, const char *value,
                     const struct config_context *ctx, void *cb)
{
       if(!strcmp(var,"core.bare")) {
             is_bare_repository_cfg = git_config_bool(var, value);
       }
       return 0;
}

int cmd_init_db(int argc, const char **argv, const char *prefix)
{
...
...
       if(is_bare_repository_cfg==-1) {
             if(!template_dir)
                   git_config_get_pathname("init.templateDir",
                                           &template_dir);

             if(template_dir) {
                   const char* template_config_path
                                = xstrfmt("%s/config",
                   struct stat st;

                   if(!stat(template_config_path, &st) &&
                     !S_ISDIR(st.st_mode)) {
                         git_config_from_file(template_bare_cfg,
                                        template_config_path, NULL);
                   }
             }
...
...
       return init_db(git_dir, real_git_dir, template_dir, hash_algo,
                      initial_branch, init_shared_repository, flags);
}

I also wanted to know if the global config files should have an effect
in deciding if the repo is bare or not.

Curious to know your thoughts on, if this is the right approach or
does it require doing refactoring to bring all the logic in setup.c.
Based on your feedback, I can quickly send a patch.

p.s.: Apologies for the weird indenting, due to 70 character limit.
consider it just a prototype.

Thanks!
