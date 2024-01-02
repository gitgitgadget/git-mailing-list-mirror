Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C13A14010
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ0HL6NQ"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2044d093b3fso6312255fac.3
        for <git@vger.kernel.org>; Tue, 02 Jan 2024 07:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704209029; x=1704813829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vSTTyWf2kjSn+vfkJClKvo58zrrJ2khRevHfo/HflDA=;
        b=TQ0HL6NQvyJCexzEtdD0ZOX6UrzIOs73t22Aq3SFets+od2gwQsajfkdG/zEzWrJRq
         yP/Dp0p6OnNOKGQb6SR2wRqrXzWaoImKqrxzlua1yfbZNJEOa7qFkuSjZxqewJjkRIkN
         fpt81SU397zeRJNJXC8YD+HyQ14VZrQlb6xUsA4GgGCuTxab9JGSvWOOsPaYYIYtEBX4
         a/FXgKYVFnyKAHbW8VVq1Dy+cc+0rK7tyd/wtSIrmfvBb9zwVPhN5otdKLRolNuIXy2k
         XtzO/Lh9IieMyuJYZa6nZRQkEFcB4EloN7M8szYmXwh/NiVOPXulbjf/IP2PpktEfSaM
         1i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704209029; x=1704813829;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSTTyWf2kjSn+vfkJClKvo58zrrJ2khRevHfo/HflDA=;
        b=UOl2MhX8J6CwuALQEMx0Q/C7YwFzHwO7HJAmkb54C01lERxsXSoQvz22Mjrcq3txck
         JCR+yuCJsT2JZZ13I/xB+Q6jnFm/WNk6Ce3E47bU3ztGPKKdbOMJDFkSY4Db+iUgtV4J
         GxNDymn32YUgdJBgeOqmHVEKCygNufPwVVu/Uk+V3YsnH+ZfJYKxz7jI6CXIGAUcwpGe
         RM7tSOuzk5qSG5FdmX8o9lDOp/7DXQGZXXikfoCSePZbwdnKSboePIBW1S/t8euRM3No
         TTaGpRKxSnjiA9SL2nVrTVERCPamB8CBe9lRLMnb5STkMYg0D8U5HmcwCrnUe+ndQt7J
         9X0w==
X-Gm-Message-State: AOJu0YwmrsIRWX9sWH93SAMankfh61RrE54UqQGwA1GRviweFBimcMxF
	NQ7sAmR5jw+HySEg89ahDFx8KCPXpjuh174bcOB7mZbH
X-Google-Smtp-Source: AGHT+IFzhmrM2RHoR/ahG/6AJ35Q72C9l1w9ftm2rlnFNapKMvlUfKho9B58MP9TLiNMq894HoLLv768RJpLPe3BvB0=
X-Received: by 2002:a05:6870:1709:b0:204:9a7:5b4a with SMTP id
 h9-20020a056870170900b0020409a75b4amr21685152oae.15.1704209029316; Tue, 02
 Jan 2024 07:23:49 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jan 2024 07:23:48 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZY1PLtPue4PgbhwU@tanuki>
References: <20231221170715.110565-1-karthik.188@gmail.com>
 <20231221170715.110565-3-karthik.188@gmail.com> <xmqqzfy3l270.fsf@gitster.g> <ZY1PLtPue4PgbhwU@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Jan 2024 07:23:48 -0800
Message-ID: <CAOLa=ZSzmmLTNRX_muNGP7tG65mkpKXfUG9sbNZBL3qv930B8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Content-Type: multipart/mixed; boundary="000000000000d0deb5060df8153e"

--000000000000d0deb5060df8153e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:
> One interesting question is how we should treat files that look like a
> pseudoref, but which really aren't. I'm not aware of any such files
> written by Git itself, but it could certainly be that a user wrote such
> a file into the repository manually. But given that we're adding new
> behaviour that will be opt-in (e.g. via a new switch) I'd rather err on
> the side of caution and mark any such file as broken instead of silently
> ignoring them.
>

This is definitely tricky, especially since something like
`COMMIT_EDITMSG` passes the `is_pseudoref_syntax()` check and could
simply contain a commit-ish object ID. Here identifying that this is not
a pseudoref is hard when it satisfies both:
1. The general pseudoref syntax
2. Contains the expected file content type

>
> Yup, for the reftable we don't have the issue of "How do we detect refs
> dynamically" at all. So I would love for there to be a way to print all
> refs in the refdb, regardless of whether they start with `refs/` or look
> like a pseudoref or whatever else. Otherwise it wouldn't be possible for
> a user to delete anything stored in the refdb that may have a funny
> name, be it intentionally, by accident or due to a bug.
>
> In the reftable backend, the ref iterator's `_advance()` function has a
> hardcoded `starts_with(refname, "refs/")` check. If false, then we'd
> skip the ref in order to retain the same behaviour that the files
> backend has. So maybe what we should be doing is to introduce a new flag
> `DO_FOR_EACH_ALL_REFS` and expose it via git-for-each-ref(1) or
> git-show-ref(1). So:
>
>   - For the reftable backend we'd skip the `starts_with()` check and
>     simply return all refs.
>
>   - For the files backend we'd also iterate through all files in
>     $GIT_DIR and check whether they are pseudoref-like.
>

This makes sense to me and is along what I was considering for the
dynamic approach, thanks for writing it down, clarifies my thoughts.

--000000000000d0deb5060df8153e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6126c2d9c5339bdc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1XVUtvTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMi9HQy80cWlLaTNqOXpFVVZXTlBrc0ZZKzdHZ2JwcwpKVDlDMnFqblNt
WnVFU281S2EyT1FEM0RFc3FhV1kxc0dEc2NHRGYxbmZva1lMaGJxM25YTndOQUtPL0ZUcnFOCmZF
MGR5eG90ajNSZlBHT2ZoS3RIaUJ4VUZibW9EdkRzb0d2NHdjazYrdDNJV1AzVE5melkzU1dlaFRW
Ylc1dlMKYmQ3NGkvcVZlcHZEMjh3TFNlMHkrUTF5a0FCUWJMN0FzTHpNbksvQjVhYmJzczVmeVhE
YTg3NnA3b1VLclFOQgpncUR2UUlncmk4UmFuVjM0QWE2TVZUK0dMRlZheHZmQmUyK2laam45Smxp
K3VLYytvaFM5VzhkMUhOTnd3RnVGClRsblBaVXVTV3BLR25UcU5LRW5yTkZSWUc4YnZSanpBTDFs
K3d6WndOZWRIMjZyVTlha1BGd0tyVzdIbnIvY28KT2pkZ1RyMmNLeGJqYU56UDlZU05TcStBaytP
Y24yRkJxRmlyMlNKdkMwUVhjTi9vSDFBZ0xXajJkY2lISW82SApKVU5iZXlrVnAwUHU0Y2pCRlNl
RlBGVndWd2VVYzBLa2UyUjFBZ25uRDg4bGM3K1A1K0grVCttSGZ6Rm0yYWNWClMvZkVTQmRYTm5o
ZmQzYWlFZC9ZclZyYnNJOWpYdm04aHEwUjBjOD0KPWN5UHcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d0deb5060df8153e--
