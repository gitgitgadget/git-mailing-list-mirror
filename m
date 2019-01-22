Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84C6C211B5
	for <e@80x24.org>; Tue, 22 Jan 2019 21:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfAVVny (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:43:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42276 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfAVVny (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:43:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so32953lja.9
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yy7T1Y9fJimh7TmbLhL3XJUkjmIi46c1rqF15d1ZfYA=;
        b=m6XJDI4m7eudOBWYdqHb2rj3d8W2WFrsC4BbNcCh1uzhRWpfjzkUJC6g+zqY9qlvTe
         Mq/miFNLpyqYTWucQy5ffjQr0xFvuKryaW41QKp2mZmThLwzxfwCcVBbM3HIkGBIRXsS
         EdVA4Id18fEbeQME9x+L2U7KMjosCAZ3Ho5zwDVSEqkqkiDHML+fHAQ1DXewFNmN4Fu/
         I1OWmVoh8S6nu3aS8ap+Y9cI/Ict+WmBOi41AP2AMJKf9tEAAMGJQIxxCdHP4UaEevU1
         yKLd04R9Na+uc8E5KP3YjViyvKd+WNRdHhVgK+9F8Q3R7ZV9O+vcC1ZKT06Iu6nz28tl
         Q85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yy7T1Y9fJimh7TmbLhL3XJUkjmIi46c1rqF15d1ZfYA=;
        b=GNLkF9KSN+MTV611MeuW/xKCoJk+M4nHQnX8C66fXVvul5iNocp6ZxToLh77Eb+soe
         JegVaE1O0hmnUyf2CAJ570RGeSwRoyHhrnp9+FW3t8+kY01yDu67ln2yOQjoxtbpQK7X
         aYJwlC+XEeP97SxqFo+2mMOjqvVksIxyUR+yWUFgYnQfkVydwREVDUlVwP6XpDRiXaRj
         x3SHcuYOLOLW04ATQgmcIWjb4hY+8A5IyD7CbR9PiA/RE0pR6wrWfP3Gp5AmbRfZbRU5
         tay8LicnxrOUccCAul1G1CE2M3ovA725k21Avkg8pyoRwvOHTNtJ7wAc2im8hYWlFcH7
         Tk3g==
X-Gm-Message-State: AJcUukfq5yAWwlK9MFmxnTgeFwRjGuDWdGs0+BHiDDp9WRlnyT/+7Q82
        3GoaMY4DBFE3RtqSzbOLOIijLCYt8+9FPvffaF8=
X-Google-Smtp-Source: ALg8bN7VHPVVSvwutyEiEZH/oKoPwPwMkUmEaY64/yUXQ5q5dEtJDc6mSRpCtpmoHY7JBjjKQjnqrHN1rprdmCpyflU=
X-Received: by 2002:a2e:7011:: with SMTP id l17-v6mr23064238ljc.147.1548193432234;
 Tue, 22 Jan 2019 13:43:52 -0800 (PST)
MIME-Version: 1.0
References: <20190119232334.31646-1-brandon1024.br@gmail.com>
 <20190119232334.31646-2-brandon1024.br@gmail.com> <CAN0heSr3a9H46j3wiTwwbw7HFh4+4aFs5-qe=gtxYB3vC73KAA@mail.gmail.com>
 <xmqqzhrsfr4c.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhrsfr4c.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 22 Jan 2019 22:43:40 +0100
Message-ID: <CAN0heSrSAupNkRHCsgsvMoOE7VE=yxv0MkaOi4WmZQm_2_Foaw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] commit-tree: add missing --gpg-sign flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Richardson <brandon1024.br@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 22 Jan 2019 at 20:07, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> >> +       echo 11 | git commit-tree --gpg-sign HEAD^{tree} >oid &&
> >> +       test_line_count =3D 1 oid &&
> >> +       git tag eleventh-signed $(cat oid) &&
> >> +...
> > Let's see if there any opinions from others about this more verbose
> > construction, vs placing the oid in a variable and quoting it. We
> > obviously went several years without realizing that using $(...) as an
> > object id risked falling back to HEAD and that a completely broken `git
> > commit-tree -S` would pass the test. So being over-careful and extra
> > obvious might very well be the right thing.
>
> Sorry, but I am not sure what issue you are worried about.  If the
> "commit-tree" command failed in this construct:
>
>         oid=3D$(echo 11 | git commit-tree ...) &&
>         git tag eleventh-signed "$oid"
>
> wouldn't the &&-chain break after the assignment of an empty string
> to oid, skip "git tag" and make the whole test fail, with or without
> '$oid" fed to "git tag" quoted?

Yes.

> It is wrong not to quote "$oid" for
> the "git tag" command (the test should not rely on the fact that the
> object names given by "git commit-tree" have no $IFS in them), but
> that is a separate issue.

It'd also protect against a failure mode where we get no output and a
zero exit code. (Maybe that's ridiculous, but we're testing `git
commit-tree -S` here -- plus, I'm lazy, so I'd rather double-quote than
think. ;-) )

But you asked me what issue I worried about... To recap, master has a
test with a one-liner that doesn't bark if you completely drop the
implementation of `git commit-tree -S`. I don't think that's the
worrying that you're puzzled about.

I posted a three-line replacement that verified the exit code and quotes
the output, but which also has a pretty paranoid middle step to verify
that there was precisely one line of output. I then followed up with a
less paranoid two-liner, which avoids some round-tripping, and which
doesn't verify the line count, but which rather assumes that `git tag`
will bark on a bad oid.

I think that last thing is a fair assumption, and that's why I referred
to the three-line test as being over-careful and extra obvious. I'm not
worrying about the quoting as such.

Martin
