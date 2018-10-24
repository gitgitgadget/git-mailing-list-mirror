Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83EE61F453
	for <e@80x24.org>; Wed, 24 Oct 2018 06:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeJXPYR (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 11:24:17 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:38884 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeJXPYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 11:24:16 -0400
Received: by mail-ed1-f46.google.com with SMTP id c1-v6so3961322ede.5
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 23:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=yPufOWESfCFE0fZrbvw/bvw8spcqa/jkBn4VUWDqFFY=;
        b=RhXcGVU5YHlx8bmdSHQAQSa50scIgs0prnnfHtasRdKQtpnGBbC+uF3Rz8IhtfFHmU
         +PffdTSmPmzBvuQJ3Xmn6g2xv097N9fzkPLxKopn9d07Sr05RlzeoJavrSkEvFKxUy6t
         i8jd8lPAcbpTzuU2E2gMCe4BFT1FPdvrvU/rldYF1WtJBmcrkl4M1ZRSfkfyb07Cbgrs
         HZlBA6OwYcTlQdDoIqz15PbEoysC+Oq7LPU/6fJDSi/8dul0XDA6VUcxMDSeeCXL0lWz
         NK/+gshcLa210ZIny+ZLZPFtNh4nmQqsTtvONAI45xuMVt+6ZUtb3u8lJUJw9D4rGddK
         KKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=yPufOWESfCFE0fZrbvw/bvw8spcqa/jkBn4VUWDqFFY=;
        b=KuuvnnlnbcPmDl/nnHw7kOmfD6jzq4Y97bCq1RLtilb22VlnrMceU3MDB4sUQPXXmE
         lq6KLwEjpdyRA87h6ntFMOL4hxS28qjVuuWUzfUHWFkUwDUcp7CsKLzy1HTIvht6QzMi
         RmNricLcV84CH6jm/Pc0GdJrBqaJHq4ErqviiB6Xh4ifsZKX7cVhAVMWNPsWp7HcFBWZ
         T9dURAuUuU1eWeauTDusGMtfxsg2GFtsgQNlKkBeKpMWrgCqdwNovv5S2PAyq9PjcaQP
         Z40P0Gt6IMLcFS3kyn5RwDfUtNS8xqYIzAJgKU1fuPZ8l2p6RhVSABaSLYqeHocf6m89
         8+rg==
X-Gm-Message-State: AGRZ1gIXWftGIbeZ4Tpua0nyKbwyrJkdlu3Ek0PswxE6KTfePB+nxVYy
        VIhXc0y3qXeB/knel1XZopU5k57ykheURnIcoRZBxA==
X-Google-Smtp-Source: AJdET5eaIInBsBX7LnT94yhu9vGFhffVczfV4wowMwRU5fEvBRM8nnPxiNq7ailk0Gja9K+RnqOcYjnXaVKVaMF8vvc=
X-Received: by 2002:a50:f4c3:: with SMTP id v3-v6mr9427246edm.223.1540364249970;
 Tue, 23 Oct 2018 23:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAGshahkvn3fcyuqtD-WQE9tn+7rSad84+mtA_cfkz+t42xqPdw@mail.gmail.com>
 <20181023230324.GC6119@genre.crustytoothpaste.net>
In-Reply-To: <20181023230324.GC6119@genre.crustytoothpaste.net>
From:   Tommi Vainikainen <tvainika@gmail.com>
Date:   Wed, 24 Oct 2018 09:57:18 +0300
Message-ID: <CAGshahk7pY4rW5SQu73AdHMmxsbDCo5UP5LGF67FQYBws492TA@mail.gmail.com>
Subject: Re: git pull defaults for recursesubmodules
To:     sandals@crustytoothpaste.net, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f1db6e0578f3ff8d"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000f1db6e0578f3ff8d
Content-Type: text/plain; charset="UTF-8"

ke 24. lokak. 2018 klo 2.03 brian m. carlson
(sandals@crustytoothpaste.net) kirjoitti:
> You have an extra '1" at the end of this line.
> Also, missing sign-off.  See Documentation/SubmittingPatches.

After reading SubmittingPatches I didn't find if I should now send a
fresh patch with
changes squashed together or new commits appended after first commit in that
patch. Patch is updated accordingly as fresh patch.

> Can we have a test that --no-recurse-submodules overrides
> fetch.recurseSubmodules?

Attached (sorry about that, I've no access now to more convenient mail
setup) is refreshed
patch which also tests that. I included it in same patch to follow
style of other tests
in t5572-pull-submodule.

-- 
Tommi Vainikainen

--000000000000f1db6e0578f3ff8d
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-pull-obey-fetch.recurseSubmodules-when-fetching.patch"
Content-Disposition: attachment; 
	filename="0001-pull-obey-fetch.recurseSubmodules-when-fetching.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jnmsww2a0>
X-Attachment-Id: f_jnmsww2a0

RnJvbSA1ZDRiNDk1ZjdjNjhhMmU5OTMxNGZlZjkwZTUzOGUwZDQ0ZWMxMDU2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUb21taSBWYWluaWthaW5lbiA8dGh2QGlraS5maT4KRGF0ZTog
V2VkLCAyNCBPY3QgMjAxOCAwOTowNjo1NCArMDMwMApTdWJqZWN0OiBbUEFUQ0hdIHB1bGw6IG9i
ZXkgZmV0Y2gucmVjdXJzZVN1Ym1vZHVsZXMgd2hlbiBmZXRjaGluZwoKImdpdCBwdWxsIiBub3cg
dXNlcyBzYW1lIHJlY3Vyc2Utc3VibW9kdWxlcyBjb25maWcgZm9yIGZldGNoaW5nIGFzICJnaXQK
ZmV0Y2giIGJ5IGRlZmF1bHQgaWYgbm90IG92ZXJyaWRkZW4gZnJvbSBjb21tYW5kIGxpbmUuCgpU
aGUgY29tbWFuZCBsaW5lIGFyZyAtLXJlY3Vyc2Utc3VibW9kdWxlcz1ubyBvdmVycmlkZXMKZmV0
Y2gucmVjdXJzZVN1Ym1vZHVsZXMgY29uZmlndXJhdGlvbi4KClNpZ25lZC1vZmYtYnk6IFRvbW1p
IFZhaW5pa2FpbmVuIDx0aHZAaWtpLmZpPgotLS0KIGJ1aWx0aW4vcHVsbC5jICAgICAgICAgICAg
fCAgMyArKysKIHQvdDU1NzItcHVsbC1zdWJtb2R1bGUuc2ggfCAxMyArKysrKysrKysrKysrCiAy
IGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9idWlsdGluL3B1
bGwuYyBiL2J1aWx0aW4vcHVsbC5jCmluZGV4IDY4MWMxMjdhMDcuLmJiNTFjYjUzMWQgMTAwNjQ0
Ci0tLSBhL2J1aWx0aW4vcHVsbC5jCisrKyBiL2J1aWx0aW4vcHVsbC5jCkBAIC0zNDYsNiArMzQ2
LDkgQEAgc3RhdGljIGludCBnaXRfcHVsbF9jb25maWcoY29uc3QgY2hhciAqdmFyLCBjb25zdCBj
aGFyICp2YWx1ZSwgdm9pZCAqY2IpCiAJCXJlY3Vyc2Vfc3VibW9kdWxlcyA9IGdpdF9jb25maWdf
Ym9vbCh2YXIsIHZhbHVlKSA/CiAJCQlSRUNVUlNFX1NVQk1PRFVMRVNfT04gOiBSRUNVUlNFX1NV
Qk1PRFVMRVNfT0ZGOwogCQlyZXR1cm4gMDsKKwl9IGVsc2UgaWYgKCFzdHJjbXAodmFyLCAiZmV0
Y2gucmVjdXJzZXN1Ym1vZHVsZXMiKSkgeworCQlyZWN1cnNlX3N1Ym1vZHVsZXMgPSBwYXJzZV9m
ZXRjaF9yZWN1cnNlX3N1Ym1vZHVsZXNfYXJnKHZhciwgdmFsdWUpOworCQlyZXR1cm4gMDsKIAl9
CiAJcmV0dXJuIGdpdF9kZWZhdWx0X2NvbmZpZyh2YXIsIHZhbHVlLCBjYik7CiB9CmRpZmYgLS1n
aXQgYS90L3Q1NTcyLXB1bGwtc3VibW9kdWxlLnNoIGIvdC90NTU3Mi1wdWxsLXN1Ym1vZHVsZS5z
aAppbmRleCBmOTE2NzI5YTEyLi42NmM0NzlhMTM1IDEwMDc1NQotLS0gYS90L3Q1NTcyLXB1bGwt
c3VibW9kdWxlLnNoCisrKyBiL3QvdDU1NzItcHVsbC1zdWJtb2R1bGUuc2gKQEAgLTc1LDYgKzc1
LDE5IEBAIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgInN1Ym1vZHVsZS5yZWN1cnNlIG9wdGlvbiB0cmln
Z2VycyByZWN1cnNpdmUgcHVsbCIgJwogCXRlc3RfcGF0aF9pc19maWxlIHN1cGVyL3N1Yi9tZXJn
ZV9zdHJhdGVneV8yLnQKICcKIAordGVzdF9leHBlY3Rfc3VjY2VzcyAiZmV0Y2gucmVjdXJzZVN1
Ym1vZHVsZXM9dHJ1ZSB0cmlnZ2VycyByZWN1cnNpdmUgcHVsbCIgJworCXRlc3RfY29tbWl0IC1D
IGNoaWxkIGZldGNoX3JlY3Vyc2Vfc3VibW9kdWxlcyAmJgorCWdpdCAtQyBwYXJlbnQgc3VibW9k
dWxlIHVwZGF0ZSAtLXJlbW90ZSAmJgorCWdpdCAtQyBwYXJlbnQgYWRkIHN1YiAmJgorCWdpdCAt
QyBwYXJlbnQgY29tbWl0IC1tICJ1cGRhdGUgc3VibW9kdWxlIiAmJgorCisJZ2l0IC1DIHN1cGVy
IGNvbmZpZyBmZXRjaC5yZWN1cnNlU3VibW9kdWxlcyB0cnVlICYmCisJZ2l0IC1DIHN1cGVyIHB1
bGwgLS1yZWN1cnNlLXN1Ym1vZHVsZXM9bm8gLS1uby1yZWJhc2UgJiYKKwl0ZXN0X3BhdGhfaXNf
bWlzc2luZyBzdXBlci9zdWIvZmV0Y2hfcmVjdXJzZV9zdWJtb2R1bGVzLnQgJiYKKwlnaXQgLUMg
c3VwZXIgcHVsbCAtLW5vLXJlYmFzZSAmJgorCXRlc3RfcGF0aF9pc19maWxlIHN1cGVyL3N1Yi9m
ZXRjaF9yZWN1cnNlX3N1Ym1vZHVsZXMudAorJworCiB0ZXN0X2V4cGVjdF9zdWNjZXNzICIgLS1b
bm8tXXJlY3Vyc2Utc3VibW9kdWxlIGFuZCBzdWJtb2R1bGUucmVjdXJzZSIgJwogCXRlc3RfY29t
bWl0IC1DIGNoaWxkIG1lcmdlX3N0cmF0ZWd5XzMgJiYKIAlnaXQgLUMgcGFyZW50IHN1Ym1vZHVs
ZSB1cGRhdGUgLS1yZW1vdGUgJiYKLS0gCjIuMTkuMQoK
--000000000000f1db6e0578f3ff8d--
