Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF0271F576
	for <e@80x24.org>; Fri, 23 Feb 2018 10:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbeBWKZP (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 05:25:15 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:38831 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeBWKZG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 05:25:06 -0500
Received: by mail-ot0-f196.google.com with SMTP id 95so7055702ote.5
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 02:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VKOufMbN4dI3A+DyW8WdMsnKP4PACLj+txqFdxEviPY=;
        b=gqjot4YnMa3gzRoKGZcNg4p9FPhqjJ/snHLKIVwtBeUtA5gTHDaxbCxm/XHy9Xw2p+
         /HWKw5q5F/GzqLHf8bJLr1cQqIKlP8/WH1HFZ3+OBXrraTBInIGkIOmwnkB69JI/9Yek
         Y1NOtf0TFzu+VBFuXwLmjPjgAeBZllRfhrrqSBrfPapygOyTmhwwpABOX3jJYGELpKWo
         zQb1VJRxgwl7/CV3q+Hsthaq51uZku8lm5DRTZeYkx4iAD1LYuXB5ME2TRfbDC6c62ot
         stWQuBZdBcc8g8MPEr2k+fhNGmQElgCIxxupWUgxWd7DUJEeY+5UiV4bTgSncJM3oy3q
         +ubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VKOufMbN4dI3A+DyW8WdMsnKP4PACLj+txqFdxEviPY=;
        b=rcq9pYhQTB/azHzmggh3UkBIhcom+8h6/0Db6WuoZu+2pQ6WfSwOwxeV9JT5JdZFLm
         fVEokUBK6gTQOO0vFooE+HW++ZiohDtK/1whyVgw2Ds5hICRZjvx8oIh5ahcLoPqFtDZ
         ZE+qFNDyEZF2dlE/t2hacbMU4nKVYH1Gu+LWWrG7us64bKkRZAoSQRYPWwjK3TvKEBZF
         ptIi8cxLZa9IsWmd7a9Mu/CSG79DTGeJJNLtUouIdEXnHnjprq9j2XMjp/vqlkoWvYEQ
         EOoC39unCwlK0S4okLr9APOgxbF/sIumK+tRMqlBL2LRSHSpfxc6lvTWT27TrkYGlL9+
         vw6w==
X-Gm-Message-State: APf1xPCzzNbd1F9jaXGVGYZzT6uKBRV6FPGNbgc5TQbXQkPNDv7WWwDp
        974NYu3HEasE8QBUU4FWTX9DOT0AyYtfr2u1iAg=
X-Google-Smtp-Source: AG47ELugXVwW7YiDjyaPIrNhqWz4pNaAHez2AUaygvk9MejzXzH1evYdhnzuBRoa/yHhrMQxDUlRarTi5khBFNgYIwA=
X-Received: by 10.157.67.42 with SMTP id s39mr744551ote.14.1519381504962; Fri,
 23 Feb 2018 02:25:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Fri, 23 Feb 2018 02:24:34 -0800 (PST)
In-Reply-To: <xmqqy3jvmkyn.fsf@gitster-ct.c.googlers.com>
References: <20180214111606.4257-1-pclouds@gmail.com> <xmqqy3jvmkyn.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 23 Feb 2018 17:24:34 +0700
Message-ID: <CACsJy8CUmpXNZDR6jvXP=hQkuTmCqzYYqitXJyYYR31Yw7DXXw@mail.gmail.com>
Subject: Re: [PATCH] am: support --quit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 15, 2018 at 2:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> Among the "in progress" commands, only git-am and git-merge do not
>> support --quit. Support --quit in git-am too.
>
> That's a strange way to phrase it, when the number of commands that
> know and do not know it are about the same.

Arghh!! I thought I deleted that "git merge" part. That command is not
really in the same group as revert/rebase/cherry-pick/am. It only has
--continue, aborting is via "git reset"... probably because it's older
than most.

>> @@ -2359,6 +2363,10 @@ int cmd_am(int argc, const char **argv, const cha=
r *prefix)
>>       case RESUME_ABORT:
>>               am_abort(&state);
>>               break;
>> +     case RESUME_QUIT:
>> +             am_rerere_clear();
>> +             am_destroy(&state);
>> +             break;
>
> The internal implementation detail of am_abort() is leaking out
> here, by saying "rerere-clear" is the only special thing other than
> recovering the HEAD and working tree state when abort happens.  It
> makes readers wonder if am_rerere_clear() should become part of
> am_destroy().  I dunno.

I think the original design is am_destroy takes care of
$GIT_DIR/rebase-apply and nothing else. --abort has to clean up things
outside (index, HEAD, rerere) while a successful operation should not
leave anything else to clean up (except rebase-apply dir).
--=20
Duy
