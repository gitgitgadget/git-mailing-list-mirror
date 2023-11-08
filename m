Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFDAA3C
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 04:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+72NV+R"
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221DFD7C
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 20:38:51 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507bd19eac8so8378965e87.0
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 20:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699418329; x=1700023129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqoD166EtiHAsjAGfAqJaHHUSuYqL+TzEW1LNPniAmk=;
        b=D+72NV+RdmP2De1Ub7itOUaYYjq1cWl5csvac46egom9pwV6mB8mkmCAgPr0BTVXZG
         iHn/k8Tlki2r4UxFQvoTNVNV0PcwJ4OvnOuF+PUM6g9nGSSaZas28MT0wTPmFUSx3rJB
         6hGaTqr8jhJeFMXJsfn0yLrRZWO6jrWwL8r6V4GgOM38wRvITjhh4G82PivQeHKDIA6f
         fZ0xhxu+cgnUhye7+Dm0SuJixAVNMQjD78KpHWnC1XJ6XWCJuaJNONX74zsSKZzvpGei
         V3BT7rRFs/Iag24kSolzCA3HWAV/SGraHQOvWbhwCiLwzSNLEdxlXXXcs83G97YTMYLf
         D3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699418329; x=1700023129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqoD166EtiHAsjAGfAqJaHHUSuYqL+TzEW1LNPniAmk=;
        b=Qg0T/RYABJNWI0EQAZpYEvLvYnXdUYqVkqOsS1HyIP6V8YGT83u+LjKLsiW7uGGWr+
         dpKWbemvZaIzEIHb7uWUkZylFJVoYIpEJgsqFqxk0kIcMa8UEoTXWzrrRdr6Ld1EYg1H
         y4rg5UYsERvYNf4JHS2VMA8ujMvnmWCClY5WvY6Slzg9DjNu3sn42QqiQJdU0i3e6fp9
         TxVAHdAxnTQ9IJOmN2s8rdbmwjdJzWXsnhGa994nN6OBJ6kCS378ij+TfR4zZcGg5WWg
         0elb3TYv9hsUx4K/cBV+pQ0BDt6alKy4HpbLchVx1wnR73PvIMl+v1XfYYu7cYjAjZZk
         SZ0Q==
X-Gm-Message-State: AOJu0YxcyzDJAJfIeYYsprG+fCdxYhFG5vFkPgUO1xRCkoKakEXQm2WV
	jVzNPoP9x479OwAGUO53dAfk0nvwbatwUZaDQUzgIJZR9pQ=
X-Google-Smtp-Source: AGHT+IHu1Nq2UDdR/Lr8yF0k8TF5gCin+9+ANeir43FmOrwNqcaLeXD0DR5setNpyJspGV6A1+qziTfd6gt0jp/2VL4=
X-Received: by 2002:a05:6512:e9b:b0:509:4c7b:c734 with SMTP id
 bi27-20020a0565120e9b00b005094c7bc734mr484632lfb.20.1699418329058; Tue, 07
 Nov 2023 20:38:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1606.git.1699010701704.gitgitgadget@gmail.com>
 <CABPp-BEuvjduS4JiORJybKtoPWvJd+BbbR_JAvZdj4Px_v8H4A@mail.gmail.com>
 <xmqq7cmu9s29.fsf@gitster.g> <CABPp-BF9iUkF+g_w7wLATFTmjfJ3f1hsBr+zXxNZEcq-XiNOWg@mail.gmail.com>
 <xmqqttpx828i.fsf@gitster.g> <CABPp-BEgxKn3QvJQ+6L3Z1RN1im=c3dfApLRCrQqum_Yim44Gw@mail.gmail.com>
 <xmqqv8ac7utk.fsf@gitster.g>
In-Reply-To: <xmqqv8ac7utk.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 7 Nov 2023 20:38:36 -0800
Message-ID: <CABPp-BHqJ0o85H7nBbPJ0b4kXvWF7TMCrTzpxhWfSHSrfGf7dQ@mail.gmail.com>
Subject: Re: [PATCH] diff: implement config.diff.renames=copies-harder
To: Junio C Hamano <gitster@pobox.com>
Cc: Sam James via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 8:06=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> > We probably don't want to copy all three of those sentences here, bu=
t
> >> > I think we need to make sure users can find them, thus my suggestion
> >> > to reference the `--find-copies-harder` option to git-diff so that
> >> > affected users can get the info they need to choose.
> >>
> >> "in addition to paths that are different, will look for more copies
> >> even in unmodified paths" then?
> >
> > That's much better.  I still slightly prefer referencing
> > `--find-copies-harder` so that there's a link between "copies-harder"
> > and `--find-copies-harder`; but this version would also be fine.
>
> Oh, I didn't mean "use this rewrite and do not make any external
> reference".  More like "external reference is a good idea and
> necessary to help motivated readers, but we should give enough
> information inline, and I think this level of details would be
> sufficient".

Ah, gotcha.  Yeah, this sounds good.
