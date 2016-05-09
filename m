From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: t6044 broken on pu
Date: Mon, 9 May 2016 17:27:54 -0400
Message-ID: <CAPig+cQopZta6bs8JBV23iP4xpaPk2Y4UZ5E6rWeTEtYxW=uJA@mail.gmail.com>
References: <7d747193-7ba1-e274-86dc-427ed0f124c9@web.de>
	<878tzmrrfg.fsf@linux-m68k.org>
	<d1fcc54b-ddd7-b03b-79fa-2112a3f43141@web.de>
	<xmqqa8k11e8j.fsf@gitster.mtv.corp.google.com>
	<5618208c-ce45-d65c-abf8-498cfe0f2f84@web.de>
	<xmqqoa8gza1t.fsf@gitster.mtv.corp.google.com>
	<CANgJU+V9+-hTFvDxCGbQxFcHMRcFaP-NdS_P93DqXuxi1Lh4mg@mail.gmail.com>
	<20160509083323.GB14299@sigill.intra.peff.net>
	<CAPig+cTyEU1gEwD5AuODkLzF--EOqo5_MQHD5QEFpb8dgh_wrw@mail.gmail.com>
	<20160509161226.GB11861@sigill.intra.peff.net>
	<xmqqr3dbulyp.fsf@gitster.mtv.corp.google.com>
	<xmqqh9e7ulie.fsf@gitster.mtv.corp.google.com>
	<xmqqeg9bszw0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, demerphq <demerphq@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Elijah Newren <newren@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 23:32:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azsij-0005S2-8V
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 23:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbcEIV14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 17:27:56 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:32839 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbcEIV1z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 17:27:55 -0400
Received: by mail-ig0-f193.google.com with SMTP id rc4so12437105igc.0
        for <git@vger.kernel.org>; Mon, 09 May 2016 14:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=2gHhRlVruCT1RLKwGGWNmDjHJYKr5IPIHh3DIUd1idA=;
        b=Eh0y1B0Nj7DF6X2kZM/fMNjoxaWuLJKE3fioMYiWTXjkKnyPMF5ci4Jk0GdapIwAhi
         BCej+RviDj0Pb/AmfvypYfh1K18y+Z/ZmDPYNZWdYW1PSOBSRmNxH3rgvxjUqze50z4K
         r9gZ6UBmQJac+M0p3U6n0X2SySYxYfevYJrhMyDnWY0zuP9ofMMrMaNX9BTxhemoULda
         8ZwVsPKBrO+x39wOjQ0Tvsa+jJGU4HP19Iho6w9sEDw6HZVq4sGyk4QdfHQFYGXVm6IN
         S3ad+j1jmQQdP+qQCX2bo/9WhUTS73iQ29f80OJfwoA4+lRzqYrK0MkIvfH4puuE8Qjs
         5UpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=2gHhRlVruCT1RLKwGGWNmDjHJYKr5IPIHh3DIUd1idA=;
        b=dNvZ3yMCOdm0vqpQgrQ9wagggqXnyBPszjnuwm/pFhi6KJKyzWX9fHRkqDWBdgRO9F
         JjFr0bDmOHD1nJ6fMC6/RKMvAWwvQlNAJTPpc7GWdJKvo1lTU7vg5Kk2APvLI8yw9IX+
         G0Qb4BfMffz4nCPfzMTFSCFuCxxbs8gDjobWx1VV9eekV94yz5KbQpwSdg/q5bc0vEHb
         TfAf7MB6zNnO7OHcda/uwAefa6LLBZATvgyltO8IuKiOeRfgtro0ry2WbsK/aMD4jfrS
         kefcQ+is+8VFTQP/ukHoo2Fse6ht23rfoehrsz9z05wrBEcoGGOKTjRWV9RUAtJp3SK1
         ZlaQ==
X-Gm-Message-State: AOPr4FXJrjC+FLJy+Wx+dFrqtbnKHdQauvAj4Spkr/sbTkBInhh2XuwVvbzTq/NMpzAhK/SQpPRIyD0RJ5h03w==
X-Received: by 10.50.3.105 with SMTP id b9mr13483677igb.17.1462829274526; Mon,
 09 May 2016 14:27:54 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 9 May 2016 14:27:54 -0700 (PDT)
In-Reply-To: <xmqqeg9bszw0.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: tvFOBhKnTcP6xe_L11n0i2ZIZEI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294072>

On Mon, May 9, 2016 at 5:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Subject: [PATCH] test-lib-functions.sh: rewrite test_seq without Perl
>
> Rewrite the 'seq' imitation only with commands and features
> that are typically found as built-in in modern POSIX shells,
> instead of relying on Perl to run a single-liner.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -679,7 +679,12 @@ test_seq () {
>         2)      ;;
>         *)      error "bug in the test script: not 1 or 2 parameters to test_seq" ;;
>         esac
> -       perl -le 'print for $ARGV[0]..$ARGV[1]' -- "$@"
> +       test_seq_counter__=$1
> +       while test "$test_seq_counter__" -le "$2"
> +       do
> +               echo "$test_seq_counter__"
> +               test_seq_counter__=$(( $test_seq_counter__ + 1 ))
> +       done
>  }

Looks (obviously) correct and works as expected on Mac and BSD.
