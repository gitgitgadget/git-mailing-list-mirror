Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D6115EBB
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xk3wTTv+"
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E82D19E
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 07:47:38 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1e9bb3a0bfeso695270fac.3
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 07:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697813258; x=1698418058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSvP4a6uDuEvR+MDD+nWLpMZF3HSz4OJ9+JPQ2LxqVA=;
        b=Xk3wTTv+aPWYIRo1ICJ/mHlbd0mfB6cPKWp0eooBFt3qTRyK3GSbnutVGt7b0Sb9yL
         2U6HMkL8dfCG2hfVhpY1pwm70bY8+yMlDGMgL+qubHV19ecMNmmDQ4O+UDlVCX5YBLfA
         KO2pdtJ0GXqr9C7Z0gD4eUb5Vzy1Sk/XXQeX5fDxjzOI7hUuLnsZcDL/qJLEqbFYIifz
         7nITrD1iNOjCFW+FC/OXwuRrXQyC0RDmL01X4QvLnspejhd3FY7nU6ZHPUrm4ir/I2O2
         6/D7GpgxoJItWbVrWs7Af/LhUaNeJ9G7Dw2TcPK3Iyd631d9qEEtppx2j0XtPKFRba7c
         aY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697813258; x=1698418058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSvP4a6uDuEvR+MDD+nWLpMZF3HSz4OJ9+JPQ2LxqVA=;
        b=umL6MRaBPGPqWVziG/ICWfoNNf3ZtBtkIBX4y53j5cYeD4Do1VWw/zOrza7nSKP486
         TgeE0QMStL5ziAlx7yUjHXj9Qu6v12bUJ0kmu9QkR+e7YhwMONYQl7jBaZSKsEGm8pkN
         AMc5ZSdKOVDslvMpOR0U3OC77lPG6ms/wu1L42IFE+l2pdQ2rymndcgsJXpHRlJJxF/7
         c61KSQ8nng4CT60USJPhT6zRvBQiH81WqT0jsPFzMTllcVvdBnqPkgZFYpOeb5CXCIQw
         54gH+cIk7/+/9rDROCva7D0rA1LrQ0UG7EwI8LzwgV2ndzp5/DwkNe4yVv5cxuhRcDg/
         hClA==
X-Gm-Message-State: AOJu0YwAknfQrxxI4oE5bJNWOuj9pGZdQmox2aVZ9OTrTFrBDnfD9NpJ
	DVMkvyVzVL4TTI+ubVxLW8tGFoVttmTfd7OXITVsez36aIhvpA==
X-Google-Smtp-Source: AGHT+IHkECgPl2YIP9pP0TmZZDXf47y4bUenybFaeSRba5uox/GzVDN68c+ZIkZdJsJ8GHX8GcSe5F9jqr7mVrDpTGg=
X-Received: by 2002:a05:6870:cb86:b0:1e9:fcd0:8f9a with SMTP id
 ov6-20020a056870cb8600b001e9fcd08f9amr2488914oab.38.1697813257739; Fri, 20
 Oct 2023 07:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016103830.56486-1-karthik.188@gmail.com> <20231019121024.194317-1-karthik.188@gmail.com>
 <20231019121024.194317-4-karthik.188@gmail.com> <xmqq4jimuv26.fsf@gitster.g>
 <xmqqttqmtcc2.fsf@gitster.g> <CAOLa=ZR4Qd9x-zVv9OtL7KTU00W2uT-kxdhKOLFZbi5cnHdiSQ@mail.gmail.com>
In-Reply-To: <CAOLa=ZR4Qd9x-zVv9OtL7KTU00W2uT-kxdhKOLFZbi5cnHdiSQ@mail.gmail.com>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 20 Oct 2023 16:47:11 +0200
Message-ID: <CAOLa=ZT6qEsVfNETYua=RjjepDsXFj8uSdphS2LR1gGK1_sGFg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] rev-list: add commit object support in `--missing` option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 1:14=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
> I'm not entirely sure what the best path to take here to be honest. I wil=
l look
> and see if there are any bits where overlapping doesn't cause any issues
> in the meantime.

Was trying to use bit number 12, which coincides METAINFO_SHOWN in
builtin/blame.c.
From skimming over the code, METAINFO_SHOWN is used only within
blame.c and there
should not be collisions here since blame.c doesn't set the
do_not_die_on_missing_objects bit
either.

The tests seem to pass here too [1]. This could be the potential
solution here, Junio, what do you think?
I could send another version if this approach looks good.

[1] https://gitlab.com/gitlab-org/git/-/jobs/5339132966

Diff against the tip of v3:

diff --git a/object.h b/object.h
index b76830fce1..0cb8c02b95 100644
--- a/object.h
+++ b/object.h
@@ -62,7 +62,7 @@ void object_array_init(struct object_array *array);

 /*
  * object flag allocation:
- * revision.h:               0---------10         15             22------2=
8
+ * revision.h:               0---------10  12    15             22------27
  * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
@@ -82,7 +82,7 @@ void object_array_init(struct object_array *array);
  * builtin/show-branch.c:    0-------------------------------------------2=
6
  * builtin/unpack-objects.c:                                 2021
  */
-#define FLAG_BITS  29
+#define FLAG_BITS  28

 #define TYPE_BITS 3

diff --git a/revision.h b/revision.h
index d3c1ca0f4e..d2de9d65e4 100644
--- a/revision.h
+++ b/revision.h
@@ -38,6 +38,9 @@
 #define PATCHSAME    (1u<<9)
 #define BOTTOM        (1u<<10)

+/* WARNING: This is also used as METAINFO_SHOWN in builtin/blame.c. */
+#define MISSING     (1u<<12)
+
 /* WARNING: This is also used as REACHABLE in commit-graph.c. */
 #define PULL_MERGE    (1u<<15)

@@ -53,7 +56,6 @@
 #define ANCESTRY_PATH    (1u<<27)
 #define ALL_REV_FLAGS    (((1u<<11)-1) | NOT_USER_GIVEN |
TRACK_LINEAR | PULL_MERGE)

-#define MISSING (1u<<28)

 #define DECORATE_SHORT_REFS    1
 #define DECORATE_FULL_REFS    2
