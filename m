Received: from esa6.hc3812-35.iphmx.com (esa6.hc3812-35.iphmx.com [139.138.46.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D82340414
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.46.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935187; cv=none; b=Kxod1Wcp3jBiFdwvacryR+nzQFExT/3xFfNM16sx3l5TBPurqa21XPaQyN3XLCqM+UUSCPNW1PRqeaPOFf9Lw36m+Zw+GCM6OFqbFAHTqzPdPeNOtfdH1TuxZ2R6sOUa0EOkVNzcWRDacSQhDtWhhXxBPgBxWuk2iFBWtkUcYK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935187; c=relaxed/simple;
	bh=H34/+kjqwRfvzfgM7QS4yqWDGRPswAmc2dkMhgZpKWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEbyU0J5ZZ4ShJyNgRLtEa4kJIDNZOBnntLbyqYGknNbPTv0u/jyP9rufB6NoV9GkV5u9PFgqtYWZ583uS6L7cU6iXjcWIOnfpcn/fbrv3ZbxoxIjWxYtx6Iev2XXdQegjAHWWSo1iD3LW0nQBhev9coPTyyurldi0Uq9S6D32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=creditkarma.com; spf=fail smtp.mailfrom=creditkarma.com; dkim=pass (2048-bit key) header.d=creditkarma.com header.i=@creditkarma.com header.b=siHth5QE; dkim=pass (2048-bit key) header.d=creditkarma.com header.i=@creditkarma.com header.b=W89arzWY; arc=none smtp.client-ip=139.138.46.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=creditkarma.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=creditkarma.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=creditkarma.com header.i=@creditkarma.com header.b="siHth5QE";
	dkim=pass (2048-bit key) header.d=creditkarma.com header.i=@creditkarma.com header.b="W89arzWY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=creditkarma.com; i=@creditkarma.com; q=dns/txt; s=2;
  t=1780935184; x=1812471184;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc:content-transfer-encoding;
  bh=H34/+kjqwRfvzfgM7QS4yqWDGRPswAmc2dkMhgZpKWY=;
  b=siHth5QEumhjeeIZWJzPg4uycYMw3mjEJG6YGVRpVWszOsAv8R5UQ8kU
   nfF527ejFdpP4FXgryMnhgwmlpD1I+PM4rJNgpksIbRWt96em00S9uv8k
   R4VQFWceX7Lhxyajg7xZruQOPeRQP1VhgXQQHuE0G2RCLioFyFF+AysOP
   GJH9OTvSL6aAk0pBdsK2/1NOuci0r/Fhx0BWoUYx95LeH5QxM1XxDYzKv
   DkFxsy/omVX+bOwQ6Ct+a+23R1kH2HUBzhUi6dhXliz8BbOBKyVr7bJVE
   0LYYldYPC/oj3uKi59hGTAuLVRFlZJvcZuD3M2/TTekClAfZnrvrDABnp
   Q==;
X-CSE-ConnectionGUID: 8Y6ScLhJSFS+3cTD/+vmgw==
X-CSE-MsgGUID: O/KGCWZdS/W2+mSaHFXEHg==
X-SBRS: None
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:mYlVu64YTzedQMVEGr/JrwxRtGXGchMFZxGqfqrLsTDasY5as4F+v
 mNLCmqCaP6ONjHyfdggadu38kwE6JTRm9JjHFZpqiBkEysa+MHIO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG/6yE6iefQH+SU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCkaGt
 MiaT/f3YDdJ4BYqdDhIg06/gEk35qqq5mtI5gVWic1j5zcyqVFEVfrzGonhdxMUcqEMdsamS
 uDKyq2O/2+x138FFtO/n7/nRVYBS7jUMBLmoiI+t3+K20UqSoQai87XBdJEAatlo2zhc+NZk
 b2hgaeNpTIBZcUgrgi/vy5wSEmSNYUekFPOzOPWXca7lyUqeFO0qxli4d1f0ST1NY+bDEkXn
 cH0JgzhYTjTtryNy5a7aNJCvYd4J/XHe8ABv35/mGSx4fYOGfgvQo3P7N5cmTA334VAQq6Ya
 M0eZj5iKh/HZnWjOH9NUMN4zLru3yemNWIAwL6WjfNfD2z7ygtr2rX3LJzWe9GRSMF9lVyVq
 mPa/G3jBxhcP9uaodaA2i791rWSwH+lMG4UPJr/1dFBv2+f/SssUl4TblKbj8mUqkHrDrqzL
 GRRoELCt5Ma+023ZsfyUgf+o3OeuBMYHd1KHIUHBBqlz6PV50OeATFBQGEZLtMhs8AySHoh0
 Vrhc87VOAGDeYa9ERq1nop4ZxvrUcTJBQfuvRM5cDY=
IronPort-HdrOrdr: A9a23:4EOInq9Gb9owfICfd7Fuk+D6I+orL9Y04lQ7vn2ZKCYlCfBw8v
 rF8cjzuiWE7wr5NEtQ4OxoW5PhfZq/z+8Q3WB5B97LNzUO3lHYTr2KwrGSpgEIcBeOkNK1u5
 0QC5RWOZnfCRxVg6/BjjVQ0OxO/DBEysyVbC7lrgYPcShaL5xt6A9/F2+gYzdLeDU=
X-Talos-CUID: 9a23:vP8gi23/APEOrLJ8KfFrtLxfSvF7SXb5zFXrDXT7Um1VZPrWV1qf5/Yx
X-Talos-MUID: 9a23:zLAnngW9SXFQA2zq/Birpx5JC/Vk2OORUgMIqpwmlfmpFSMlbg==
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="49825546"
Received: from mail-oo1-f70.google.com ([209.85.161.70])
  by ob1.hc3812-35.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jun 2026 09:13:03 -0700
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-69e87ffce0fso2225705eaf.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 09:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780935182; x=1781539982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8eVKhqpJ6jFqb+qjaxuXcouM1Po85maUPX++ZZcbq4M=;
        b=RFhk+haNwvkGcSXyQcYcabVDh8g8RNhllw5MZX3U95aXY7a2/ww6+19e598M+9qWYi
         6D20xKwDniLkJ2ZqS8Vskx5ZdNNjL8t/rDG5fV7ofJxoMH3LPsnW5S1rPQGqwB33YSaG
         b7Lpr1nfAC6M6Lbkqr5sAi7yXyUwFsknQ5wDknfbTW3lv3SdVwNhBHYOVr/sdBNvXUFQ
         u978HG8UY3K0isLmbLJor040u2PK+cpjMO7xkLxv/97mNUCDOdsbDuQsCpjZtRBPDzJY
         hHbClm5BfJ5qOoLnaLi/y5ZrY5F/sdFWo8gQDwjPrepUVL5l+OEv0C5ZXcpujbacCb6n
         VIhA==
X-Gm-Message-State: AOJu0YzGGy9RgNyUFWeI7yoxlUceBJYzL9xt32BMP3l7tIIfppnwWZFp
	hJ4XXobb4bI/EBJWJA5HUZEvRHdhF9EuVuxXvR1MEIrkLC284ph+In7xvCEUQSJ51X8X3MoXqxK
	i0iOJ1JcvnEKuIblgeVQhOQPETQRDlXvwP/SRGg4UAW+lw0YMVQAdAjk9PExQcvdrN7iPevDROb
	oypMf8aCTXsWVrJTt2wIwA+6tpZqucT43N8m9N5/c5H1BwJkU3f272DY4OoHAaJIB8kIGzof6Mv
	yoVHTXqDL+aQaSBfZ5Pdt3HP4dm99WdY5EzH5LcNQ==
X-Gm-Gg: Acq92OFvx3brcjmaE4gT4/b2ogYvMu1ILtnkQx9sdynK7O4DxV3xkHz+mEO84/ycdKP
	wZSzV3wF20hYWLnswJoLTkfsnXMyP0DVg3+w6vcvWnjJAS4+RVNKZYKT1yWSlqMTnSD3jTkX0/r
	rpte414MkgTJSPM95y35st8EyM2buKt+K59qX38yeMsA0f9eT2Z7ca9M9zoF3cIGPZkUP8lQ9eC
	m4Z0fYFpCXac4r+lfKu+ncaeJc1qMJPHJblsbkp9bYQNubzqp9W/FSvj8h0Y3XCZLIlJ8pcQhqP
	fN90fAefq1HwoAfUUNVLNONFZUtKAB14fnzZ9hix7XWvxRwVbY6vTNW00dVPJiSbb6j+VIR17ce
	iQiI08XmP5rrDLYGw/sevhnnoZw/hOzHQwTt4s8It8k4YDYQAzoYY3mXpRZElLOlhDBmpyccSBq
	J/iO4UVQrdFF36qg==
X-Received: by 2002:a05:6820:208c:b0:69e:31fc:d12c with SMTP id 006d021491bc7-69e68b1bdefmr8500622eaf.4.1780935182424;
        Mon, 08 Jun 2026 09:13:02 -0700 (PDT)
X-Received: by 2002:a05:6820:208c:b0:69e:31fc:d12c with SMTP id 006d021491bc7-69e68b1bdefmr8500595eaf.4.1780935181848;
        Mon, 08 Jun 2026 09:13:01 -0700 (PDT)
Received: from sin41a5.mail.zscalertwo.net (sin41a5.mail.zscalertwo.net. [147.161.205.62])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-440d850ec9csm1612999fac.11.2026.06.08.09.13.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:13:01 -0700 (PDT)
X-Relaying-Domain: creditkarma.com
Received: from mail-ot1-f70.google.com ([209.85.210.70])
	by sin41a5.mail.zscalertwo.net ([147.161.205.46])
	with ESMTPS id 6A26EA0C08470001;
	Tue, 09 Jun 2026 00:13:00 +0800
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6dcca848bso8185669a34.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 09:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=creditkarma.com; s=google; t=1780935177; x=1781539977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eVKhqpJ6jFqb+qjaxuXcouM1Po85maUPX++ZZcbq4M=;
        b=W89arzWYp+9rR72wun1rjg6NlJ82lpM48uQGo7w+NpJ2z6VGRsTj2GwYO228m6HW93
         yofPCj1ixVzZppHxqPscl0ZJm1amwXBQYufjsw8aljAPSOXZon01eRsxWEf9p0KAKW8A
         Ot2y14pXXjHy/QfokAOMwjVyEZaHV9qMLWjXU3ROw90dsGTMB/a2wErMh96a9+bqZaCk
         SDAkhQtQ6X8D6vinAQgWuPpHYkzyGX4spLjeuZPT73jQCwg9JjEYIQcPuXdXfdnj+wJj
         7IrIGS4iob5QXMKb3x1RT4CErhRrfUzrZIdAkScCIt3D/1ncFLTnXjeBI9BO0u4WXBkJ
         nddw==
X-Received: by 2002:a05:6830:3813:b0:7e6:ece3:8101 with SMTP id 46e09a7af769-7e70c421de5mr9615713a34.0.1780935177056;
        Mon, 08 Jun 2026 09:12:57 -0700 (PDT)
X-Received: by 2002:a05:6830:3813:b0:7e6:ece3:8101 with SMTP id
 46e09a7af769-7e70c421de5mr9615679a34.0.1780935176242; Mon, 08 Jun 2026
 09:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPGaHku+RAV+FA3C0md0xHiavfdB_anoqcMM06MAiU1VyMAdLA@mail.gmail.com>
 <b1b15a47-0842-4a26-9a95-bfdae12799e0@gmail.com> <CAPx1Gvegc0KvE8zb90n7vLJLKx6EkmBvCWW=NPf+nwiZc+oWdQ@mail.gmail.com>
In-Reply-To: <CAPx1Gvegc0KvE8zb90n7vLJLKx6EkmBvCWW=NPf+nwiZc+oWdQ@mail.gmail.com>
From: "Kiesel, Norbert" <norbert.kiesel@creditkarma.com>
Date: Mon, 8 Jun 2026 09:12:44 -0700
X-Gm-Features: AVVi8CfnJHy8GBWMPuuxv3lRRRzwCRLBBhxKVm6o6Xj78yl3lwMvFWWodB-aDL8
Message-ID: <CAPGaHkv=p62gLwkufc6TWjJR3OdV+DYdmWUZ6Xn0-qgHsw5_4Q@mail.gmail.com>
Subject: Re: [PATCH] worktree: record creation time and free-form note
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Chris Torek <chris.torek@gmail.com>, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Zscaler-Block: 0

Hi team,
I updated my proposed extension in a couple of ways you suggested, and
also added some more test code.

Best,
  Norbert

diff --git Documentation/git-worktree.adoc Documentation/git-worktree.adoc
index fbf8426cd9..1cdbdc8dbe 100644
--- Documentation/git-worktree.adoc
+++ Documentation/git-worktree.adoc
@@ -10,8 +10,11 @@ SYNOPSIS
 --------
 [synopsis]
 git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]
+ [--description <string>]
  [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]
-git worktree list [-v | --porcelain [-z]]
+git worktree describe <worktree> [<description>]
+git worktree list [-v | --porcelain [-z]] [--show-created]
+ [--show-updated] [--show-description] [--sort=3D<key>]
 git worktree lock [--reason <string>] <worktree>
 git worktree move <worktree> <new-path>
 git worktree prune [-n] [-v] [--expire <expire>]
@@ -106,6 +109,16 @@ passed to the command. In the event the
repository has a remote and
 command fails with a warning reminding the user to fetch from their remote
 first (or override by using `-f`/`--force`).

+`describe <worktree> [<description>]`::
+
+Set, replace, or clear a free-form description on a linked worktree.
+Useful for recording what a worktree was created for so it can be identifi=
ed
+later. With _<description>_, the worktree's description is set or replaced=
;
+without a description argument, the existing description is cleared. The
+description for a worktree may also be set at creation time with
+`git worktree add --description <description>`. The main worktree cannot b=
e
+described.
+
 `list`::

 List details of each worktree.  The main worktree is listed first,
@@ -114,6 +127,28 @@ whether the worktree is bare, the revision
currently checked out, the
 branch currently checked out (or "detached HEAD" if none), "locked" if
 the worktree is locked, "prunable" if the worktree can be pruned by the
 `prune` command.
++
+Each worktree's creation timestamp is recorded when it is created with
+`git worktree add`. Worktrees created before this feature existed have no
+recorded creation timestamp; for them, `list` reports `created: unknown`
+in human output and omits the `created` line in `--porcelain` output. Pass
+`--show-created` to include creation timestamps in human output. Worktrees
+without a recorded timestamp sort last (or first when reversed) with
+`--sort=3Dcreated`.
++
+Pass `--show-updated` to include each worktree's last-updated timestamp,
+which is the modification time of the worktree's `HEAD` file and so
+reflects checkouts, commits, resets, rebases, and similar Git operations.
++
+Pass `--show-description` to include any user-provided description in huma=
n
+output. In `--porcelain` output, the `created`, `updated`, and
+`description` lines are emitted whenever the underlying data is available.
++
+Use `--sort=3D<key>` (where _<key>_ is `path`, `created`, or `updated`,
+optionally prefixed with `-` to reverse) to order the linked worktrees;
+the main worktree always remains first. Sorting by `created` or `updated`
+implies the matching `--show-created` / `--show-updated` flag so the order
+is visible alongside the data.

 `lock`::

@@ -286,6 +321,46 @@ _<time>_.
  With `lock` or with `add --lock`, an explanation why the worktree
  is locked.

+`--description <string>`::
+ With `add`, attach a free-form description to the new worktree.
+ The description is stored alongside the worktree's administrative
+ files and can be displayed with `git worktree list --show-description`
+ or in `--porcelain` output. It can be changed later with
+ `git worktree describe`.
+
+`--show-created`::
+ With `list`, include each worktree's creation timestamp in the
+ human-readable output. Worktrees with no recorded creation time are
+ shown as `created: unknown`. In `--porcelain` output, the creation
+ timestamp is always included (when available) on a `created` line.
+
+`--show-updated`::
+ With `list`, include each linked worktree's last-updated timestamp in
+ the human-readable output, derived from the modification time of the
+ worktree's `HEAD` file. Linked worktrees whose `HEAD` cannot be read
+ are shown as `updated: unknown`. The main worktree is not annotated
+ with an updated timestamp. In `--porcelain` output, the timestamp is
+ included on an `updated` line whenever it is available (and the
+ worktree is not the main worktree).
+
+`--show-description`::
+ With `list`, include each worktree's description (if set) in the
+ human-readable output. In `--porcelain` output, the description is
+ always included (when set) on a `description` line.
+
+`--sort=3D<key>`::
+ With `list`, sort linked worktrees by _<key>_, which is one of
+ `path`, `created`, or `updated`. Prefix with `-` to reverse the order,
+ e.g. `--sort=3D-created` lists newest first. The main worktree is always
+ listed first regardless of sort order. For `created`, worktrees with no
+ recorded creation timestamp sort after those that have one (or before,
+ when reversed). For `updated`, ordering is by the modification time of
+ each worktree's `HEAD` file (a proxy for when the worktree was last
+ touched by checkout, commit, reset or rebase); worktrees whose `HEAD`
+ cannot be read sort after those that can. Sorting by `created` or
+ `updated` implies the matching `--show-created` / `--show-updated`
+ option so the values driving the order appear in human output.
+
 _<worktree>_::
  Worktrees can be identified by path, either relative or absolute.
 +
@@ -462,7 +537,10 @@ are terminated with NUL rather than a newline.
Attributes are listed with a
 label and value separated by a single space.  Boolean attributes (like `ba=
re`
 and `detached`) are listed as a label only, and are present only
 if the value is true.  Some attributes (like `locked`) can be listed as a =
label
-only or with a value depending upon whether a reason is available.  The fi=
rst
+only or with a value depending upon whether a reason is available.  Option=
al
+valued attributes (like `created`, `updated`, and `description`) appear
+only when the corresponding metadata has been recorded for that worktree.
+The first
 attribute of a worktree is always `worktree`, an empty line indicates the
 end of the record.  For example:

@@ -474,10 +552,15 @@ bare
 worktree /path/to/linked-worktree
 HEAD abcd1234abcd1234abcd1234abcd1234abcd1234
 branch refs/heads/master
+created 2026-06-01T12:34:56Z
+updated 2026-06-04T17:20:11Z
+description investigating login bug

 worktree /path/to/other-linked-worktree
 HEAD 1234abc1234abc1234abc1234abc1234abc1234a
 detached
+created 2026-05-28T08:15:00Z
+updated 2026-05-30T09:42:08Z

 worktree /path/to/linked-worktree-locked-no-reason
 HEAD 5678abc5678abc5678abc5678abc5678abc5678c
diff --git builtin/worktree.c builtin/worktree.c
index d21c43fde3..132de668e3 100644
--- builtin/worktree.c
+++ builtin/worktree.c
@@ -27,13 +27,17 @@
 #include "utf8.h"
 #include "worktree.h"
 #include "quote.h"
+#include "date.h"

 #define BUILTIN_WORKTREE_ADD_USAGE \
  N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason
<string>]]\n" \
+    "                 [--description <string>]\n" \
     "                 [--orphan] [(-b | -B) <new-branch>] <path>
[<commit-ish>]")

 #define BUILTIN_WORKTREE_LIST_USAGE \
- N_("git worktree list [-v | --porcelain [-z]]")
+ N_("git worktree list [-v | --porcelain [-z]] [--show-created]\n" \
+    "                  [--show-updated] [--show-description]\n" \
+    "                  [--sort=3D<key>]")
 #define BUILTIN_WORKTREE_LOCK_USAGE \
  N_("git worktree lock [--reason <string>] <worktree>")
 #define BUILTIN_WORKTREE_MOVE_USAGE \
@@ -46,6 +50,8 @@
  N_("git worktree repair [<path>...]")
 #define BUILTIN_WORKTREE_UNLOCK_USAGE \
  N_("git worktree unlock <worktree>")
+#define BUILTIN_WORKTREE_DESCRIBE_USAGE \
+ N_("git worktree describe <worktree> [<description>]")

 #define WORKTREE_ADD_DWIM_ORPHAN_INFER_TEXT \
  _("No possible source branch, inferring '--orphan'")
@@ -66,6 +72,7 @@

 static const char * const git_worktree_usage[] =3D {
  BUILTIN_WORKTREE_ADD_USAGE,
+ BUILTIN_WORKTREE_DESCRIBE_USAGE,
  BUILTIN_WORKTREE_LIST_USAGE,
  BUILTIN_WORKTREE_LOCK_USAGE,
  BUILTIN_WORKTREE_MOVE_USAGE,
@@ -116,6 +123,11 @@ static const char * const git_worktree_unlock_usage[] =
=3D {
  NULL
 };

+static const char * const git_worktree_describe_usage[] =3D {
+ BUILTIN_WORKTREE_DESCRIBE_USAGE,
+ NULL
+};
+
 struct add_opts {
  int force;
  int detach;
@@ -124,6 +136,7 @@ struct add_opts {
  int orphan;
  int relative_paths;
  const char *keep_locked;
+ const char *description;
 };

 static int show_only;
@@ -131,6 +144,9 @@ static int verbose;
 static int guess_remote;
 static int use_relative_paths;
 static timestamp_t expire;
+static int show_created =3D -1;
+static int show_updated =3D -1;
+static int show_description;

 static int git_worktree_config(const char *var, const char *value,
         const struct config_context *ctx, void *cb)
@@ -544,6 +560,16 @@ static int add_worktree(const char *path, const
char *refname,
  strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
  write_file(sb.buf, "../..");

+ strbuf_reset(&sb);
+ strbuf_addf(&sb, "%s/created", sb_repo.buf);
+ write_file(sb.buf, "%"PRItime, (timestamp_t) time(NULL));
+
+ if (opts->description && *opts->description) {
+ strbuf_reset(&sb);
+ strbuf_addf(&sb, "%s/description", sb_repo.buf);
+ write_file(sb.buf, "%s", opts->description);
+ }
+
  /*
  * Set up the ref store of the worktree and create the HEAD reference.
  */
@@ -815,6 +841,8 @@ static int add(int ac, const char **av, const char *pre=
fix,
  OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree locked"))=
,
  OPT_STRING(0, "reason", &lock_reason, N_("string"),
     N_("reason for locking")),
+ OPT_STRING(0, "description", &opts.description, N_("string"),
+    N_("attach a free-form description to the worktree")),
  OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
  OPT_PASSTHRU(0, "track", &opt_track, NULL,
       N_("set up tracking mode (see git-branch(1))"),
@@ -963,6 +991,8 @@ static int add(int ac, const char **av, const char *pre=
fix,
 static void show_worktree_porcelain(struct worktree *wt, int line_terminat=
or)
 {
  const char *reason;
+ const char *description;
+ timestamp_t created;

  printf("worktree %s%c", wt->path, line_terminator);
  if (wt->is_bare)
@@ -975,6 +1005,26 @@ static void show_worktree_porcelain(struct
worktree *wt, int line_terminator)
  printf("branch %s%c", wt->head_ref, line_terminator);
  }

+ created =3D worktree_created_at(wt);
+ if (created)
+ printf("created %s%c",
+        show_date(created, 0, DATE_MODE(ISO8601_STRICT)),
+        line_terminator);
+
+ {
+ timestamp_t updated =3D worktree_updated_at(wt);
+ if (updated)
+ printf("updated %s%c",
+        show_date(updated, 0, DATE_MODE(ISO8601_STRICT)),
+        line_terminator);
+ }
+
+ description =3D worktree_description(wt);
+ if (description && *description) {
+ fputs("description ", stdout);
+ write_name_quoted(description, stdout, line_terminator);
+ }
+
  reason =3D worktree_lock_reason(wt);
  if (reason) {
  fputs("locked", stdout);
@@ -1034,6 +1084,32 @@ static void show_worktree(struct worktree *wt,
struct worktree_display *display,
  else if (reason)
  strbuf_addstr(&sb, " prunable");

+ if (show_created > 0 || verbose) {
+ timestamp_t created =3D worktree_created_at(wt);
+ struct date_mode mode =3D { .type =3D DATE_ISO8601, .local =3D 1 };
+ if (created)
+ strbuf_addf(&sb, "\n\tcreated: %s",
+     show_date(created, 0, mode));
+ else if (show_created > 0 && !is_main_worktree(wt))
+ strbuf_addstr(&sb, "\n\tcreated: unknown");
+ }
+
+ if (show_updated > 0 || verbose) {
+ timestamp_t updated =3D worktree_updated_at(wt);
+ struct date_mode mode =3D { .type =3D DATE_ISO8601, .local =3D 1 };
+ if (updated)
+ strbuf_addf(&sb, "\n\tupdated: %s",
+     show_date(updated, 0, mode));
+ else if (show_updated > 0 && !is_main_worktree(wt))
+ strbuf_addstr(&sb, "\n\tupdated: unknown");
+ }
+
+ if (show_description || verbose) {
+ const char *description =3D worktree_description(wt);
+ if (description && *description)
+ strbuf_addf(&sb, "\n\tdescription: %s", description);
+ }
+
  printf("%s\n", sb.buf);
  strbuf_release(&sb);
 }
@@ -1068,6 +1144,48 @@ static int pathcmp(const void *a_, const void *b_)
  return fspathcmp((*a)->path, (*b)->path);
 }

+static int createdcmp(const void *a_, const void *b_)
+{
+ struct worktree *const *a =3D a_;
+ struct worktree *const *b =3D b_;
+ timestamp_t ta =3D worktree_created_at(*a);
+ timestamp_t tb =3D worktree_created_at(*b);
+
+ /* Worktrees without a recorded timestamp (legacy) sort after those
with one. */
+ if (!ta && !tb)
+ return fspathcmp((*a)->path, (*b)->path);
+ if (!ta)
+ return 1;
+ if (!tb)
+ return -1;
+ if (ta < tb)
+ return -1;
+ if (ta > tb)
+ return 1;
+ return 0;
+}
+
+static int updatedcmp(const void *a_, const void *b_)
+{
+ struct worktree *const *a =3D a_;
+ struct worktree *const *b =3D b_;
+ timestamp_t ta =3D worktree_updated_at(*a);
+ timestamp_t tb =3D worktree_updated_at(*b);
+
+ /* Worktrees whose HEAD mtime can't be read sort after those that can. */
+ if (!ta && !tb)
+ return fspathcmp((*a)->path, (*b)->path);
+ if (!ta)
+ return 1;
+ if (!tb)
+ return -1;
+ if (ta < tb)
+ return -1;
+ if (ta > tb)
+ return 1;
+ return 0;
+}
+
 static void pathsort(struct worktree **wt)
 {
  int n =3D 0;
@@ -1078,11 +1196,45 @@ static void pathsort(struct worktree **wt)
  QSORT(wt, n, pathcmp);
 }

+static int sort_worktrees(struct worktree **wt, const char *key)
+{
+ int n =3D 0, reverse =3D 0;
+ struct worktree **p =3D wt;
+ int (*cmp)(const void *, const void *);
+
+ if (*key =3D=3D '-') {
+ reverse =3D 1;
+ key++;
+ }
+ if (!strcmp(key, "path"))
+ cmp =3D pathcmp;
+ else if (!strcmp(key, "created"))
+ cmp =3D createdcmp;
+ else if (!strcmp(key, "updated"))
+ cmp =3D updatedcmp;
+ else
+ return -1;
+
+ while (*p++)
+ n++;
+ QSORT(wt, n, cmp);
+ if (reverse) {
+ int i;
+ for (i =3D 0; i < n / 2; i++) {
+ struct worktree *tmp =3D wt[i];
+ wt[i] =3D wt[n - 1 - i];
+ wt[n - 1 - i] =3D tmp;
+ }
+ }
+ return 0;
+}
+
 static int list(int ac, const char **av, const char *prefix,
  struct repository *repo UNUSED)
 {
  int porcelain =3D 0;
  int line_terminator =3D '\n';
+ const char *sort_key =3D NULL;

  struct option options[] =3D {
  OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
@@ -1091,6 +1243,14 @@ static int list(int ac, const char **av, const
char *prefix,
  N_("add 'prunable' annotation to missing worktrees older than <time>")),
  OPT_SET_INT('z', NULL, &line_terminator,
      N_("terminate records with a NUL character"), '\0'),
+ OPT_BOOL(0, "show-created", &show_created,
+ N_("show worktree creation timestamps")),
+ OPT_BOOL(0, "show-updated", &show_updated,
+ N_("show worktree last-updated timestamps")),
+ OPT_BOOL(0, "show-description", &show_description,
+ N_("show worktree descriptions")),
+ OPT_STRING(0, "sort", &sort_key, N_("key"),
+    N_("sort worktrees by key (path, created, updated); prefix with -
to reverse")),
  OPT_END()
  };

@@ -1107,8 +1267,27 @@ static int list(int ac, const char **av, const
char *prefix,
  int path_maxwidth =3D 0, abbrev =3D DEFAULT_ABBREV, i;
  struct worktree_display *display =3D NULL;

- /* sort worktrees by path but keep main worktree at top */
- pathsort(worktrees + 1);
+ /* sort worktrees but keep main worktree at top */
+ if (sort_key) {
+ const char *bare_key =3D sort_key;
+ if (*bare_key =3D=3D '-')
+ bare_key++;
+ /*
+ * Sorting by a timestamp without showing it would
+ * leave the user guessing why the order is what it
+ * is, so opt in the matching display by default.
+ * An explicit --show-* / --no-show-* still wins.
+ */
+ if (!strcmp(bare_key, "created") && show_created < 0)
+ show_created =3D 1;
+ else if (!strcmp(bare_key, "updated") && show_updated < 0)
+ show_updated =3D 1;
+
+ if (sort_worktrees(worktrees + 1, sort_key))
+ die(_("unknown sort key '%s'"), sort_key);
+ } else {
+ pathsort(worktrees + 1);
+ }

  if (!porcelain)
  measure_widths(worktrees, &abbrev,
@@ -1200,6 +1379,32 @@ static int unlock_worktree(int ac, const char
**av, const char *prefix,
  return ret;
 }

+static int describe_worktree(int ac, const char **av, const char *prefix,
+      struct repository *repo UNUSED)
+{
+ struct option options[] =3D {
+ OPT_END()
+ };
+ struct worktree **worktrees, *wt;
+ int ret;
+
+ ac =3D parse_options(ac, av, prefix, options, git_worktree_describe_usage=
, 0);
+ if (ac < 1 || ac > 2)
+ usage_with_options(git_worktree_describe_usage, options);
+
+ worktrees =3D get_worktrees();
+ wt =3D find_worktree(worktrees, prefix, av[0]);
+ if (!wt)
+ die(_("'%s' is not a working tree"), av[0]);
+ if (is_main_worktree(wt))
+ die(_("The main working tree cannot be described"));
+
+ ret =3D set_worktree_description(wt, ac =3D=3D 2 ? av[1] : NULL);
+
+ free_worktrees(worktrees);
+ return ret;
+}
+
 static void validate_no_submodules(const struct worktree *wt)
 {
  struct index_state istate =3D INDEX_STATE_INIT(the_repository);
@@ -1469,6 +1674,7 @@ int cmd_worktree(int ac,
  parse_opt_subcommand_fn *fn =3D NULL;
  struct option options[] =3D {
  OPT_SUBCOMMAND("add", &fn, add),
+ OPT_SUBCOMMAND("describe", &fn, describe_worktree),
  OPT_SUBCOMMAND("prune", &fn, prune),
  OPT_SUBCOMMAND("list", &fn, list),
  OPT_SUBCOMMAND("lock", &fn, lock_worktree),
diff --git t/meson.build t/meson.build
index 2af8d01279..7b6e8435d7 100644
--- t/meson.build
+++ t/meson.build
@@ -308,6 +308,7 @@ integration_tests =3D [
   't2405-worktree-submodule.sh',
   't2406-worktree-repair.sh',
   't2407-worktree-heads.sh',
+  't2410-worktree-metadata.sh',
   't2500-untracked-overwriting.sh',
   't2501-cwd-empty.sh',
   't3000-ls-files-others.sh',
diff --git t/t2402-worktree-list.sh t/t2402-worktree-list.sh
index e0c6abd2f5..fb1f4b1d3c 100755
--- t/t2402-worktree-list.sh
+++ t/t2402-worktree-list.sh
@@ -71,7 +71,8 @@ test_expect_success '"list" all worktrees --porcelain' '
  echo "HEAD $(git rev-parse HEAD)" >>expect &&
  echo "detached" >>expect &&
  echo >>expect &&
- git worktree list --porcelain >actual &&
+ git worktree list --porcelain >actual.raw &&
+ grep -Ev "^(created|updated) " actual.raw >actual &&
  test_cmp expect actual
 '

@@ -86,7 +87,7 @@ test_expect_success '"list" all worktrees --porcelain -z'=
 '
  "$(git -C here rev-parse --show-toplevel)" \
  "$(git rev-parse HEAD)" >>expect &&
  git worktree list --porcelain -z >_actual &&
- nul_to_q <_actual >actual &&
+ nul_to_q <_actual | tr Q "\n" | grep -Ev "^(created|updated) " | tr
"\n" Q >actual &&
  test_cmp expect actual
 '

@@ -220,7 +221,7 @@ test_expect_success '"list" all worktrees from bare mai=
n' '
 '

 test_expect_success '"list" all worktrees --porcelain from bare main' '
- test_when_finished "rm -rf there actual expect && git -C bare1
worktree prune" &&
+ test_when_finished "rm -rf there actual actual.raw expect && git -C
bare1 worktree prune" &&
  git -C bare1 worktree add --detach ../there main &&
  echo "worktree $(pwd)/bare1" >expect &&
  echo "bare" >>expect &&
@@ -229,7 +230,8 @@ test_expect_success '"list" all worktrees
--porcelain from bare main' '
  echo "HEAD $(git -C there rev-parse HEAD)" >>expect &&
  echo "detached" >>expect &&
  echo >>expect &&
- git -C bare1 worktree list --porcelain >actual &&
+ git -C bare1 worktree list --porcelain >actual.raw &&
+ grep -Ev "^(created|updated) " actual.raw >actual &&
  test_cmp expect actual
 '

diff --git t/t2410-worktree-metadata.sh t/t2410-worktree-metadata.sh
new file mode 100755
index 0000000000..e1ecb1c1bf
--- /dev/null
+++ t/t2410-worktree-metadata.sh
@@ -0,0 +1,245 @@
+#!/bin/sh
+
+test_description=3D'git worktree creation timestamp and description metada=
ta'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+ test_commit init
+'
+
+test_expect_success 'add writes created file' '
+ test_when_finished "git worktree remove -f wt1 && git worktree prune" &&
+ git worktree add wt1 &&
+ test_path_is_file .git/worktrees/wt1/created &&
+ # contents should be a positive integer (unix timestamp)
+ created=3D$(cat .git/worktrees/wt1/created) &&
+ test "$created" -gt 0
+'
+
+test_expect_success 'add --description writes description file' '
+ test_when_finished "git worktree remove -f wt2 && git worktree prune" &&
+ git worktree add --description "investigating bug" wt2 &&
+ test_path_is_file .git/worktrees/wt2/description &&
+ echo "investigating bug" >expect &&
+ test_cmp expect .git/worktrees/wt2/description
+'
+
+test_expect_success 'add without --description does not create
description file' '
+ test_when_finished "git worktree remove -f wt3 && git worktree prune" &&
+ git worktree add wt3 &&
+ test_path_is_missing .git/worktrees/wt3/description
+'
+
+test_expect_success 'describe sets a description on an existing worktree' =
'
+ test_when_finished "git worktree remove -f wt4 && git worktree prune" &&
+ git worktree add wt4 &&
+ git worktree describe wt4 "later description" &&
+ echo "later description" >expect &&
+ test_cmp expect .git/worktrees/wt4/description
+'
+
+test_expect_success 'describe replaces an existing description' '
+ test_when_finished "git worktree remove -f wt5 && git worktree prune" &&
+ git worktree add --description "old" wt5 &&
+ git worktree describe wt5 "new" &&
+ echo "new" >expect &&
+ test_cmp expect .git/worktrees/wt5/description
+'
+
+test_expect_success 'describe with no text clears the description' '
+ test_when_finished "git worktree remove -f wt6 && git worktree prune" &&
+ git worktree add --description "to delete" wt6 &&
+ test_path_is_file .git/worktrees/wt6/description &&
+ git worktree describe wt6 &&
+ test_path_is_missing .git/worktrees/wt6/description
+'
+
+test_expect_success 'describe refuses to operate on the main worktree' '
+ test_must_fail git worktree describe . "should fail" 2>err &&
+ grep -i "main working tree" err
+'
+
+test_expect_success 'list --show-description displays description in
human output' '
+ test_when_finished "git worktree remove -f wt7 && git worktree prune" &&
+ git worktree add --description "release branch" wt7 &&
+ git worktree list --show-description >actual &&
+ grep "description: release branch" actual
+'
+
+test_expect_success 'list --show-created displays created timestamp' '
+ test_when_finished "git worktree remove -f wt8 && git worktree prune" &&
+ git worktree add wt8 &&
+ git worktree list --show-created >actual &&
+ grep "created: " actual
+'
+
+test_expect_success 'list --show-created shows unknown for legacy worktree=
s' '
+ test_when_finished "git worktree remove -f wt9 && git worktree prune" &&
+ git worktree add wt9 &&
+ rm .git/worktrees/wt9/created &&
+ git worktree list --show-created >actual &&
+ grep "created: unknown" actual
+'
+
+test_expect_success 'list --show-updated displays updated timestamp' '
+ test_when_finished "git worktree remove -f wt8u && git worktree prune" &&
+ git worktree add wt8u &&
+ git worktree list --show-updated >actual &&
+ grep "updated: " actual
+'
+
+test_expect_success 'list --porcelain always includes created,
updated, and description' '
+ test_when_finished "git worktree remove -f wtp && git worktree prune" &&
+ git worktree add --description "porcelain test" wtp &&
+ git worktree list --porcelain >actual &&
+ grep "^created " actual &&
+ grep "^updated " actual &&
+ grep "^description porcelain test" actual
+'
+
+test_expect_success 'list --sort=3Dcreated orders by creation time' '
+ test_when_finished "git worktree remove -f a && git worktree remove
-f b && git worktree remove -f c && git worktree prune" &&
+ git worktree add a &&
+ git worktree add b &&
+ git worktree add c &&
+ echo 1000 >.git/worktrees/a/created &&
+ echo 2000 >.git/worktrees/b/created &&
+ echo 3000 >.git/worktrees/c/created &&
+ git worktree list --sort=3Dcreated --porcelain >actual &&
+ grep "^worktree " actual | sed -n "2,4p" >linked &&
+ awk "NR=3D=3D1" linked | grep -q "/a$" &&
+ awk "NR=3D=3D2" linked | grep -q "/b$" &&
+ awk "NR=3D=3D3" linked | grep -q "/c$"
+'
+
+test_expect_success 'list --sort=3D-created reverses order' '
+ test_when_finished "git worktree remove -f a && git worktree remove
-f b && git worktree remove -f c && git worktree prune" &&
+ git worktree add a &&
+ git worktree add b &&
+ git worktree add c &&
+ echo 1000 >.git/worktrees/a/created &&
+ echo 2000 >.git/worktrees/b/created &&
+ echo 3000 >.git/worktrees/c/created &&
+ git worktree list --sort=3D-created --porcelain >actual &&
+ grep "^worktree " actual | sed -n "2,4p" >linked &&
+ awk "NR=3D=3D1" linked | grep -q "/c$" &&
+ awk "NR=3D=3D2" linked | grep -q "/b$" &&
+ awk "NR=3D=3D3" linked | grep -q "/a$"
+'
+
+test_expect_success 'list --sort=3Dcreated places legacy worktrees last' '
+ test_when_finished "git worktree remove -f early && git worktree
remove -f legacy && git worktree prune" &&
+ git worktree add early &&
+ echo 1000 >.git/worktrees/early/created &&
+ git worktree add legacy &&
+ rm .git/worktrees/legacy/created &&
+ git worktree list --sort=3Dcreated --porcelain >actual &&
+ grep "^worktree " actual | sed -n "2,3p" >linked &&
+ awk "NR=3D=3D1" linked | grep -q "/early$" &&
+ awk "NR=3D=3D2" linked | grep -q "/legacy$"
+'
+
+test_expect_success 'list --sort=3Dupdated orders by HEAD mtime' '
+ test_when_finished "git worktree remove -f u1 && git worktree remove
-f u2 && git worktree remove -f u3 && git worktree prune" &&
+ git worktree add u1 &&
+ git worktree add u2 &&
+ git worktree add u3 &&
+ # Force a known ordering: u2 oldest, u1 middle, u3 newest.
+ test-tool chmtime =3D1000 .git/worktrees/u2/HEAD &&
+ test-tool chmtime =3D2000 .git/worktrees/u1/HEAD &&
+ test-tool chmtime =3D3000 .git/worktrees/u3/HEAD &&
+ git worktree list --sort=3Dupdated --porcelain >actual &&
+ grep "^worktree " actual | sed -n "2,4p" >linked &&
+ awk "NR=3D=3D1" linked | grep -q "/u2$" &&
+ awk "NR=3D=3D2" linked | grep -q "/u1$" &&
+ awk "NR=3D=3D3" linked | grep -q "/u3$"
+'
+
+test_expect_success 'list --sort=3D-updated reverses order' '
+ test_when_finished "git worktree remove -f u1 && git worktree remove
-f u2 && git worktree remove -f u3 && git worktree prune" &&
+ git worktree add u1 &&
+ git worktree add u2 &&
+ git worktree add u3 &&
+ test-tool chmtime =3D1000 .git/worktrees/u2/HEAD &&
+ test-tool chmtime =3D2000 .git/worktrees/u1/HEAD &&
+ test-tool chmtime =3D3000 .git/worktrees/u3/HEAD &&
+ git worktree list --sort=3D-updated --porcelain >actual &&
+ grep "^worktree " actual | sed -n "2,4p" >linked &&
+ awk "NR=3D=3D1" linked | grep -q "/u3$" &&
+ awk "NR=3D=3D2" linked | grep -q "/u1$" &&
+ awk "NR=3D=3D3" linked | grep -q "/u2$"
+'
+
+test_expect_success 'list --sort=3Dcreated auto-shows created timestamp' '
+ test_when_finished "git worktree remove -f autoc && git worktree prune" &=
&
+ git worktree add autoc &&
+ git worktree list --sort=3Dcreated >actual &&
+ grep "created: " actual
+'
+
+test_expect_success 'list --sort=3D-created auto-shows created timestamp' =
'
+ test_when_finished "git worktree remove -f autocr && git worktree prune" =
&&
+ git worktree add autocr &&
+ git worktree list --sort=3D-created >actual &&
+ grep "created: " actual
+'
+
+test_expect_success 'list --sort=3Dupdated auto-shows updated timestamp' '
+ test_when_finished "git worktree remove -f autou && git worktree prune" &=
&
+ git worktree add autou &&
+ git worktree list --sort=3Dupdated >actual &&
+ grep "updated: " actual
+'
+
+test_expect_success 'list --sort=3D-updated auto-shows updated timestamp' =
'
+ test_when_finished "git worktree remove -f autour && git worktree prune" =
&&
+ git worktree add autour &&
+ git worktree list --sort=3D-updated >actual &&
+ grep "updated: " actual
+'
+
+test_expect_success 'list --sort=3Dpath does not auto-show timestamps' '
+ test_when_finished "git worktree remove -f autop && git worktree prune" &=
&
+ git worktree add autop &&
+ git worktree list --sort=3Dpath >actual &&
+ ! grep "created: " actual &&
+ ! grep "updated: " actual
+'
+
+test_expect_success 'list --sort with unknown key fails' '
+ test_must_fail git worktree list --sort=3Dbogus 2>err &&
+ grep -i "unknown sort key" err
+'
+
+test_expect_success 'list --sort=3Dupdated --no-show-updated suppresses
auto-show' '
+ test_when_finished "git worktree remove -f noshowu && git worktree prune"=
 &&
+ git worktree add noshowu &&
+ git worktree list --sort=3Dupdated --no-show-updated >actual &&
+ ! grep "updated: " actual
+'
+
+test_expect_success 'list --sort=3Dcreated --no-show-created suppresses
auto-show' '
+ test_when_finished "git worktree remove -f noshowc && git worktree prune"=
 &&
+ git worktree add noshowc &&
+ git worktree list --sort=3Dcreated --no-show-created >actual &&
+ ! grep "created: " actual
+'
+
+test_expect_success 'list --show-updated formats human output in
local timezone' '
+ test_when_finished "git worktree remove -f tz && git worktree prune" &&
+ git worktree add tz &&
+ # Pin HEAD mtime to a fixed unix time outside any DST transition
+ # so the rendered offset is deterministic in PST8PDT (-0700 in July).
+ test-tool chmtime =3D1500000000 .git/worktrees/tz/HEAD &&
+ TZ=3DPST8PDT git worktree list --show-updated >human &&
+ grep "updated: 2017-07-13 19:40:00 -0700" human &&
+ # Porcelain stays in UTC ISO-8601 strict form regardless of TZ.
+ TZ=3DPST8PDT git worktree list --porcelain >porcelain &&
+ grep "^updated 2017-07-14T02:40:00Z$" porcelain
+'
+
+test_done
diff --git worktree.c worktree.c
index 97eddc3916..4b019a532b 100644
--- worktree.c
+++ worktree.c
@@ -14,6 +14,8 @@
 #include "dir.h"
 #include "wt-status.h"
 #include "config.h"
+#include "date.h"
+#include "wrapper.h"

 void free_worktree(struct worktree *worktree)
 {
@@ -24,6 +26,7 @@ void free_worktree(struct worktree *worktree)
  free(worktree->head_ref);
  free(worktree->lock_reason);
  free(worktree->prune_reason);
+ free(worktree->description);
  free(worktree);
 }

@@ -324,6 +327,100 @@ const char *worktree_lock_reason(struct worktree *wt)
  return wt->lock_reason;
 }

+timestamp_t worktree_created_at(struct worktree *wt)
+{
+ if (is_main_worktree(wt))
+ return 0;
+
+ if (!wt->created_at_valid) {
+ struct strbuf path =3D STRBUF_INIT;
+ struct strbuf buf =3D STRBUF_INIT;
+
+ strbuf_addstr(&path, worktree_git_path(wt, "created"));
+ if (file_exists(path.buf) &&
+     strbuf_read_file(&buf, path.buf, 0) >=3D 0) {
+ char *end;
+ timestamp_t t;
+ strbuf_trim(&buf);
+ t =3D parse_timestamp(buf.buf, &end, 10);
+ if (end !=3D buf.buf && *end =3D=3D '\0')
+ wt->created_at =3D t;
+ }
+ wt->created_at_valid =3D 1;
+ strbuf_release(&path);
+ strbuf_release(&buf);
+ }
+
+ return wt->created_at;
+}
+
+timestamp_t worktree_updated_at(struct worktree *wt)
+{
+ struct stat st;
+ char *git_dir;
+ char *head_path;
+ timestamp_t result =3D 0;
+
+ if (is_main_worktree(wt))
+ return 0;
+
+ git_dir =3D get_worktree_git_dir(wt);
+ head_path =3D xstrfmt("%s/HEAD", git_dir);
+ if (!stat(head_path, &st))
+ result =3D (timestamp_t) st.st_mtime;
+ free(head_path);
+ free(git_dir);
+ return result;
+}
+
+const char *worktree_description(struct worktree *wt)
+{
+ if (is_main_worktree(wt))
+ return NULL;
+
+ if (!wt->description_valid) {
+ struct strbuf path =3D STRBUF_INIT;
+
+ strbuf_addstr(&path, worktree_git_path(wt, "description"));
+ if (file_exists(path.buf)) {
+ struct strbuf description =3D STRBUF_INIT;
+ if (strbuf_read_file(&description, path.buf, 0) < 0)
+ die_errno(_("failed to read '%s'"), path.buf);
+ strbuf_trim_trailing_newline(&description);
+ wt->description =3D strbuf_detach(&description, NULL);
+ } else
+ wt->description =3D NULL;
+ wt->description_valid =3D 1;
+ strbuf_release(&path);
+ }
+
+ return wt->description;
+}
+
+int set_worktree_description(struct worktree *wt, const char *text)
+{
+ char *path;
+ int ret =3D 0;
+
+ if (is_main_worktree(wt))
+ return error(_("cannot set description on the main worktree"));
+
+ path =3D repo_common_path(wt->repo, "worktrees/%s/description", wt->id);
+ if (!text || !*text) {
+ if (file_exists(path) && unlink(path))
+ ret =3D error_errno(_("failed to remove '%s'"), path);
+ } else {
+ write_file(path, "%s", text);
+ }
+
+ /* invalidate cache so a follow-up worktree_description() re-reads */
+ FREE_AND_NULL(wt->description);
+ wt->description_valid =3D 0;
+
+ free(path);
+ return ret;
+}
+
 const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire)
 {
  struct strbuf reason =3D STRBUF_INIT;
diff --git worktree.h worktree.h
index 1075409f9a..2568830237 100644
--- worktree.h
+++ worktree.h
@@ -13,12 +13,16 @@ struct worktree {
  char *head_ref; /* NULL if HEAD is broken or detached */
  char *lock_reason; /* private - use worktree_lock_reason */
  char *prune_reason;     /* private - use worktree_prune_reason */
+ char *description; /* private - use worktree_description */
  struct object_id head_oid;
+ timestamp_t created_at; /* private - use worktree_created_at; 0 if unknow=
n */
  int is_detached;
  int is_bare;
  int is_current; /* does `path` match `repo->worktree` */
  int lock_reason_valid; /* private */
  int prune_reason_valid; /* private */
+ int description_valid; /* private */
+ int created_at_valid;  /* private */
 };

 /*
@@ -96,6 +100,34 @@ int is_main_worktree(const struct worktree *wt);
  */
 const char *worktree_lock_reason(struct worktree *wt);

+/*
+ * Return the worktree's recorded creation timestamp, or 0 if no timestamp
+ * was recorded (e.g. a worktree created before this metadata existed, or
+ * the main worktree which never carries the file).
+ */
+timestamp_t worktree_created_at(struct worktree *wt);
+
+/*
+ * Return the modification time of the worktree's HEAD file as an
+ * approximation of "when was this worktree last touched by Git" (checkout=
,
+ * commit, reset, rebase, etc.). Returns 0 for the main worktree, and 0 if
+ * HEAD cannot be stat'd.
+ */
+timestamp_t worktree_updated_at(struct worktree *wt);
+
+/*
+ * Return the user-supplied description for the given worktree, or NULL
+ * if none was set.
+ */
+const char *worktree_description(struct worktree *wt);
+
+/*
+ * Write or replace the worktree's description. Pass NULL or "" to delete
+ * the description. Returns 0 on success, -1 on failure. Not valid for the
+ * main worktree.
+ */
+int set_worktree_description(struct worktree *wt, const char *text);
+
 /*
  * Return the reason string if the given worktree should be pruned, otherw=
ise
  * NULL if it should not be pruned. `expire` defines a grace period to pru=
ne

On Fri, Jun 5, 2026 at 9:57=E2=80=AFAM Chris Torek <chris.torek@gmail.com> =
wrote:
>
> On Fri, Jun 5, 2026 at 8:31=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
> > Isn't "what is the worktree for" a property of the branch that's checke=
d
> > out, not the worktree itself?
>
> I don't think it is.
>
> A lot of things within Git have, shall way say, "less than optimal"
> names, with "branch" (with at least three different meanings),
> "HEAD", and "index" being examples of this. (This is just an
> observation, not a complaint: we know from studies that
> oddities in names don't matter that much after a bit of usage
> of some system. They're just minor stumbling blocks when
> getting started.)
>
> Work-tree or working tree is not one of them, though. It's
> concise and pointed: a working tree is where you do work.
>
> As such, the *purpose* of a working tree is exactly as general
> as the purpose of doing work! That's a wide-open set.
>
> Git's internal constraint, of requiring each working tree that
> is using a branch name to have a unique-to-that-tree branch
> name, is a property specific to branch names, not to branching
> in general (an example of the ambiguity of "branch" here).
> And of course, as you note, any working tree can be on
> a detached HEAD.
>
> Exactly what properties any given working tree should
> have, and the weird entanglement Git has between the
> "primary" working tree (the one created by any non-bare
> clone) and all "secondary" working trees, is a mere (ahem)
> matter of implementation. Descriptions, creation times,
> modification times, etc., are all potentially useful.
>
> I think, had Git initially made all repositories effectively
> bare, with separate working trees added later, this might
> all be a little clearer, but of course that ship sailed,
> crossed *all* the oceans, sank, was refloated and refitted,
> and sailed for another decade already. :-)
>
> Chris



--=20
Norbert Kiesel | Staff Software Engineer | Credit Karma
norbert.kiesel@creditkarma.com | www.creditkarma.com

This email may contain confidential and privileged information. Any
review, use, distribution, or disclosure by anyone other than the
intended recipient(s) is prohibited. If you are not the intended
recipient, please contact the sender by reply email and delete all
copies of this message.
