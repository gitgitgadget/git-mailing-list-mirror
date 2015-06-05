From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Suggestion: add author info to TODO list in git-rebase--interactive
Date: Fri, 5 Jun 2015 15:39:32 -0400
Message-ID: <CAPig+cS0dW=KpD3C_6ugiJTccQqNu1NopcU6Pc71hf6iLLbcfw@mail.gmail.com>
References: <CANoM8SWX+UVWdV-Aeqqn8DuMf74zUWx=rbEaz3ctNDwa_ZZbeg@mail.gmail.com>
	<xmqq8ubyrlsc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mike Rappazzo <rappazzo@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 21:39:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0xSr-000399-Vd
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 21:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbbFETjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 15:39:33 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36861 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbbFETjc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 15:39:32 -0400
Received: by ieclw1 with SMTP id lw1so64908291iec.3
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 12:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=DF9OeNcs/z3uPzS3bw0wGb748kmUM4JOchHiCpRT2kA=;
        b=aALhHZeRfX0TxIsIhy7JegifsJ1pjVh12U4WRkKVngqS4uqQBOUtBJILp8ArGwhzW0
         KThTjGFPfL5+5T4IAsMDIrTJejxqFVeq+jZ0sBwgt1tTXEIvwNjHN1dPJE5BvQbT/kDz
         UcN/fCeZX6WHKsSYIC+gB0GKoRGjNljYN9FKc/w0cSnLZYEnV2nebmbcDZE+0YvPNXs/
         gcwi/jKOaxIDwVYhm3K89WhnEYUELZy+Ny8qYtXCuJXs5GOr5avi9Hci2ZjFuCUtH01a
         Sz/Mm876AP1JHq8d5A9yVofqkp9JOEY0jT2zKgu+RpaTHdLMprX5AtvFw75EVlNOSo8i
         YEWA==
X-Received: by 10.50.66.234 with SMTP id i10mr14693450igt.22.1433533172089;
 Fri, 05 Jun 2015 12:39:32 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 5 Jun 2015 12:39:32 -0700 (PDT)
In-Reply-To: <xmqq8ubyrlsc.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: IogtWLW-4yFa9g6IuKRyVi9P1Io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270877>

On Fri, Jun 5, 2015 at 3:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Mike Rappazzo <rappazzo@gmail.com> writes:
>> I find that If I am doing a rebase with the intention to squash or
>> re-order commits, it is helpful to know the commit author.
>
> There is not a fundamental reason why the remainder of the line
> after the object name in the rebase insn sheet should not be
> customizable, and I think your patch is a good first step to
> identify where that customization should go.
>
> But that is a customization issue, not changing the default and the
> only format used.

The idea of being able to provide a custom format for insn sheet lines
came up within the last year and was somewhat more well-developed and
a bit more heavily discussed. I don't recall whether there was an
accompanying patch, and I am unfortunately unable to locate the
discussion in the archive.
