Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A39C208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 15:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403825AbeHGR6b (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 13:58:31 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:36424 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389387AbeHGR6b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 13:58:31 -0400
Received: by mail-lj1-f181.google.com with SMTP id u7-v6so13814439lji.3
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 08:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j4fwXUd6rN1ehaNIxuPVh4txIV6lBHy8v7WEV1pqRS4=;
        b=aKG8RsMyWrvWJULRbm/ogLBz69Coj2yRJ8VXJqctUsLrESeHXeqN3cHk3rNDMMAOwv
         sjUiar0zj4wg2hNH1jkBbzRdjyC8TzdGi3IV8jM358oWS8G+alqYRYVQkvq2Ow3bjCAB
         1t3nITZI9oipIAnVUiu+ra56Xm5LvTCkmtYbW05oWeD6qrjFhuZ9X5pMXwu1Fudd3yPa
         X+9G6gL9OS/Wmao03sczyQ+z5ScSeojiTnQ6gwOhFYg0oMzuuWQOGfpwTutnq1MElBRD
         JrT9sF+IsYBjI0lPyOu7erHKIkuIRlcgUgYccfZ/SjuYLV74OsW8s91ajsQnysJQD+2v
         LO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j4fwXUd6rN1ehaNIxuPVh4txIV6lBHy8v7WEV1pqRS4=;
        b=t9jrHAj8/Ay8hYiVOy6beLu/Rbq2pJJnNXsQ6P3iaDXSf4EIKjH1312v4CYsJhXJcE
         SwiHQ9JRtqti0jJ4SPqBqoSA7MSUYKslxz8HTArH/IkvQI7j5LXYbuA5hrTVCJIto6zE
         C4pOX66NMpkVpydfMOTyA8tWzupSqFHLbI1IDdNsrTNLQuVODP73Q3Chd2T5LMlessYc
         lkMZBdGEsTgqLwb5zm/OP6WMlWFIhzbybrZNZPCI5Kp4Xzc8zom1Rs7AiE+J6q4XXKd9
         Jgzl6FMNEphs9s7Cu1eezC+YOUPbSUYFxn6dDhHJ+dA/h+0GqZBpTkI8FV1qqP2ZA1r0
         wgFA==
X-Gm-Message-State: AOUpUlGVcu88m+LqiQxrpeMSRlbK+NeOrz8jj9/eczVvjRuYLqWutx/C
        vtzV/D73J+6rS4llBpEdDG+961+H4DoseF5LV40=
X-Google-Smtp-Source: AAOMgpfc/DPVAZTQXNcMF6bkUYZ9/GS6OyhrdTC9X1XvWnWGrUEAFsKM/RZlJRF1oanxG5VqHJUx4G5p4KKJeRlZfrQ=
X-Received: by 2002:a2e:259:: with SMTP id 86-v6mr17109736ljc.107.1533656615071;
 Tue, 07 Aug 2018 08:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com> <86effapi1t.fsf@gmail.com>
 <xmqqk1p2mefp.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1p2mefp.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Tue, 7 Aug 2018 17:42:56 +0200
Message-ID: <CANQwDwe_2wjkW7nmxztGK7QWUs3ubUDJTbPRdqfGFXkREpExLg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #01; Thu, 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 7 Aug 2018 at 16:36, Junio C Hamano <gitster@pobox.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> * ds/commit-graph-with-grafts (2018-07-19) 8 commits
>>>   (merged to 'next' on 2018-08-02 at 0ee624e329)
>>> ...
>>>  Will merge to 'master'.
>>
>> Derrick wrote that he will be sending v2 of this patch series in a few
>> weeks, among others to make it use commit-graph feature if replace
>> objects are present but not used (as some git hosting services do, see
>> core.useReplaceRefs below).
>
> Ah, thanks for stopping me (albeit a bit too late-ish, but reverting
> that merge is easy enough).  Do you have a handy reference to stop
> me from making the same mistake on this topic later?

https://public-inbox.org/git/a3640919-95cf-cca4-d552-4715a031dd7f@gmail.com=
/

DS> Since this series now has two dependencies (including Stefan's ref-stor=
e
DS> fix that I had included in my v1), I'll let those topics settle
DS> before I send a new v2.
DS>
DS> If there are more comments about how I'm handling these cases, then
DS> please jump in and tell me. I'll revisit this topic in a few weeks.

>> Also, the test for interaction of commit-graph with the grafts file
>> feature does not actually test grafts, but replace objects.

https://public-inbox.org/git/86bmap7l7a.fsf@gmail.com/

>>> * jk/core-use-replace-refs (2018-07-18) 3 commits
>>>   (merged to 'next' on 2018-08-02 at 90fb6b1056)
>>>  + add core.usereplacerefs config option
>>>  + check_replace_refs: rename to read_replace_refs
>>>  + check_replace_refs: fix outdated comment
>>>
>>>  A new configuration variable core.usereplacerefs has been added,
>>>  primarily to help server installations that want to ignore the
>>>  replace mechanism altogether.
>>>
>>>  Will merge to 'master'.
[...]
--=20
Jakub Nar=C4=99bski
