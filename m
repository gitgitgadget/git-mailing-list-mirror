Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E795820E
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131522; cv=none; b=X41Uv9ey+7ub7z3JvGlOm/KufsojDtzgwOdIq29P4jrdsviA/9xkN2u7uVEYRB5/WtHwwU4d+W40Z4h1ARNkWfqmpWjxh1Tvjb3/z1f80qDGQoi9VTAX8rRzGvMaciq4uvW8o+ij2AKFhdVuKxtzPhRvfjD5OQEcCcuXECEiIr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131522; c=relaxed/simple;
	bh=fyIOmOiMOHelJ1o5ptFqRCIUqAHT4BKPeq204QY0fbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2kA+Ec2hZiHAppOMXGL+EK0FzJFw8WQHX+rSY9WDrUiVpxZDVdIp87Zkp+ndvQN3YcAR6uDOUBV9RzAA00IA7NvHs7zpOhIACoEwI0j0Wd+8Xb7HvPrZ7rp8Js+dwrQl+UmA7XTBUdL7XUmWPddvNiSu0wZ/XlV1HGuab8p8Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b0624d3626so25258966d6.2
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718131519; x=1718736319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGrTnj8xgul6Cr+MqTF7gnzEax1Q5FOVz4362Y6KeZg=;
        b=bIfd9Rher2YVecMcpSOj7BH9qkksTtPz5UL41+77vVcFW7zDe4nVg6osT+FUuIu5Ll
         PZWvIhmP4QNYwqA8Nmq/dIk5KHhPTncTzgPqpGmk/k7R0InZE+mDL54+/D8J9YA3Yli/
         QdZWSz7wXIeESW4TJ/HUlNr5TcQwaAx6n0yW9sFI9Uu/dd+5X6geZ3de40sPDjP2cuTR
         AetkBqg6oUgqvZMZ5GmgTcCKUTQrc1/dvsuxNvTRe1fSP71JIbu461RZrRfZXeAS1WX5
         EMxVVU0cOuoQCIafs4319HgQ6X22FczVVsRCga8ubKEa2dOu725MiNXCR6q5X1bypBP1
         6mBg==
X-Gm-Message-State: AOJu0YzLjeRnubBWIHcjuD/dfCoHQRVfXSGAKovZLSV7vsoqddr+aIBn
	YYCBDO6KWMwvQ18uxrXYuegLeNnqRbZ8lqLYeYXXnaOLSeIDG26EVrDFDdjb6pVoYAl/DlJavZB
	w7jt97ORy0gU71J7rc/Fp4gBaAJc=
X-Google-Smtp-Source: AGHT+IFxNi4GCCavCQYYEeSwO5sk2T+SjQyAIcJhUEMO4XHtZYEKKoBE23uKJ9f3aWutQ/9AIuB+O1BRY8uLIacmkqU=
X-Received: by 2002:a05:6214:2d42:b0:6b0:82ad:e89c with SMTP id
 6a1803df08f44-6b082adf246mr56795996d6.11.1718131519289; Tue, 11 Jun 2024
 11:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com> <5ade145352f44b431c16a2ec29cd87de489e8032.1718130288.git.gitgitgadget@gmail.com>
In-Reply-To: <5ade145352f44b431c16a2ec29cd87de489e8032.1718130288.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 11 Jun 2024 14:45:08 -0400
Message-ID: <CAPig+cSg_SgU_ETktkz7KapLmzdDjzvjEx-_jS8L-eguBGk4oQ@mail.gmail.com>
Subject: Re: [PATCH 03/16] mktree: use non-static tree_entry array
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 2:25=E2=80=AFPM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Replace the static 'struct tree_entry **entries' with a non-static 'struc=
t
> tree_entry_array' instance. In later commits, we'll want to be able to
> create additional 'struct tree_entry_array' instances utilizing common
> functionality (create, push, clear, free). To avoid code duplication, cre=
ate
> the 'struct tree_entry_array' type and add functions that perform those
> basic operations.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
> diff --git a/builtin/mktree.c b/builtin/mktree.c
> @@ -12,15 +12,39 @@
> +struct tree_entry_array {
> +       size_t nr, alloc;
> +       struct tree_entry **entries;
> +};
>
> +static void clear_tree_entry_array(struct tree_entry_array *arr)
> +{
> +       for (size_t i =3D 0; i < arr->nr; i++)
> +               FREE_AND_NULL(arr->entries[i]);
> +       arr->nr =3D 0;
> +}
> +
> +static void release_tree_entry_array(struct tree_entry_array *arr)
> +{
> +       FREE_AND_NULL(arr->entries);
> +       arr->nr =3D arr->alloc =3D 0;
> +}

For robustness, to make it less likely for future code to leak the
items pointed to by `arr->entries`, it might make sense for
release_tree_entry_array() to call clear_tree_entry_array() before
calling FREE_AND_NULL().

> -       ALLOC_GROW(entries, used + 1, alloc);
> -       entries[used++] =3D ent;
> +       /* Append the update */
> +       tree_entry_array_push(arr, ent);

Nit: the new comment seems superfluous
