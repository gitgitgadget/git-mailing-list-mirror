Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0701620AC5
	for <e@80x24.org>; Tue, 24 Jan 2017 10:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750882AbdAXKE0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 05:04:26 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37642 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdAXKEY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 05:04:24 -0500
Received: by mail-wm0-f50.google.com with SMTP id c206so200395436wme.0
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 02:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2bTfj2IzBB5FC63plFfSmO1oGJ6Q7hEwjU0oE0zhNYA=;
        b=IPuAcXXSy2JqIBoxZ9fWX0dm6DKK26z85J8o7jOC1cfs/gdhlsUXGAMBx8UwGjjZMb
         72EYMtff+CZthBIX5PMSoKes6ANuE5kXcxGPt6PxEu+2b1CyVMCuw9CInJ3tD64MiAyi
         FrObh+/e9nON9UqkBZhyjS0UvzVA1Xe2ET7BT/RqU+Xw7+5aLVbV5HfkNWYWkV7nnY4q
         qbhdBwBiEAz9uSFDfx4qasDgxl6GoFnjtez5XulMhl0lwGTYowcd+6aDZO6Q5euVUVhr
         gX8/asPbeJKO8ZP0jqi0beiiiHCqyd7iP5forxUZf1rVZpy8O27ijxOdIHBKSlFQlusT
         wKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2bTfj2IzBB5FC63plFfSmO1oGJ6Q7hEwjU0oE0zhNYA=;
        b=m+tIsptAiDD/ZwD9qsR8B5rAMKjYfzB9It7e6mS4vFLUnV9I81igIQJrNSUzEhGGIJ
         o/IlxD1BdttPGZxoNLzGyaOjGPjKPr8xIX+goxHfaz3OKKjMiw04VIGdc83NzvwYRaHC
         t1xZMDO/JYidSZv/4ZSmO/lj87r3z51TkewTI2+0wdPWrnRsxx4IvoZ7UWV+ZCfFhcJD
         2aZWcqQtRf2YapuhlwoMY7h85ttHamxLSjJhjFx8A1CKz2iR9RfXnumwAW/FAcFvD+Ue
         qr2mVeALMY4hL5N0N3qyGTdY+Y1VsPC5Hf7iwq0AJX7Q2i6ngtYET+ikVg/uXXaSpOZi
         2TAg==
X-Gm-Message-State: AIkVDXKW7wZmKV2Lg7ePj0Vnu7rIqM0bucjWKdXpeKI0sjiLY/xfjc+fDRFgc/VSjSjYXg==
X-Received: by 10.28.23.66 with SMTP id 63mr17881821wmx.46.1485252263178;
        Tue, 24 Jan 2017 02:04:23 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB584B.dip0.t-ipconnect.de. [93.219.88.75])
        by smtp.gmail.com with ESMTPSA id o42sm19082835wrb.18.2017.01.24.02.04.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Jan 2017 02:04:22 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Jan 2017, #04; Mon, 23)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqo9yxpaxk.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 24 Jan 2017 11:04:21 +0100
Cc:     git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0D956B23-E655-4C28-A205-14CCC0A7DEA2@gmail.com>
References: <xmqqo9yxpaxk.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 24 Jan 2017, at 01:18, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> * jk/fsck-connectivity-check-fix (2017-01-17) 6 commits
>  (merged to 'next' on 2017-01-23 at e8e9b76b84)
> + fsck: check HAS_OBJ more consistently
> + fsck: do not fallback "git fsck <bogus>" to "git fsck"
> + fsck: tighten error-checks of "git fsck <head>"
> + fsck: prepare dummy objects for --connectivity-check
> + fsck: report trees as dangling
> + t1450: clean up sub-objects in duplicate-entry test
>=20
> "git fsck --connectivity-check" was not working at all.
>=20
> Will merge to 'master'.

"fsck: prepare dummy objects for --connectivity-check" seems to
make t1450-fsck.sh fail on macOS with TravisCI:

Initialized empty Git repository in /Users/travis/build/git/git/t/trash =
directory.t1450-fsck/connectivity-only/.git/
[master (root-commit) 86520b7] empty
 Author: A U Thor <author@example.com>
 2 files changed, 1 insertion(+)
 create mode 100644 empty
 create mode 100644 empty.t
override r--r--r--  travis/staff for =
.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391? (y/n [n]) not =
overwritten
dangling blob c21c9352f7526e9576892a6631e0e8cf1fccd34d
test_must_fail: command succeeded: git fsck --strict
not ok 58 - fsck --connectivity-only

More test output: https://travis-ci.org/git/git/jobs/194663620

For some reason I am not able to replicate that behavior on my local
macOS machine. I found the commit using bisect on TravisCI:
https://api.travis-ci.org/jobs/194746454/log.txt?deansi=3Dtrue

Any idea what might be wrong?

- Lars=
