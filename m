Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3AF81F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbdGaUSP (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:18:15 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33086 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdGaUSO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:18:14 -0400
Received: by mail-io0-f196.google.com with SMTP id q64so89818ioi.0
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 13:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=y+pvMW0bKeb/4uBLBvq7diWb8fS/z5JpkZ5U1TCAnHQ=;
        b=RMvt0+VpXWmFwTQEWEVOSJGttCxU0OSJydcysmzKWYYYMinAvqS8iDCp/QXECINzxY
         dd+tNLuawtLPOPww4sqe9OiT8xve4F/C65mWx48pLjbOQw+kHsCpM6ef5g8igoRK4AfJ
         eSbpgqJ8Y4QIAgzUS6szO1+K8QXrvkTKyns/MhU+TTd4RWiu6ViZcVXnMNkYIZuB6WR8
         8lO2aQGhyzVdzvZyYewbogv9Q370INE+vNjGZ3SLT6Mqgkh3x1GMZPIYFQTB4T93LLTr
         t4NH3rODa/SxJS0/5Lwv1RbwtyNWW5NUPU0wPB6TywuFrC+zY3JCXjCQxXUC2nPdERbg
         M0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=y+pvMW0bKeb/4uBLBvq7diWb8fS/z5JpkZ5U1TCAnHQ=;
        b=I4ROC5GX7vJ6+1xOdzs6E/clF4PucsLB+yxiY8KzC/uEKU34hX3lRtPSyoAbJ0m+LB
         MXZKCT97r0l3/Vp2wDkRjvvySQftnO8Ult57aI8qee5DZKvudBsW3rHZnPWcxrd9ao1X
         O8mfqG8uIrDbutPV0kPB2C6K/MQJF9t1ClQWL+loPcC5bW2vhu8J/aMRD4f0AKDjD7FZ
         mZ04JdXEiCtUyx26hC07QaMXVuMWTqTfVN88lqfDzCyAjtB6uTkEPeaZZW21OaEYBU9z
         LMNC27dJr1Tid2jhAZ1Lp8O6bsCpTkc/5jOhSO+Dk79bJEfKwBJGjh9zdF1hsgn7em7f
         noeA==
X-Gm-Message-State: AIVw112W1ADnYcBlbll7aEwrNyJxyo+y8VdBcKmfqZoE7pnVKG+FRcy+
        mW7n+UvRkioWuIC/uDNDAekO7ufBHw==
X-Received: by 10.107.178.200 with SMTP id b191mr19880171iof.68.1501532293415;
 Mon, 31 Jul 2017 13:18:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.167.139 with HTTP; Mon, 31 Jul 2017 13:17:52 -0700 (PDT)
In-Reply-To: <20170730232427.vrqrrhlsap55ax7t@genre.crustytoothpaste.net>
References: <20170728171817.21458-1-sbeller@google.com> <20170728171817.21458-3-sbeller@google.com>
 <xmqq379gmco6.fsf@gitster.mtv.corp.google.com> <20170729175833.4idan3befldn5vgp@genre.crustytoothpaste.net>
 <xmqqini9k4cx.fsf@gitster.mtv.corp.google.com> <20170730230019.ch74ska6wgbrh7ql@genre.crustytoothpaste.net>
 <20170730232427.vrqrrhlsap55ax7t@genre.crustytoothpaste.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 31 Jul 2017 22:17:52 +0200
Message-ID: <CACBZZX43JFOAOTffWVEMT1fPuzAiZnYi4JoE55QWquZ4kLA2Hg@mail.gmail.com>
Subject: Re: [PATCH 2/2] t6500: mark tests as SHA1 reliant
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2017 at 1:24 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sun, Jul 30, 2017 at 11:00:19PM +0000, brian m. carlson wrote:
>> Yes, basically, but a bit more generally.  There will always be cases in
>> which we need to specify an object ID or an arbitrary string and the
>> behavior will need to vary based on the hash.  That can be something
>> like, in this case, the two blob contents that would have the similar
>> prefix.
>>
>> So in this case, we pass the helper the string "263 410" and get back a
>> value for either the hacked SHA-1 hash or the SHA-256 or whatever we're
>> using.
>
> I realize this was worded poorly.  So for my example, in this case, we'd
> do:
>
> test-helper-hash-string "263 410"
>
> For SHA-1, we'd get "263 410".  For SHA-256, we'd get "313 481" (which,
> as SHA-256 blobs, both start with "17" in their hex representation).
> Presumably we'd read some environment variable to determine the proper
> value.

I've been mostly out of the loop on this hash transition plan, but
don't we expect to be compiling a git that knows about both SHA-1 and
whatever the $newhash is? If so it seems better to just test all N
hashes we have:

    test_expect_success_hash $desc_description '
        hash_value=$(test-helper-hash-string $CURRENT_HASH)
        ....
    '

Then test_expect_success_hash would run N times for the N hashes we have.

This would obviously be slightly more hassle to write & convert, but I
think it would be worth it, particularly with something like Travis
where we can test all hashes, instead of being in some mode where we
fragment on all of hashes/gettext poison and whatever other
compilation option we have that really requires compiling a new git
version...
