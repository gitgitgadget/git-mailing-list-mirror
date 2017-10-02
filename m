Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463CE202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 04:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751027AbdJBEMb (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 00:12:31 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35601 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdJBEMa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 00:12:30 -0400
Received: by mail-pf0-f195.google.com with SMTP id i23so4414673pfi.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 21:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WDh1VsgUtYxB0rGIRy2VsyFvyYt/qo3CSqqmArF/nyQ=;
        b=JR6ywAE3Z11QBm0OKCU2043CSaWc0qBklfVwm+AZlkz/2KXwolN/XXZhoAxWrz/9BG
         WkkXp+xZabPsNrA6N5taza/YPkEkBI0Y+3laFL5PuuIoxlIeYg0mKSwJkx51CN179Qda
         iem90EoG48cXao+AcbaKdbVJMXtME1JMXRRYBsxPco3FdQyH1ofZGuSN/tT1W6QMfydi
         ZRZX42/7brAWHZe7l4pxMhVxLGrV8S5A6qLEXOg4scTLco9SzmsjNb2kEYjYj0LPb+50
         5L810sPwiTuCSfdAZSmtMgbYMpVcsF9CwBFJQCFnU/Qh1LwiC1LBy9efCPw55UZu38qT
         bSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WDh1VsgUtYxB0rGIRy2VsyFvyYt/qo3CSqqmArF/nyQ=;
        b=Z6w7HS1gRL2B1Y4bEnIkA7UTQ1sgNwR4R69rxFirVdpKiIU7+azhLceVe5rAkmPWDn
         GvhD1zDtXfV06PwFTjL8fsf/aNlMiGLehlgSJdAgRvr/Utj27JFKEbMBOOv3Ks++R/6Q
         7lCWNOCK7v+qSMbmk3tYdunoYskwBqlUMQ9imiDiAoA75Cuc7wjSbHLrtoSnsrPiBzBo
         vRJ3RGV5qhGzolG/snaoJ4rPtJvqRhamaDyckc+iqYypu8vKzy7EmgFtvnBFNgxujsfn
         pFwwbK5beSQOxzwzKkOcVmjNzNAmqQSReVq8WkaPHtc+u13IniqoPo6eGL2ZFaN+uTih
         TXtg==
X-Gm-Message-State: AHPjjUgpyk/I8dVCMz3wb64Q5VJoyNPvR0fnR5Hj/7kAbCnMT9kA8Ky3
        6X7bPDfQ+lTzrG/3+nue2MX1TVo3wW4Z7EdUTFs=
X-Google-Smtp-Source: AOwi7QAt8TDy8zStg7s5AseHWt0xmfDA/b8Uxo4sCAmiT5wqPP0aah+sSPVEdRLU6WA06f91EY494qQ0ivY1NjdUFHI=
X-Received: by 10.84.185.106 with SMTP id e39mr12897927plg.333.1506917549947;
 Sun, 01 Oct 2017 21:12:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Sun, 1 Oct 2017 21:12:29 -0700 (PDT)
In-Reply-To: <xmqqlgkuqkyi.fsf@gitster.mtv.corp.google.com>
References: <cover.1506862824.git.martin.agren@gmail.com> <f241038eeed0f5f8bb346b394495356c20884a39.1506862824.git.martin.agren@gmail.com>
 <xmqqlgkuqkyi.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 2 Oct 2017 06:12:29 +0200
Message-ID: <CAN0heSq-7CzyRV2KhzvC8CymoyMOWydPDi0kS5cg1BS7=oCELQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] treewide: prefer lockfiles on the stack
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2 October 2017 at 05:37, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> This is not a show-stopper for this patch series, but just something
> I noticed, something that used to be unavoidable in the old world
> order that requires us to leak lockfiles, but now it becomes more
> obvious.
>
> update_index_if_able() calls write_lock_index() with the COMMIT_LOCK
> option, but it does so conditionally.  When it does not make the call,
> the lockfile is left behind to be cleaned up by the atexit() handler,
> but when it does, it is closed and released.
>
> Perhaps update_index_if_able() needs to be further cleaned up to
> always release the resource held by the lockfile structure?  Its
> caller cannot differentiate (and more importantly, its caller does
> not want to care) if the _if_able call actually has updated the
> index or not and act differently afterwards.

Ah, indeed. I should be able to do that rather easily on top. I tend to
agree that the caller shouldn't have to worry about it since the
function is just a one-off "if_able" without any return value. One
caller actually does roll back the lock, but the others don't.
