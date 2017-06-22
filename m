Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F12AF20802
	for <e@80x24.org>; Thu, 22 Jun 2017 20:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbdFVU1f (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 16:27:35 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33674 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753287AbdFVU1e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 16:27:34 -0400
Received: by mail-pg0-f42.google.com with SMTP id f127so12379405pgc.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 13:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uOcCiDxHF22NzOVlPjQDmW6CT00P0+61NXQ9aQ84k3g=;
        b=Ot04R8OLtq1olPADu8e+7Oj+vIK7hmUavkmL2pU56wOvzt99Fko+0rpei79RZqz9th
         FF3Eflz/C1MViK0FRic6UBo4JzQ6bk6QEvMbMx3o/orqvR6fwqrK4NENWWU9g1lKkpxt
         TCEvLmonwI1D5hu9Jk3soR5t40M+z2hgkuI+ZsRVOLtTR0LwNUaGOwq7hfSAEdGaRJDE
         rDs7c0l8Ak98J0876KTyV0UhBDJg+ngZBAt2gc7CKMP3ak81vjw9RNSVlhG3U5sbhKIB
         +kpjIpKm71rIJvMUhA2UPcGfrz3rarCrLGet9NRDRBlAepQpdejdoYO8k3+YU1s1Fr7k
         OWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uOcCiDxHF22NzOVlPjQDmW6CT00P0+61NXQ9aQ84k3g=;
        b=uf6Qd+tWLd4zFnk0uC/77+IOAZKmIXu5xUysTe7kej9tLGUPJU7Z+TTDPpD9gREfIr
         WcEFIuU0ju9KIketseK5kgIsl16H31XMX4ail/0LBGRKQ3kNoW9kGh4uAiI4o9KcEl3b
         bD8zDAbxzoCcdlyKXoT+UsYWZIvsRZjj/AQsar2xz0uFsk6znmsr+RRURmnu7+mjZJeB
         bChuAXrEW2qMNn58goyjrLj9GSSLJOyfwVT/9OX4iGwjPBeWlpt3q0rpvf9s7MLRmL1o
         KM250UH4I6saip4XP5MKyFB4kVrdglrjVP7Rk+pc51BgAxgBpHYXBcmWueyupf3yq0e/
         SuEw==
X-Gm-Message-State: AKS2vOzXwZ3YTDVRaLVzxqGvGnRc/IgKJhT4zhAsSDvvnWLFobNaVVUa
        +bU367mHvSqvG8I+DAZoEfH6zyjJNiqr
X-Received: by 10.98.34.8 with SMTP id i8mr4470610pfi.194.1498163253363; Thu,
 22 Jun 2017 13:27:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Thu, 22 Jun 2017 13:27:32 -0700 (PDT)
In-Reply-To: <xmqqlgojixjo.fsf@gitster.mtv.corp.google.com>
References: <20170607185354.10050-1-sbeller@google.com> <20170620225650.7573-1-sbeller@google.com>
 <20170622174659.GA124061@google.com> <xmqqlgojixjo.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Jun 2017 13:27:32 -0700
Message-ID: <CAGZ79ka5MkpPSxR23Kz9DcxFkHNB-hz=n-teDXc6=eX4p473FQ@mail.gmail.com>
Subject: Re: [PATCHv2] submodules: overhaul documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 1:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>> On 06/20, Stefan Beller wrote:
>> ...
>>> +The configuration of submodules
>>> +-------------------------------
>>> +
>>> +Submodule operations can be configured using the following mechanisms
>>> +(from highest to lowest precedence):
>>> +
>>> + * the command line for those commands that support taking submodule specs.
>>> +
>>> + * the configuration file `$GIT_DIR/config` in the superproject.
>>> +
>>> + * the `.gitmodules` file inside the superproject. A project usually
>>> +   includes this file to suggest defaults for the upstream collection
>>> +   of repositories.
>>
>> I dislike this last point.  Realistically we don't want this right?  So
>> perhaps we shouldn't include it?
>
> I am not sure if I follow.  Without .gitmodules, how would you, as a
> downstream developer, bootstrap the whole thing?
>

I think Brandon eludes to our long term vision of having a separate
magic ref containing these informations instead of carrying it in tree.

As urls change over time, it is better to keep the urls out of the
actual history, but still versioned so maybe we'll want to have
a ref/submodule-config/master ref that contains all the bootstrapping
information. The .gitmodules file would degenerate to a pure
name<->path mapping.
