Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2799520133
	for <e@80x24.org>; Mon,  6 Mar 2017 22:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754535AbdCFW7J (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 17:59:09 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35128 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbdCFW6z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 17:58:55 -0500
Received: by mail-pf0-f181.google.com with SMTP id j5so66278898pfb.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 14:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9xJPBOZGAiPJHQnI+JFzDUg+oOHEBz2lAMrYOwtSrpc=;
        b=Wg7UFjz+AXHrOzXtnOiR0e147D89tfIsNTyu55SfdhfyuLls+K8bk29I9OMt9B79ko
         Fsvgf505lq/2OibtJg8m3UGfhMrwEftrufLtOiuNQOqiUhOdXIMPLhDXRPH4/OcqSPnB
         M9RNzeUQhkwDyc/2yuW+P8ivOb4A8AoTu34SOJp32KsYYozT8bjd3l8fX0UUGopKqnKs
         m+Da0Jwi0xuUBOwro1CUKrnXEXqFIueZRioctKuiCNhwckx3/Ao0K/0K6RZW68rst5bI
         63wVgONtCT4a4f+1qiDVRR1/U16btnyi7H7Laugc6hqaAfLr+pQ41a4KSjBzPRQ9gVCb
         VWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9xJPBOZGAiPJHQnI+JFzDUg+oOHEBz2lAMrYOwtSrpc=;
        b=Q6MWz9dXCp3uMN4q6K+hCeT5Nll6N9Os06rI1W2IJyhYtHfB7qQTqpG+Ko8M3iHDoa
         dDqDUlD0bHDZ7yXiqQaTY/6FrBO27oM4XKpqMXOxYJ+0w9yxBcxlRdGy1b+42K3dsHEg
         j5lWhpml0wVYgN/Tcj3IfERPyM4wyDhajO6oV6n4hbm8k8c8ZLPDNxmM6w/qIA8AxCnQ
         GYw8LfGiN5orEytfH8QIw99/Ohjw6lOZVmg+8Hr/zSLJtB1Sd15fmtnA+o0bAeJELU/q
         DjNsYSJBGfR19mrPYFw9Fh1433CXFMjdbIYbJEA6+KauQN5VBJeIb92kbUhegIq0WsOP
         y1/A==
X-Gm-Message-State: AMke39mK+HSQuCwJ897kxv5G4CM+uYL9MFbZXvNMSzRtpSr19dngI8UvdMKsa+Km6Wb3LTwzpp3NdzxtzCkujeJr
X-Received: by 10.98.112.134 with SMTP id l128mr24162323pfc.81.1488840757575;
 Mon, 06 Mar 2017 14:52:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 6 Mar 2017 14:52:37 -0800 (PST)
In-Reply-To: <xmqqshmqm4ur.fsf@junio-linux.mtv.corp.google.com>
References: <CAGZ79kYxD9B_+3vBgO+Z-wh2GMg_REazA-xpTSAqe3_64VMV3w@mail.gmail.com>
 <xmqqshmqm4ur.fsf@junio-linux.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 6 Mar 2017 14:52:37 -0800
Message-ID: <CAGZ79kZU+-5D0bHSA1duRLnvjb+P67AzGhESS6J1z5qtO8SXsQ@mail.gmail.com>
Subject: Re: [Request for Documentation] Differentiate signed (commits/tags/pushes)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     tom@oxix.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 6, 2017 at 2:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> What is the difference between signed commits and tags?
>> (Not from a technical perspective, but for the end user)
>
> When you "commit -s", you are signing the bytes in the commit
> object, which means that you are attesting the fact that the tree
> you wanted to record is one of the 47 other colliding tree objects
> that happen to share that 40-hex hash value, and also the fact that
> the commits you wanted to record as its parents have certain SHA-1
> hash values.  As you are relying on the resistance to preimage
> attack against SHA-1 at least locally around that signed commit,
> there wouldn't be meaningful difference between a 50-commit series
> each of which is individually signed with "commit -s", such a
> 50-commit series, only the top of which is signed with "commit -s",
> and the same 50-commit series, on the top of which is signed with
> "tag -s".
>
> "tag -s" also has the benefit of being retroactive.  You can create
> commit, think about it for a week and then later tag it.  And ask
> others to also tag the same one.  You cannot do so with "commit -s".

ok, so there is *no* advantage of signing a commit over tags?
I'll see if I can write a patch that enhances Documentation/git-commit.txt
pointing to git-tag instead.

>> A signed push can certify that a given payload (consisting
>> of multiple commits on possibly multiple branches) was transmitted
>> to a remote, which can be recorded by the remote as e.g. a proof
>> of work.
>
> A signed push is _NOT_ about certifying the objects in the history

Yes that is my understanding, though I was unclear in writing it.

> I'd agree with that "checkbox" description, [...]
>  "commit -s" was a remedy for that.

Out of curiosity: Does (did) such a project exist? Can I read up on that
and their best practices?

Thanks,
Stefan
