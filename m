From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v12 1/5] t0040-test-parse-options.sh: fix style issues
Date: Tue, 5 Apr 2016 10:38:09 +0530
Message-ID: <CAFZEwPPPf3OUb8rL-juL3dMXZamwsTO2e+pLg3y8grdJf6W6YA@mail.gmail.com>
References: <01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
	<01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
	<CAPig+cQ+89MZSyHJhCrZsGMc7mM_uorE5j9GXk7kCTT1OTXV6Q@mail.gmail.com>
	<CAFZEwPNaxFyFmCkvPjRZQ0grOm1oWB1+5QhkpOMyEKW7j_99qQ@mail.gmail.com>
	<CAPig+cQw=aG0NOgEsmdTGc7v3iBA-qG9_C4EdSm=6PcE6Qn-uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 07:08:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anJDs-0005zx-NZ
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 07:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbcDEFIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 01:08:11 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36454 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbcDEFIK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 01:08:10 -0400
Received: by mail-yw0-f194.google.com with SMTP id p65so344784ywb.3
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 22:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Vcspa+G/EsapOpgqVoO3NN00tGHW0dWIOGwpVxlhbHM=;
        b=lLM5wAdnfa4c7RBEb+NQOgk8tg4EivWpFpZLofF/UBIA4s32kI+hv6gixt1hvAMAVv
         pYRkER9ECS6IkFb/QIz4p+Gi0+A3v3eoFhqqsn79IzZaYnXiKMqQV3YcGGRoJNDE3k81
         RKUIYOjb3eCRbrp6hAmlw5FRPdXzyWRCY7Dd6RYR754oVOMvbnUQ+RhXHGhVbjS4hpJ2
         l3yl20sEJ7nZDudusFg0+4d3rYb+L7M5r3cBWTg+7ZgJudIUQ3goVSiqV0cEAgvt6CbA
         T1QZlcb1i5d+pOj/2jvt539dE/zD4UEvNsIsvyzosaqVjLPrJHvCQ/hOWdzYvG20K9tH
         EFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Vcspa+G/EsapOpgqVoO3NN00tGHW0dWIOGwpVxlhbHM=;
        b=nF69n9bE5CpsaRjyFL8TIZoR7GEP9AWvcoFEnjaBG75qAj9lFqFo+54RYziNQngNB2
         kCZYo/r52fbugFIubK86GJ9bQV2Izf/bTq0GE/r+/TALgigRgAJlEBfJGBO8MZpmcpVD
         ZkncjytfoTnJUSv27D4A99vodk7yUZGLObqxnfu5moacmbvrJfI4ytbgH8+E8C8EAMlZ
         59ImAuSEWRdkuwhBlW5xrM3kq1Nk5xpXhXadT/DDnDD/dmGL5aibhuQfdpRS0Zeux1Q0
         j6OWHvhI5EaljDuHkj+Cs7Wd7HdG2ZsjF26MDRwk6z52qP8jnBQmdqSuO+87BWW+mR+f
         lY5A==
X-Gm-Message-State: AD7BkJJWaq9TCZHTwRjerD2+l4nJi5ua2ljLssyymxTBsMsK+OytaQlC/UYZdyejJkEhrqrvXfODULizeUsvrw==
X-Received: by 10.129.94.194 with SMTP id s185mr7416995ywb.93.1459832889702;
 Mon, 04 Apr 2016 22:08:09 -0700 (PDT)
Received: by 10.13.219.81 with HTTP; Mon, 4 Apr 2016 22:08:09 -0700 (PDT)
In-Reply-To: <CAPig+cQw=aG0NOgEsmdTGc7v3iBA-qG9_C4EdSm=6PcE6Qn-uQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290759>

On Mon, Apr 4, 2016 at 11:00 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Apr 4, 2016 at 8:45 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Okay I will do the change. I was previously unaware about the use of
>> '\' before EOF. I googled it now. But I am still confused about its
>> use in this scenario. Upto what I understood, it is used where you
>> want to expand a variable, substitute a command, arithmethic
>> expansion. The use of '\' in the tests I have changed in v12 wrt 11 is
>> understood by me as you want to remove the use of escape sequences
>> which is justified. But this seems a bit vague. Is it some convention
>> in git?
>
> Both 'EOF' and \EOF suppress interpolation and other transformations
> in the heredoc content which would otherwise occur with plain EOF. The
> 'EOF' form is well documented; \EOF not so much, but is used heavily
> in git test scripts. So:
>
>     x=flormp
>     echo <<EOF
>     Hello, $x
>     EOF
>
> prints "Hello, flormp", whereas:
>
>     echo <<\EOF
>     Hello, $x
>     EOF
>
> prints "Hello, $x".
>
> While test scripts sometimes use \EOF to explicitly suppress variable
> expansion, it's also quite common to use it even when there is nothing
> which could be expanded in the heredoc content, in which case it
> signals to the reader that the author doesn't expect the content to
> undergo expansion or interpolation. It's also a bit of future-proofing
> in case some later change to the heredoc content inserts something
> which might otherwise be expanded.

Thanks for taking out your time to explain this clearly. I will do the
changes in the tests as suggested by your review. :)
