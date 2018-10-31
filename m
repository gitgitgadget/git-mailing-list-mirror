Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46BC61F453
	for <e@80x24.org>; Wed, 31 Oct 2018 05:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeJaOhg (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 10:37:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37505 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeJaOhf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 10:37:35 -0400
Received: by mail-lj1-f194.google.com with SMTP id c4-v6so13653626lja.4
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 22:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webstech-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7suMFUetCbACJ//ng3VsryhGZc1RZNdq0RmJYR2/2Ds=;
        b=aR00A3tL5xS6u0V0cvZ0wRqcbk4zvNMSltawQmYCf1KiNIexQWnc79bPftYs0ZN8Ln
         r5SREb4PxKgldR+3dPmE/2D0TORbU0fCvLrIFyt6QLZBvehynZVHxFqAJw5znqykdGmY
         GqfEB+VOfBGcH/PmDEFjePenqtTsz+ZPrvlRfDN6mahSucMgKZeJmLnBLb9v9vLxpLMv
         LEYXYTJra1jl64EA8/IVDq87tU00Ui8woeNvf3B2TV0WXG/NbhJirzEU5xnh1ji7Sc8I
         jM1QiOWrvTcUQ2WSjO9YiByyhbtbzKgC7eYgn/jGCmrlIFYhaT/eGL0XUMOTYGDjoAaR
         V9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7suMFUetCbACJ//ng3VsryhGZc1RZNdq0RmJYR2/2Ds=;
        b=RvpT+s/VUFxj7ZP++sidm7gUOMvfl65AbjcwyFIqFKJ0u5PFv+1EI5Ti++6xQ2Wb/a
         KAWLa4xoDZLWt9evXrKAMYoLdUJ+2pMXGLbZkQsh1RmQEYsJSOHYwCZWRpagWR15rG2N
         jWhE515Q+/jcezjCyjubY/OXr+C4kPWR7gWfUytG9BAsyIzZeWJNRUyKIBDdSPOOGNbR
         CAvF+V/DIlPB/O7PancG857boxyi9ZjOTH2NfUFFlpmOqU2JOHvbtQXunuCWJu9vj7ir
         sz7YY8/Jpp9uwHl36mB84vuXSL34ISLRRhjypHQNaSgvU8iIPZRox1s3RJiwMWAMaKZs
         DuVw==
X-Gm-Message-State: AGRZ1gIeq3g/5Gv/At5XdG3FvRpMGPu20tC84zmjWdnsMj/otje/pXqX
        g6RmHMIIr/Vfn8jVgm8U3kXKB+Iy07tFQSvkvxnC0ijmI94=
X-Google-Smtp-Source: AJdET5e8TCSIhiQR9WBlaTW2aAyJmSAnF2OwkXFQQNQjgDOOm4KQhF0hb7kbCJyZT4OTFzw9B2Zwp/R/lcHNd2JnTtQ=
X-Received: by 2002:a2e:8156:: with SMTP id t22-v6mr993950ljg.32.1540964459035;
 Tue, 30 Oct 2018 22:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.59.git.gitgitgadget@gmail.com> <8159cbd1b8025f33fb9d0e254db1a3c2a066f853.1540923993.git.gitgitgadget@gmail.com>
 <xmqqsh0mwwah.fsf@gitster-ct.c.googlers.com> <CAGT1KpWoGD0xgTrC-+X1WqY_M=2arYbs4ZX6Nnj-zHK6mgu+nw@mail.gmail.com>
In-Reply-To: <CAGT1KpWoGD0xgTrC-+X1WqY_M=2arYbs4ZX6Nnj-zHK6mgu+nw@mail.gmail.com>
From:   Chris Webster <chris@webstech.net>
Date:   Tue, 30 Oct 2018 22:41:15 -0700
Message-ID: <CAGT1KpWC_+=u7fCzQJsU8d_gSQzE5rsx46cTXogvaRPHZ1iiHw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Use correct /dev/null for UNIX and Windows
To:     gitster@pobox.com
Cc:     johannes.schindelin@gmx.de, gitgitgadget@gmail.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Resending in text mode.

On Tue, Oct 30, 2018 at 10:20 PM Chris Webster <chris@webstech.net> wrote:
>
> On Tue, Oct 30, 2018 at 9:54 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "chris via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > From: chris <chris@webstech.net>
>> >
>> > Use File::Spec->devnull() for output redirection to avoid messages
>> > when Windows version of Perl is first in path.  The message 'The
>>
>> Dscho, "Windows version of Perl is first in path" somehow feels
>> contradicting with what one of the topics I saw from you were trying
>> to enforce (or, at least, "set as the supported configuration").
>>
>> I am guessing that the Perl you are building and shipping with Git
>> for Windows would yield what the shell that ends up running the
>> scriptlet `git config --get-color $key` prefers when asked for
>> File::Spec->devnull(), and nothing will break with this patch even
>> if that is "/dev/null", but I thought I'd double check.
>>
>> Thanks.
>>
This problem originally showed up in the
https://github.com/so-fancy/diff-so-fancy project, which has a copy of
DiffHighlight.pm.   That project allows diffsofancy (perl) to be run
from the command line without requiring the bash environment ((well ,
sort of) including the associated perl).
>
>> > system cannot find the path specified.' is displayed each time git is
>> > run to get colors.
>> >
>> > Signed-off-by: Chris. Webster <chris@webstech.net>
>> > ---
>> >  contrib/diff-highlight/DiffHighlight.pm | 7 ++++++-
>> >  1 file changed, 6 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
>> > index 536754583..7440aa1c4 100644
>> > --- a/contrib/diff-highlight/DiffHighlight.pm
>> > +++ b/contrib/diff-highlight/DiffHighlight.pm
>> > @@ -4,6 +4,11 @@ use 5.008;
>> >  use warnings FATAL => 'all';
>> >  use strict;
>> >
>> > +# Use the correct value for both UNIX and Windows (/dev/null vs nul)
>> > +use File::Spec;
>> > +
>> > +my $NULL = File::Spec->devnull();
>> > +
>> >  # Highlight by reversing foreground and background. You could do
>> >  # other things like bold or underline if you prefer.
>> >  my @OLD_HIGHLIGHT = (
>> > @@ -134,7 +139,7 @@ sub highlight_stdin {
>> >  # fallback, which means we will work even if git can't be run.
>> >  sub color_config {
>> >       my ($key, $default) = @_;
>> > -     my $s = `git config --get-color $key 2>/dev/null`;
>> > +     my $s = `git config --get-color $key 2>$NULL`;
>> >       return length($s) ? $s : $default;
>> >  }
