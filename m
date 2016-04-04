From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v12 1/5] t0040-test-parse-options.sh: fix style issues
Date: Mon, 4 Apr 2016 13:30:36 -0400
Message-ID: <CAPig+cQw=aG0NOgEsmdTGc7v3iBA-qG9_C4EdSm=6PcE6Qn-uQ@mail.gmail.com>
References: <01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
	<01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
	<CAPig+cQ+89MZSyHJhCrZsGMc7mM_uorE5j9GXk7kCTT1OTXV6Q@mail.gmail.com>
	<CAFZEwPNaxFyFmCkvPjRZQ0grOm1oWB1+5QhkpOMyEKW7j_99qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 19:30:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an8Ku-0007EL-5G
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 19:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597AbcDDRai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 13:30:38 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:34662 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbcDDRah (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 13:30:37 -0400
Received: by mail-ig0-f195.google.com with SMTP id qu10so9787357igc.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 10:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=xsr9uxxYB9BkCdzY2ZWuOGVMW7SirHr+rpb7qdvcubk=;
        b=TMV7lZ2Y6U/IDAZL93XmTtW8SQq1Hmg3mcmW2I+Mam3jAcpytQqaV9hRZzOc9gDvye
         yl78gg/xNU4WlNjG/BMpDL3Zowr1npREwtBzuqRoFu2RjE68slQt18bfwFSSsvCt9nEt
         mzrf9TR3u+6+VzTEoXu2r8eJn42B9HnMIm1ORR3lR5oghMcWLzfuVT3HNJjI9k9HXfWf
         t+mTF3eSnLNmge2I8LcK69S4N8k6dsAUddeYBPaqMK5yG1adXeSxtxOmL8MZbyrtzbkR
         gSSRWTrnWCRjsUrojnjUBl7zKJblkv2xk8MXU9RLlXuBBEi4+p+G8VU4eT3HK87yrfn2
         wObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=xsr9uxxYB9BkCdzY2ZWuOGVMW7SirHr+rpb7qdvcubk=;
        b=XqE6YsQtkjfauxtRsl9FHJbn3JhYYOOO3yZg336taxauy4GCuUhm4LL9Jt23JJz+se
         ati0l8RH/wRezE+3Wt2o5SUKRGNslPVRJ2Y0/8d1gX3PhQzXnBgESqdHj09vmqyyHDV1
         oEkMNhFO3QaSwZn3/UxipkhSPYj0QSFY5uoeQ0iIHQtV8inpH2hUxzyJn/gBxhpWnVcK
         L95EMvEp4QW6pk3fZB0sYaAxP/AOJI/ZSjWwiQr60FwFdN/2Ku+52ktXN8fUXjpE625j
         dFemO661G9m0DaEeHLQiHEKZu1ddbKPTdwLQHDk5my0teBpqr53Mdj7zJWYfwVOoWirT
         LDeA==
X-Gm-Message-State: AD7BkJKgtCVAAto8+cD1F650Fs1V6B5higf1XagvqLDuzUWhmUCrZ7lO9xC8vaEYa2wpkrhcuei9uqQHwBxN0w==
X-Received: by 10.107.130.138 with SMTP id m10mr11603412ioi.34.1459791036332;
 Mon, 04 Apr 2016 10:30:36 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Mon, 4 Apr 2016 10:30:36 -0700 (PDT)
In-Reply-To: <CAFZEwPNaxFyFmCkvPjRZQ0grOm1oWB1+5QhkpOMyEKW7j_99qQ@mail.gmail.com>
X-Google-Sender-Auth: t8k_X8iKUrvJ4BdaPCu0Awteo4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290703>

On Mon, Apr 4, 2016 at 8:45 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Okay I will do the change. I was previously unaware about the use of
> '\' before EOF. I googled it now. But I am still confused about its
> use in this scenario. Upto what I understood, it is used where you
> want to expand a variable, substitute a command, arithmethic
> expansion. The use of '\' in the tests I have changed in v12 wrt 11 is
> understood by me as you want to remove the use of escape sequences
> which is justified. But this seems a bit vague. Is it some convention
> in git?

Both 'EOF' and \EOF suppress interpolation and other transformations
in the heredoc content which would otherwise occur with plain EOF. The
'EOF' form is well documented; \EOF not so much, but is used heavily
in git test scripts. So:

    x=flormp
    echo <<EOF
    Hello, $x
    EOF

prints "Hello, flormp", whereas:

    echo <<\EOF
    Hello, $x
    EOF

prints "Hello, $x".

While test scripts sometimes use \EOF to explicitly suppress variable
expansion, it's also quite common to use it even when there is nothing
which could be expanded in the heredoc content, in which case it
signals to the reader that the author doesn't expect the content to
undergo expansion or interpolation. It's also a bit of future-proofing
in case some later change to the heredoc content inserts something
which might otherwise be expanded.
