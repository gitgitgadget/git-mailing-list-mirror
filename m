From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [GSoC] A late proposal: a modern send-email
Date: Mon, 28 Mar 2016 18:49:27 +0200
Message-ID: <CACBZZX6q87dw6UW9z+2bAvvWu0WZcYCMD8gxW8MchHwd8Rv3kw@mail.gmail.com>
References: <CAKqreuyC8p9m_dgVpXCiT_hf=8qBA_5kZ5NABQGx0QDOiCBbww@mail.gmail.com>
 <xmqqzitm2zkj.fsf@gitster.mtv.corp.google.com> <CAKqreux1S2ioEEjPPCkyz1NJnXJ1RyiWdM5thZD607PkL0HKuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 18:49:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akaMT-00083A-Hu
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 18:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771AbcC1Qtt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2016 12:49:49 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33551 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524AbcC1Qts convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2016 12:49:48 -0400
Received: by mail-qk0-f177.google.com with SMTP id s5so119515084qkd.0
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 09:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zohlwr9sr3tcQ1tS+08NaQRnxj559qLVAg0pYfLSmEU=;
        b=TVIL51Yx4gcuPlSIe3Cw+pyk4yGKOHCQQbFVNyCMm0SnD5oOvijAtnAMrIdIQbvDcn
         pRNbCon8tBjoT/ROzFcrvpGStPZGJYiMm+6LTqNkV+B1+i5Ussv8zDH0gcEOhWXi3FDX
         7vLZtXvzfwHZ2fyxg2Tcc4nloBWNhpZ1/bdmKVKnJykA7otfDeMjKEFVDgJp8vcZ5k69
         n8K2LtR941gZRyZvHkKytvhSx3/GcqLxbu1xtb5UGHN/TYNU7hlqJqG8QCP4S/++hDGv
         KsA0gRUg9lBvBIh/tzcr84xgMS5+4AEoPBmZuluzkgvai+Smpj0W+VzPK/d+GOaqjSU7
         2kIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zohlwr9sr3tcQ1tS+08NaQRnxj559qLVAg0pYfLSmEU=;
        b=l4RBDR8H+PJpwUPW7dYKkxsCwhWvlDWRy9JOdBviLsBN6AyVo0zSWQ3Xga2yAMTOUt
         GD3qX7Q32aomJOVaN3lTUtzrChjXSmiS8kHKy/MJjLVaC23cIUznEXPs2Xh5pH4gHTji
         kflgwcla4QinoVLr18N3R5qF96m2Af6j1WuQwLLD0azgqxuf/NDJgLTcolXWUTZ+1wM6
         k2QBDmE1Kb+Ah+Ss7T2RJqclll7VAa/XnmmVTdqj5UPbXmq5HI2rBV0WuPEZw7dQhf15
         bXhHDEms0b/mIOmlOhFoMEalhZrbidrahQzRgWV/3sKWJG9CGCZa/qIWBBcJp9vSROxA
         jvnw==
X-Gm-Message-State: AD7BkJKHENRGuIAu+SZo6qCQUiaZyJyO3Jl3Th6BbeWe7yIlEZS4Jm+f7YcZvXRVWIlH6z16LtPV2f3XlxqSyQ==
X-Received: by 10.55.74.75 with SMTP id x72mr37030705qka.100.1459183787579;
 Mon, 28 Mar 2016 09:49:47 -0700 (PDT)
Received: by 10.55.77.82 with HTTP; Mon, 28 Mar 2016 09:49:27 -0700 (PDT)
In-Reply-To: <CAKqreux1S2ioEEjPPCkyz1NJnXJ1RyiWdM5thZD607PkL0HKuQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290046>

On Sat, Mar 26, 2016 at 3:13 AM, =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@=
gmail.com> wrote:
> 2016-03-26 2:16 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
>> =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:
>>
>>> # Purpose
>>> The current implementation of send-email is based on perl and has o=
nly
>>> a tui, it has two problems:
>>> - user must install a ton of dependencies before submit a single pa=
tch.
>>> - tui and parameter are both not quite friendly to new users.
>>
>> Is "a ton of dependencies" true?  "apt-cache show git-email"
>> suggests otherwise.  Is "a ton of dependencies" truly a problem?
>> "apt-get install" would resolve the dependencies for you.
>
> There are three perl packages needed to send patch through gmail:
> - perl-mime-tools
> - perl-net-smtp-ssl
> - perl-authen-sasl
>
> Yes, not too many, but is it better none of them?
>
> What's more, when I try to send mails, I was first disrupted by
> "no perl-mime-tools" then by "no perl-net-smtp-ssl or perl-authen-sas=
l".
> Then I think, why not just a mailto link?

I think your proposal should clarify a bit who these users are that
find it too difficult to install these perl module dependencies. Users
on OSX & Windows I would assume, because in the case of Linux distros
getting these is the equivalent of an apt-get command away.

If installing these dependencies is hard for users perhaps a better
thing to focus on is altering the binary builds on Git for platforms
that don't have package systems to include these dependencies.

In this case it would mean shipping a statically linked OpenSSL since
that's what these perl SSL packages eventually depend on.
