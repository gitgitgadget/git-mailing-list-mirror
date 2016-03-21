From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH][Outreachy] branch -D: allow - as abbreviation of @{-1}
Date: Mon, 21 Mar 2016 12:27:12 -0700
Message-ID: <CAGZ79kbmMAyd3rDokCD6RSLuoJDKfPG0m2+HszUuRYG_eHdC6A@mail.gmail.com>
References: <1458573317-15532-1-git-send-email-elena.petrashen@gmail.com>
	<vpqfuvju4km.fsf@anie.imag.fr>
	<xmqqtwjzn2nu.fsf@gitster.mtv.corp.google.com>
	<CAPig+cQNBeBaLb-znNgxOanUz++pQLae=c8vUtFXjqxOns4d-g@mail.gmail.com>
	<xmqqegb3n1if.fsf@gitster.mtv.corp.google.com>
	<CAJPOeMediYQMwvgqhOquVh+KT61gdpUew9ernjuOYuf8By=hZQ@mail.gmail.com>
	<CAPig+cQ-kmHeQsMMKdj0joSHWEnGfirSM1WbC-6G2BiMLnoUGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: elena petrashen <elena.petrashen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:27:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai5U4-0006Ht-Nf
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 20:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbcCUT1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 15:27:18 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:36353 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254AbcCUT1O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 15:27:14 -0400
Received: by mail-io0-f178.google.com with SMTP id 124so69097619iov.3
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ZfUipQvRzaNpNAj27AatyWy7G5LBqF8ptRvA+xnyu90=;
        b=A+Rf1Q1sfNxCoN2hNAfwWbZ5cNnc1AVCg4ZUzuvjQ/YZLbJwibhSjRrBadreDWPsLW
         35T9adrLVO/WRp2/DfNAFCyRPlmWgC0QnSlFD9wfD55YH12AioPHGM+qewaQIloAB5Ow
         Ex6IRRjuRJUY9NyN/gteV9mZCWpcWnuGA0mI9PfTjrtmFj1DYrVzwc2Vuc1SPEgeX90N
         4ZvdjV9iJCSij5DwhUtK4iRw9hAzPIISwbuieputjp2UejKZD7IEyR6mUb+x9PNoWmCa
         Sm5HyLmCpq5CsDfTHhUDrYA2/6xj39paRS5zE1A22x9iUhUhp5NdSbslRZQi96C+bU0W
         B/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ZfUipQvRzaNpNAj27AatyWy7G5LBqF8ptRvA+xnyu90=;
        b=iNxOdHrMrnES8fikApRKtf1eoASIusMrcywqZ/8uX9rXoGQF0pcCyzqaoPXR1OXrk5
         1zDz6ouUMsc8D4H2Fjx1E/dbbL0rkRCiAgBkZfe6pi0k1CJ2kkpZGLGvzKi3P+wE8lzW
         9bfNhfug7GyeA4v5k4YW4iSmBDmLHVpuobHqTt33mnanCI+PhHjudnjN1vVe/prNgY7O
         wBrltC//Ci0jeeNViwgzwOlOU1BwuWqnLZHTIy/QEb6UKVJd6qYKQhvQVlr56wPE/8TY
         vAihJeOPBI3MQ764GuoagBOEryih0Z4icZjNCaNWZoF97+BpH90/h9m8g/zrS6bMicmz
         q5tA==
X-Gm-Message-State: AD7BkJIf4YoVztEMH863XWIj4nFRrWBcb4U5i+i0/d4nXE5ooxOGOtWO5D5nWQHVEeORL5/PqnkM16Ny1128D/UF
X-Received: by 10.107.158.138 with SMTP id h132mr29171876ioe.174.1458588433036;
 Mon, 21 Mar 2016 12:27:13 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Mon, 21 Mar 2016 12:27:12 -0700 (PDT)
In-Reply-To: <CAPig+cQ-kmHeQsMMKdj0joSHWEnGfirSM1WbC-6G2BiMLnoUGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289440>

On Mon, Mar 21, 2016 at 12:14 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> [please don't top-post; respond inline instead]
>
> On Mon, Mar 21, 2016 at 2:53 PM, elena petrashen
> <elena.petrashen@gmail.com> wrote:
>> Thank you for the feedback!
>> The safety concert is indeed a good point. Would it maybe make
>> sense to request user to confirm this operation? I.e:
>> $git delete -D -
>> You've requested to delete "foo" branch. Proceed with deleting? y/n
>
> Rather than requiring the user to stop and answer a question, an
> alternative would be to perform the deletion as requested but then
> give advice about how to recover if the wrong branch was deleted by
> mistake, much in the way advice is given when switching to a detached
> head. (And, the advice could be suppressed by an "advice"
> configuration variable similar to how other advice messages can be
> suppressed.)

There is some advice, but it is not spelled out for beginners IMO

    Deleted branch test_branch (was c62f9fe).

I would assume intermediate Git users would know c62f9fe to be a sha1 which
can be used to retrieve the content of the deleted branch. It is a good
idea nevertheless to add

    To recover the branch: "git branch test_branch c62f9fe

I would not even make it configurable to suppress it as it is just 2 more
lines.

Thanks,
Stefan

>
>> Also, do you think - shortcut is justifiable for $git branch -m when
>> referring to the "old branch"?
>
> It comes up once in a while that I've switched away from a branch and
> then decide I want to rename it, but it's infrequent enough that it's
> difficult to say if it would be generally useful.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
