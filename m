Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F6E10D3
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 18:28:08 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ca11922cedso14266167b3.2
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 18:28:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700792887; x=1701397687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGtou1seftz9Z7gFgCGi0Uey8yl/tjTh7c0wvlXokmg=;
        b=Xkauj9CYv7JGpA0HEAffAYNOg9S5cOiBRcasiREjey8lhTr4KsXVhW+vq+NePH+cth
         m89lUyDe+DOpRb3ZsYfRBBLRUoNNaVLYLroPyOkymMnEkf3vgII0TPQQRv+GZ4sWUuln
         uHgcKfX5S5Key9Srt30hueMlP8MISfjJUnEvmz1JnzK6pq+Cw8AtNErFwouzT677jYh4
         A/+t9Eu5rJCerB4e3APv1UmHk2qq8xIbquN/B7GXOso7oZXyVrS3rQqvc6Za3ixFbPHt
         D7pKntgYGndk3XbxReVrYEZ+CuQmCKJNlmW0e6IQiyL2bEnse41mh5RYTxjAUBAZrMi3
         QauQ==
X-Gm-Message-State: AOJu0YzPfRLQCn7ABH3mjSqi15/O4RHWShprNuIZrj9MNCMhh8I26ct6
	dIMQfY9KooIN7V7Zzl+E14AhYkQp8lvvNQZv4gA=
X-Google-Smtp-Source: AGHT+IHfw0wJgB/BpYY7Ng12eL88GCTx+/MEpm63Wc1sVk0UoLn5McZWx5TPQGEC9PoA4PsF2j26yU3dtSWL7keLP7M=
X-Received: by 2002:a0d:e885:0:b0:5cd:6dd1:b3dc with SMTP id
 r127-20020a0de885000000b005cd6dd1b3dcmr1283845ywe.29.1700792887629; Thu, 23
 Nov 2023 18:28:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <FE2AD666-88DE-4F70-8D6D-3A426689EB41@me.com> <CAPx1Gvf_meaEBq9XfS9aPg0yLja-2sAW5SUg0jx6f1jNyfmWHw@mail.gmail.com>
 <xmqqwmu79ac4.fsf@gitster.g>
In-Reply-To: <xmqqwmu79ac4.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 23 Nov 2023 21:27:56 -0500
Message-ID: <CAPig+cS6dAANqm7AcrjU9nhBezXRvB0Y-zPOzdar7s_8E-c28Q@mail.gmail.com>
Subject: Re: Orphan branch not well-defined?
To: Junio C Hamano <gitster@pobox.com>
Cc: Chris Torek <chris.torek@gmail.com>, Craig H Maynard <chmaynard@me.com>, 
	Git Community <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 9:03=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> +[[def_orphan]]orphan::
> +       The act of becoming on an <<def_unborn,unborn>> branch.

s/on an/an/

> +       After such an operation, the <<def_HEAD,HEAD>> points at a
> +       <<def_branch,branch>> that does not yet exist, and the
> +       commit first created from such a state becomes a root
> +       commit, starting a new history.
