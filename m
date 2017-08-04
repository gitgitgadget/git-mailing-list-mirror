Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DF652047F
	for <e@80x24.org>; Fri,  4 Aug 2017 22:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbdHDWCo (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 18:02:44 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34690 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdHDWCn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 18:02:43 -0400
Received: by mail-pg0-f48.google.com with SMTP id u185so12672633pgb.1
        for <git@vger.kernel.org>; Fri, 04 Aug 2017 15:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X9s+z1UzNAhSTrx8Magby+3EW33r7/3oKB+N3mQVhfY=;
        b=pp7BF2CYYVhTqgEpBk/An6XadjokmcLh7oWhmCpkm89W9I8bXm2+ZyaStpM0RIT7Ww
         rMqrahGeBKnuvZjo2iK0VjlsNbouggjuVWx6J/eR/hMxir1JylZlB5qVl3u48ss8DKKy
         CQ58KOTJxBzK4RUp0bqTft4itdLWpYB/4gcynTrrAzLsqP7OYDqD66l36d25Syh836sZ
         pX0DBSHFqZSG49VCwClR1ADkfELTCtMJDTsTvqZLqrGY31y+uXHpDPpwqGCszklj3SEa
         z+K3nhk9+pxg8HdYM8BFhzyy6gt+r8bl9+8l0h+umSzcaSSQpJzOFKM4fga4F6nozvPB
         d1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X9s+z1UzNAhSTrx8Magby+3EW33r7/3oKB+N3mQVhfY=;
        b=E9vJDvcfwf6BT+ARmq/Mqeq3JV0ebTZLlRaa6m3gDaA7eKLQNiVlvWNx+6bCjidH+y
         Svb5t8Bapj6bGaMgGHvGle2OPz9oSL+4t2oWGKTgbhS4rdmwRxPFW3lPU4pXIm/yPOEW
         OPLzpgt4RU8Pqq6l/dYFkGkT6ooE1lbFIjg7+zIxZeR0MJS+tPGZ/SU7962u+nfbfwDX
         1xZ5Id7EigtM3Um6TnmZqBe/5eSAeVI7XLPkG5j0Y3+aT6vFXf15vgHaWS7rUID9noRD
         QeOzNEZmx/Wj9CRVn6EQOArVNl9ICkyCel4iboNd0OgbHkJoZD2q8y8OUWpgqmADgxsa
         ex8Q==
X-Gm-Message-State: AIVw113yU+r/i3dEhoURVlv8xbT5sYdZ1NgFMnoiCfsVuKFF6tZnCi7v
        LhtHPsSpHPdtnrU/md6D+BvQgcoBiw==
X-Received: by 10.101.91.6 with SMTP id y6mr3881568pgq.88.1501884162660; Fri,
 04 Aug 2017 15:02:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.160.172 with HTTP; Fri, 4 Aug 2017 15:02:42 -0700 (PDT)
In-Reply-To: <xmqqy3qzrpvl.fsf@gitster.mtv.corp.google.com>
References: <CAAM6cWfYfpX+8iK+SH=ukPutB18UAafXOZ3fuKQBiQ-4arp-8Q@mail.gmail.com>
 <CAAM6cWenBUL6rNva+KmwnPhUwzGZeFs53=N8yOkyyTXOmXC2jw@mail.gmail.com> <xmqqy3qzrpvl.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Bj=C3=B8rn_Erik_Pedersen?= 
        <bjorn.erik.pedersen@gmail.com>
Date:   Sat, 5 Aug 2017 00:02:42 +0200
Message-ID: <CAAM6cWety96B7yAxjsD+s=z1GXOwgdykT=D2W9wJrD=9Ph26eA@mail.gmail.com>
Subject: Re: Fwd: bug: contrib/subtree: Commit message title should be in
 imperative mood
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I would argue that:

1. If used on the "Git project itself" (as in my case), the commit
message now cannot be used unedited because it is a conflict with the
project's guidelines, and also conflicts with the format of "all" (or
most) the other Git (and GitHub) commit titles.
2. If not "used on the Git project itself" (I assume it will always be
used on A Git project), changing the commit title to be in line with
the rest would not hurt anyone.

Bj=C3=B8rn Erik

2017-08-04 23:21 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Bj=C3=B8rn Erik Pedersen  <bjorn.erik.pedersen@gmail.com> writes:
>
>> I.e. "Squash 'somedir' changes" and not "Squashed ..."
>>
>> See
>>
>> https://github.com/git/git/blob/master/contrib/subtree/git-subtree.sh#L4=
63
>
> I do not think this is necessarily a good change.
>
> "git subtree" (in contrib/) is not a tool limited to be used on
> projects that follow the same convention as the Git project itself.
