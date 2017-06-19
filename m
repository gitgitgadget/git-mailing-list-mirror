Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D44E520401
	for <e@80x24.org>; Mon, 19 Jun 2017 05:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751089AbdFSFu4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 01:50:56 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34418 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdFSFuz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 01:50:55 -0400
Received: by mail-pg0-f53.google.com with SMTP id 22so16071160pgc.1
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 22:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DXgrKz33x7o5QTIwTUt9MPg6LEVPxtpUzjaPUkyB3GY=;
        b=pmVb60nKYfrzBM3IALZnz5+SMtbQtyGvX1GYuvKPeTTiwOyQ6pUKFiJwgahRqkwQXP
         obV/6X2XsZZATH5MpCtZAPTlq3BgfVJ6Ac3I3qVCfAQYEC4RLYhX0wMMp0tSaFsvg8VD
         yzmTJSr3O9jl/zk1ncOQLVoywKuL88TaW9MnxTteeaG9d5VAV6NkccpsHd6JsOPfHmyz
         weS6QsvRVQ560ChVALKnEindkDVT1xN5GAd0DvkQnLZvq9A1ZF3MSwYBjkYjIrDjgFzO
         Go2fPJyQIslUZPNHGwGR1rXfByg+PSfpWBDtF4A7rLWLw7dsodNBYc1fl2bYsP/Swb4L
         QyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DXgrKz33x7o5QTIwTUt9MPg6LEVPxtpUzjaPUkyB3GY=;
        b=X/F6epX3DAnkgyn9sTJaEMxY1zL5k82j60pa8iDSBnbBGY7RVXo3VKwfrfSTBC2YPH
         6iNXv10u/SZ4VnP9w64tyZwseCsdq92PumToIBgSkD10iyfZIOOTsIw3ZFt5Im9wJaIV
         fum2Tewra47QttCnRSvH4tkoLaaoDQ4a4/R0XMbAWb7gcsjkRRlzPWXJ6G/QrHG7hvmv
         9slH5i9unrBPyJco4TYNYDkDJ2Jnwklkv1qao8KG2ElCoj0/Pl4pEyXrdys6OyrbLhkW
         f7x1jynO9y+GZxUS+Ds3zF2l20qhPpfl4TaCg2yLEUkjL0QgLpg09ih2jMb7y/CypHhR
         xOlg==
X-Gm-Message-State: AKS2vOxvELRVtH1QV1zpulV5Jk801ZFmVkUCVONY/4hW2zlQKMrftKSN
        4hEnZwXejqjbI6qSVB2QtihKr7X3F+Xn
X-Received: by 10.98.205.194 with SMTP id o185mr23386057pfg.105.1497851454597;
 Sun, 18 Jun 2017 22:50:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Sun, 18 Jun 2017 22:50:54 -0700 (PDT)
In-Reply-To: <xmqq1sqgv9ax.fsf@gitster.mtv.corp.google.com>
References: <20170619030518.6712-1-kaarticsivaraam91196@gmail.com> <xmqq1sqgv9ax.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 18 Jun 2017 22:50:54 -0700
Message-ID: <CAGZ79kbqBXZ5S2TBk6B5gRk+Y-ev2rdgkQZrF-MmHQc0Thj7EQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] Cleanup Documentation
To:     Junio C Hamano <gitster@pobox.com>, mlevedahl@gmail.com
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 18, 2017 at 10:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan, this was sent in my way, but I know you are the primary
> person who is looking into updating submodule documentation these
> days, so I am forwarding it in your way to ask you to give the first
> comment.
>
> Thanks.

AFAICT this is specific to the arguments of 'add', such that it would not
collide with sb/submodule-doc[1]. However my series was RFC, while this
is on the order of "documentation bug fix", so this would be more important
than rewriting the documentation from scrach any way. :)



[1] https://public-inbox.org/git/20170607185354.10050-1-sbeller@google.com/


>
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
>
>> 1. Remove redundancy from documentation
>> 2. Remove unclear reference to alternative
>>
>> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
>> ---
>>
>> The following line seemes unclear and hence was removed for now. Suggest any
>> changes that could make it clear.
>>
>> "This second form is provided to ease creating a new submodule from scratch,
>> and presumes the user will later push the submodule to the given URL."

+cc Marc who wrote this sentence originally.


>>
>>
>>  Documentation/git-submodule.txt | 37 ++++++++++++++++---------------------
>>  1 file changed, 16 insertions(+), 21 deletions(-)
>>
>> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>> index 74bc6200d..9812b0655 100644
>> --- a/Documentation/git-submodule.txt
>> +++ b/Documentation/git-submodule.txt
>> @@ -63,13 +63,7 @@ add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--dep
>>       to the changeset to be committed next to the current
>>       project: the current project is termed the "superproject".
>>  +
>> -This requires at least one argument: <repository>. The optional
>> -argument <path> is the relative location for the cloned submodule
>> -to exist in the superproject. If <path> is not given, the
>> -"humanish" part of the source repository is used ("repo" for
>> -"/path/to/repo.git" and "foo" for "host.xz:foo/.git").
>> -The <path> is also used as the submodule's logical name in its
>> -configuration entries unless `--name` is used to specify a logical name.
>> +This requires at least one argument: <repository>.
>>  +

So we're losing the information how the submodule name is chosen.
This may be fine as I plan (long term) to make the name an arbitrary random
string (IMHO that reduces confusion as there will be less 'nearly the same'
things)

On the other hand the newly added line
  'This requires at least one argument: <repository'
(actually moved, but) is sort of redundant. The notation in the argument line
should make that clear, already?


>>  <repository> is the URL of the new submodule's origin repository.
>>  This may be either an absolute URL, or (if it begins with ./
>> @@ -87,21 +81,22 @@ If the superproject doesn't have a default remote configured
>>  the superproject is its own authoritative upstream and the current
>>  working directory is used instead.
>>  +
>> -<path> is the relative location for the cloned submodule to
>> -exist in the superproject. If <path> does not exist, then the
>> -submodule is created by cloning from the named URL. If <path> does
>> -exist and is already a valid Git repository, then this is added
>> -to the changeset without cloning. This second form is provided
>> -to ease creating a new submodule from scratch, and presumes
>> -the user will later push the submodule to the given URL.
>> +The optional argument <path> is the relative location for the cloned
>> +submodule to exist in the superproject. If <path> is not given, the
>> +"humanish" part of the source repository is used ("repo" for
>> +"/path/to/repo.git" and "foo" for "host.xz:foo/.git"). If <path>
>> +exists and is already a valid Git repository, then this is added
>> +to the changeset without cloning. The <path> is also used as the
>> +submodule's logical name in its configuration entries unless `--name`
>> +is used to specify a logical name.

This sounds good, it consolidates all information about [<path>]
in one paragraph. While at it, maybe let's find another (better)
substitute for "humanish" as that can be anything(?).

Maybe "the last part of the URL" (without any .git)

>>  +
>> -In either case, the given URL is recorded into .gitmodules for
>> -use by subsequent users cloning the superproject. If the URL is
>> -given relative to the superproject's repository, the presumption
>> -is the superproject and submodule repositories will be kept
>> -together in the same relative location, and only the
>> -superproject's URL needs to be provided: git-submodule will correctly
>> -locate the submodule using the relative URL in .gitmodules.
>> +The given URL is recorded into .gitmodules for use by subsequent users
>> +cloning the superproject. If the URL is given relative to the
>> +superproject's repository, the presumption is the superproject and
>> +submodule repositories will be kept together in the same relative
>> +location, and only the superproject's URL needs to be provided.
>> +git-submodule will correctly locate the submodule using the relative
>> +URL in .gitmodules.
>>

(While at it:)
Please markup the '.gitmodules' either via single quotes or `.
(or even link to 'gitmodules(5)' )

>>  status [--cached] [--recursive] [--] [<path>...]::
>>       Show the status of the submodules. This will print the SHA-1 of the

I am undecided if this is really removing (2) unclearness, but the
(1) redundancy seems fine to me.

Thanks,
Stefan
