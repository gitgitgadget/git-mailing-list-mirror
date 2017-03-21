Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B973C2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 20:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757939AbdCUUBm (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 16:01:42 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:36278 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757383AbdCUUBl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 16:01:41 -0400
Received: by mail-vk0-f48.google.com with SMTP id j64so91576589vkg.3
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 13:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YAvoYdOyaJDiKX9lpvamnTQgNmbXTgXsDOJFnIigzX0=;
        b=FRuubBnxsyTceRhM4ml4orw4IMP4a2xJg4GxmfIVYWfLhKGuWlgl4cKbgmxoy1NAG+
         oqS0wjieIPJ+yVumsHg+Wav8tT+vRRYTkxXiVATaauADaNuqQVG2e6peSE8TPI7wZFH+
         /GB7q5aeoKDn0KcsIQUHWaQiqmAmuuB7kZhJc64ISPBL1HLdylJs3oDwkNJJ6bqRksiH
         vR2qXwehkIJ3TrFwsrOlhM735wg5+gsBfU7ryrLtlCe1ikAKaE2X5+K9QjTtb1yeBBPl
         svH4iltoNx2sX7Fiq7uTJvlc+EeSC4OiVpRBnDERwHo+ESogXsUzSKzqDdfL5mLjX2Pv
         Vw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YAvoYdOyaJDiKX9lpvamnTQgNmbXTgXsDOJFnIigzX0=;
        b=Dwi7eSZ5OUd0rjGr1sVHxDBHJsfoFzsHUkb5sZylDwUvhzs9vyCAjyk/4OH+0kSu5s
         D/vQmyN0gOQYTJCCTqfqUKlDDB4KvJS29X3j+6+/6cphU4v1zleO9ZnyHhQUsa8PoKPk
         vMgs9tIrOw9TWZz3WxIFv4oV1JxsRlrkHqIc4/ZoRIcN02dGZg56mr+vpEQKbldRpCdO
         kW6k6h9a2n3Kz6AEN6e7inXxnahl/Isp5aN8gZfaghDM2Yl+fBN/EkWdWJXqg1As4I41
         bZ90ukmvpbQRhIfcXGFd9xAZq4kN0qI8XkDa7jjg9eutY8TU6/x0STwGNw5IjJF217NK
         46Rg==
X-Gm-Message-State: AFeK/H0xaHD+pVN0qdaRyB6gWMdtlXhMSsvo/y7XDdczY+eXSJSQedM7uItrVIn8HFXCt8DLNwmUB2o5hqIvbg==
X-Received: by 10.176.77.66 with SMTP id k2mr13868573uag.119.1490126499573;
 Tue, 21 Mar 2017 13:01:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.7.150 with HTTP; Tue, 21 Mar 2017 13:01:39 -0700 (PDT)
In-Reply-To: <xmqqvar2qzof.fsf@gitster.mtv.corp.google.com>
References: <20170321155153.20753-1-szeder.dev@gmail.com> <xmqqvar2qzof.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 21 Mar 2017 21:01:39 +0100
Message-ID: <CAM0VKjmZS-mTdtBb1BDhixzWMou7h7VZSo3hpj5pk_C6i_MBnA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] doc/SubmittingPatches: show how to get a CLI
 commit summary
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 6:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>>>  The "Copy commit summary" command of gitk can be used to obtain this
>>> -format.
>>> +format, or this invocation of "git show":
>>>
>>> +    git show -s --date=3Dshort --pretty=3D'format:%h ("%s", %ad)' <com=
mit>
>>> +
>>> +To turn that into a handy alias:
>>> +
>>> +    git config --global alias.git-commit-summary "show -s --date=3Dsho=
rt --pretty=3D'format:%h (\"%s\", %ad)'"
>>> +
>>> +And then to get the commit summary:
>>> +
>>> +    git git-commit-summary <commit>
>>
>> - 'tformat:' is a better fit than 'format:' in this case, because it
>>   adds a trailing newline.
>
> That depends on what you use it for.  I most often use mine to
> insert the reference that flows in a sentence, not as a separate
> displayed material, e.g.
>
>     1f6b1afe ("Git 2.12.1", 2017-03-20)
>
> so for that purpose, not adding a trailing newline is a feature.

Perhaps we are running it differently.

I use its output that way, too, usually running the command in a
terminal and copy-pasting its output into an editor.  For this I find
'tformat:' clearly better, because the reference ends up on its own
line: it's separate from the next prompt and easy to copy the whole
thing with a triple-click anywhere on that line.

With 'format:' the subsequent shell prompt is the direct continuation
of the reference:

  ~/src/git (master %)$ git show -s --date=3Dshort --pretty=3D'format:%h
("%s", %ad)' master
  c0f9c7058 ("Sync with 2.12.1", 2017-03-20)~/src/git (master %)$

I don't like this, because it looks ugly, is a bit more difficult to
copy, and if I press the up key for shell history, then for some
reason it gets messed up like this:

  c0f9c7058 ("Sync with 2.12.1", 2017-03-20)~/src/git (master %)$ git
show -s --da
  masterrt --pretty=3D'format:%h ("%s", %ad)' m

with the cursor blinking on the last line after 'master'.
