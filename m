Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDF9A202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 16:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932299AbdGKQD3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 12:03:29 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35090 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbdGKQD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 12:03:28 -0400
Received: by mail-pf0-f195.google.com with SMTP id q85so445921pfq.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 09:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=f/+QGclLPksz8I7XEZK0Lrqchqy1EBoII5QJywAm3fA=;
        b=KpFb77sN1z4Q32OlCkIExcfWC5WqzS5jaMvlSuu4IZUn/oBqOtyi+fwiDZi3HkOfOC
         MCDX9yqFtBmYYFjdD9JxGc9DJU+qb3BLLxG8yxESfXQFyMFyV9qpltmP8BrddoodaPjU
         a3wBu7AnUWe3M3vF7jsLI3jJSy5TpTPXhCV4WmRAo7ysxSMFd1gIBZ30GbtEoreh4lnL
         ozy56DvMiJ3tDmjWalKyWifDsPbKaEs3NWhkLYjOi3sYjBkX8dy8dwH1FgKmdjzccFQZ
         KVP3F3C7nHbTp3xOgBienWWl2glr5qfo77NfHIi6w6nuLV0hYCR/M2ZCk1pvudNRBQ0d
         JXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=f/+QGclLPksz8I7XEZK0Lrqchqy1EBoII5QJywAm3fA=;
        b=NGP4ee2mMT3LL+AKyHdKv8N1Xwn3kT3jmx2kc3otJRQPMN4sLf30PHcTf7czYECTM3
         /mdtmBJOI13IyVaJSenVfIRC8pslsLxPmu4jGhhWh169LePo4Vnj0B3rBVduwjp9FiLu
         TqcKlB7U236r3y2J9nUFX91/GhZChfCWVPbBa6NX/I6SNZ2679XD7GXr9bJRHzzadeNI
         KD+KQQTo/PETuAXwHNedsCCSwBDhz6ckM4C7c4CitcbEqCR0t5RSJaPde2T78TlQm+T3
         9jzm5RJjVd/+e2N5EOrIBVk/HgP75kyY/e2yZTj3QJL2iD+BCTsVSsebiHXiPINLKH7y
         0KQA==
X-Gm-Message-State: AIVw113LEvoNNkySfZspyI7ooysxJVnJlVrNKiS2Zglf5pil47/9NROT
        ZdrewZNjo+/Y8w==
X-Received: by 10.98.77.6 with SMTP id a6mr51597419pfb.221.1499789007244;
        Tue, 11 Jul 2017 09:03:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fdda:b931:7ea7:8e3c])
        by smtp.gmail.com with ESMTPSA id e131sm574035pgc.64.2017.07.11.09.03.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 09:03:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] hook: add a simple first example
References: <xmqqinj4ayqb.fsf@gitster.mtv.corp.google.com>
        <20170710141744.8541-1-kaarticsivaraam91196@gmail.com>
        <20170710141744.8541-4-kaarticsivaraam91196@gmail.com>
        <xmqqbmos5add.fsf@gitster.mtv.corp.google.com>
        <1499779787.1740.5.camel@gmail.com>
Date:   Tue, 11 Jul 2017 09:03:24 -0700
In-Reply-To: <1499779787.1740.5.camel@gmail.com> (Kaartic Sivaraam's message
        of "Tue, 11 Jul 2017 18:59:47 +0530")
Message-ID: <xmqqtw2j2c6r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> I'm was trying to ask, "Is there any way to change the second example
> (diff --name-status) to make it work with "commit --amend" so that it
> could be uncommented by default ?"

But does it even be useful to enable it?  The commented out "git
status" output already lists the modified paths, so I do not think
anything is gained by adding 'diff --cached --name-status' there.
