Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2DB71FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 15:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935930AbdCXPbx (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 11:31:53 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:36004 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755525AbdCXPbv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 11:31:51 -0400
Received: by mail-qt0-f173.google.com with SMTP id r45so5162327qte.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m9piiOU5/0bZHiZHka1ls7IysVkezenj0zxhJsVyqwY=;
        b=bWR/E3C0XC4UHsTcDxcFQFS4mGn5mzJewbZeh7MFC2FUqk9JNIx6IdvhrW1lW0hkVa
         aUc1Y+a+uRmIYxUBIBOyGa6ktiEx2auqaD7e0spl8UuWR2LYfk1BB2AMt8VddGVq/SjU
         +Ss3tsNv9VMqV/bFS7cNzeU7Q8EKt7f9ql+R0N+JpDPucl75RzD4krLPBccDBRb1d82t
         A5nJVcSjirknQDX2oyHjFJQzPsUfPCwc7owr754AZ0zFjvWAobSaI4WH/vAc5eUf7PzV
         uakGxVvsRM3L0Xc+xLW2gEUN3CVTxyV65RY1zt3iBncVsr4BZKDoAInrC1yW96BevsNj
         MuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m9piiOU5/0bZHiZHka1ls7IysVkezenj0zxhJsVyqwY=;
        b=gMJ+Erui0SptKl07xLzxo8e77ITfi9pNOF6EJqXRKS9YkJ+HQjizp9lV8ODutV0n3J
         lt5s0h2ATTabJE7N4vLmgvwUTFxjPlBy4uN4a5kCv2sbuUBFP72LvY9zffX41t/e/rhA
         sAHFEr7t7Um2f4ylmaFAhXADh3xLV7n6FxLKT3Y7v9/ikBqwosxZoNU38XFdbzpxblnz
         wLfI/rT+21RHnbFky5yRKaokRUz78aUKpy4Jejtn/uGdg7CeqlIIunWgoIZCA9cnwHy8
         mg6BtznHfDHpDgTUSXm03WUxZoay4UbPHS4LfPp7JwBM/XxSRANZ4XbhGz+moZlvTu2e
         k1fw==
X-Gm-Message-State: AFeK/H0++lx6kMymWUiQGLv+71aGGt/2/NmmAqNXRjUE8f9wN26ITL9dNvbpxXYQ90Rycc1rz1wXGid1jOgiJQ==
X-Received: by 10.200.39.56 with SMTP id g53mr8952181qtg.134.1490369510026;
 Fri, 24 Mar 2017 08:31:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.3.133 with HTTP; Fri, 24 Mar 2017 08:31:09 -0700 (PDT)
In-Reply-To: <20170324150921.vwh4yqpz25ph3zxe@sigill.intra.peff.net>
References: <CAG+Y4s8m2MqA0yAiZFzv2bAx7g5xktNRb=S-Ej0tvMwU-Un0Og@mail.gmail.com>
 <26915be5-8749-7f66-4d60-516e7ed60adc@grubix.eu> <20170324150921.vwh4yqpz25ph3zxe@sigill.intra.peff.net>
From:   Joan Aguilar <joan.aguilar.lorente@gmail.com>
Date:   Fri, 24 Mar 2017 16:31:09 +0100
Message-ID: <CAG+Y4s8WGwmP7uOsNz4GkR3tsaeB2e1qBysrs-4pqLBKYC+Grg@mail.gmail.com>
Subject: Re: report on a possible bug: git commit -p myfile.py unexpected output
To:     Jeff King <peff@peff.net>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Michael, hello Jeff,

I was writing a response to Michael and I received the Email from
Jeff, so I decided to reply to the second one, with copy to both of
you (and the mailing list too, of course). I hope this is ok for you.

It works exactly as Jeff said.

If I do git show --stat 96d1c24 the output is:
user@machine:~/mygitrepo$ git show --stat 96d1c24
commit 96d1c24*******
Author: Joan Aguilar Lorente <joan.aguilar.lorente@gmail.com>
Date:   Thu Mar 23 18:15:07 2017 +0100

    myfile.py -> old unused methods removed...

    1) mymethod1
    2) mymethod2
    3) mymethod3
    4) mymethod4
    5) mymethod5

 myfile.py | 120
---------------------------------------------------------------------------=
---------------------------------------------
 1 file changed, 120 deletions(-)

But if I add the flag -B (git show --stat -B 96d1c24) the last two
lines are different (as already expected by Jeff) and match exactly
the output of git commit I got yesterday.
 myfile.py | 484
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++----------------------------------------------------=
---------------------------------------------------------------------------=
------------------------------------
 1 file changed, 182 insertions(+), 302 deletions(-)

The output of git show -B is, of course, like the one expected by Jeff too.

Thank you! I learned a little bit about git. And most of all, I
realize there are a lot of options and flags I am not aware of, and
not using at all! I have to read the documentation. I am missing a lot
of git!!

I am sorry that I reported this as possible bug. I guess I was just
confused because the "standard behavior" of "git commit" differs from
the one of "tig" or "git show".

Thank you again and I see you around.

Best regards
Joan Aguilar Lorente
--
Joan Aguilar Lorente


On Fri, Mar 24, 2017 at 4:09 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 24, 2017 at 03:59:07PM +0100, Michael J Gruber wrote:
>
>> > [master 96d1c24] myfile.py -> old unused methods removed...
>> >  1 file changed, 182 insertions(+), 302 deletions(-)
>> >  rewrite myfile.py (60%)
>> [...]
>> > myfile.py | 120
>> > ----------------------------------------------------------------------=
-----------------------------------------------
>> > 1 file changed, 120 deletions(-)
>>
>> 182-302 =3D -120
>>
>> Did you make any changes in the lines that you left? Apparantly, that's
>> what the rewrite looked like to git commit.
>
> Even without changes to the remaining lines, a rewrite diff would
> consider them removed from the preimage and added again in the
> post-image.
>
> The difference between the two commands is that "commit" turns on "-B"
> break detection by default, and "git show", "tig", etc, do not.
>
> Looking at the actual diff with "git show -B" should show something
> like:
>
>   -old
>   -lines
>   -that
>   -weren't
>   -touched
>   -some
>   -lines
>   -that
>   -were
>   -deleted
>   +old
>   +lines
>   +that
>   +weren't
>   +touched
>
> The change is the same no matter how you view it; the "-B" flag just
> asks Git to show a non-minimal diff when the file was substantially
> changed.
>
> -Peff
