Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FC861F42D
	for <e@80x24.org>; Sun, 27 May 2018 15:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032787AbeE0PeW (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 11:34:22 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37723 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032775AbeE0PeV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 11:34:21 -0400
Received: by mail-pl0-f68.google.com with SMTP id w19-v6so5793388plq.4
        for <git@vger.kernel.org>; Sun, 27 May 2018 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sTBiMOCINAE/k3YcKJfg3qazwFllNTvJKhpyvawSmJk=;
        b=ORZfW2s35yVbA48YxeEHW6VcHnAG5cw0Qe5zo3c8TPBTz3OlP4e6naVWhIBNLaO+ID
         UkWa7k3LuDhfbNZdYCFuqKkxnsl+cgJJvJK/L0+0q1mPn9L4sgln7NMmJ7krKm5iqS+S
         MmT0hFwsT3jL+9g3vnGODpZskvuS1ee8sQCWRZSsFH/xNucjA/7KjcqsEXib4VpaSF6b
         v7PCWjkSCDTgbjBogKhSh4thgLWG0LwYJ+WFzCyfVNVNcEneTZGpl4eEk2RUPgKODBdK
         PTKy/FDA0TVxSO7cFrGEhijnZwqSmAE5xEFQoYQ6o9SrxvblnjZKcDRjux8xYAqeTwQV
         pvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sTBiMOCINAE/k3YcKJfg3qazwFllNTvJKhpyvawSmJk=;
        b=RcWtbThfnqvyiSsRESqq5FLYJvc/VhJRyWKo0OcbNIEcox0u9I2duW2QCz/ZeZw+Lw
         Ghn7fwONWXiJ8SD+htDP+qvlljEw0j8v+rmWVCv4VmxkeYc/+uhK8VYsDENNh+3uuUzM
         gYfBRC2Qc1VDkWzlALsIK2ehENxF0onZzYQLLkftph72WPII3Ia8K6VadLJOZOWBEsAX
         d5O98+DpBDmwEP7rxI4LQeIYplUli2vKbnMrJuPmfdE0aLVi9nuyy89ofpM2SDrayz0l
         tK8FxEFQLLLifCbV4VmjqJ77NNB4XvAyPtpAALOh2HDaw2gpJwL2ibHD3BJmbQjjPvJa
         30Ig==
X-Gm-Message-State: ALKqPwcW6+sJNWWISlHOIOomdvoevSjnUionVzJbl/+kfFIBLQ76Xohc
        L1+CynP/HtMYGBXkfwH26kA=
X-Google-Smtp-Source: AB8JxZo6YBOH1ibsyfVxFOZi8DDuD1MCDtBI/hgKCBNhltYJhYLAxKKpFIQrQU4ledOdb7ygRt5XCQ==
X-Received: by 2002:a17:902:284b:: with SMTP id e69-v6mr9998736plb.240.1527435260777;
        Sun, 27 May 2018 08:34:20 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h1-v6sm49267782pfg.135.2018.05.27.08.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 May 2018 08:34:20 -0700 (PDT)
Date:   Sun, 27 May 2018 08:34:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] README: note git-security@googlegroups.com
Message-ID: <20180527153418.GG207547@aiede.svl.corp.google.com>
References: <20180527140433.32277-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180527140433.32277-1-t.gummerer@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer wrote:

> Add a mention of the security mailing list to the README.
> 2caa7b8d27 ("git manpage: note git-security@googlegroups.com",
> 2018-03-08) already added it to the man page, but I suspect that for
> many developers, such as myself, the README would be the first place
> to go looking for it.
>
> Use the same wording as we already have on the git-scm.com website and
> in the man page.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  README.md | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

> 2caa7b8d27 ("git manpage: note git-security@googlegroups.com",
> 2018-03-08) also mentions SubmittingPatches, but I think people are
> much more likely to submit a report of a security issue first, rather
> than sending a patch, for which I think the README is more useful.

I don't see a mention of SubmittingPatches in "git show 2caa7b8d27"
output.  git help git tells me:

	Report bugs to the Git mailing list <git@vger.kernel.org>
	where the development and maintenance is primarily done. You
	do not have to be subscribed to the list to send a message
	there.

	Issues which are security relevant should be disclosed
	privately to the Git Security mailing list
	<git-security@googlegroups.com>.

Do you mean that the discussion around that change suggested updating
SubmittingPatches too?  The "Sending your patches" section indeed
mentions git@vger.kernel.org, so a mention of the security list would
indeed be welcome there, even though typically the discussion has
already started there before a patch is written.

Thanks,
Jonathan
