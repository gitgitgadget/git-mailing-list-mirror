From: Paul Tan <pyokagan@gmail.com>
Subject: Re: What's cooking in git.git (May 2015, #07; Tue, 26)
Date: Fri, 29 May 2015 18:39:12 +0800
Message-ID: <CACRoPnSYue6XBwF=KiPi-C=a3d9aAcOfS7ac=BZCue46EUsWTA@mail.gmail.com>
References: <xmqqegm3j9jo.fsf@gitster.dls.corp.google.com>
	<xmqqa8wofjyl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 29 12:39:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyHh9-0003ba-7u
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 12:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856AbbE2KjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 06:39:15 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:34909 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839AbbE2KjO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 06:39:14 -0400
Received: by labko7 with SMTP id ko7so48905624lab.2
        for <git@vger.kernel.org>; Fri, 29 May 2015 03:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=flfVaQo9YmqlU3XOZiDMsKdyAsaowSZP/5wtn1tYDXY=;
        b=nlC8bEgMWKtN//AUx9+yOgMDYvwVNY5q3m8VsULUgEPlFoak1auU2x+IV8qvsguoMB
         FresF+b5Q21gM32aoEmpLnzGbzN9AQYQmm9QpY14G5eK916JwoOewyRJR8cyopIVTF7p
         h1+DIBRwlP+xKy2z02YtvNC8XruF7ijM70dmyKR30vJkGtNv4cEaMLani19gKvhqzrzr
         NubbIy2T0fCODur9j1Ic+Ehe8WGeYC3QX30ti7c3pfqHWcymGi61AzenHCgPqd8RE5HN
         zdter75ieL6YQ5VGmjqdj7Qsi5h00fp3tnXGVKTxGId9uiVFLilvjAWwY7DBWrqNPyek
         cC6g==
X-Received: by 10.112.182.4 with SMTP id ea4mr1893725lbc.35.1432895952517;
 Fri, 29 May 2015 03:39:12 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 29 May 2015 03:39:12 -0700 (PDT)
In-Reply-To: <xmqqa8wofjyl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270221>

Hi,

On Fri, May 29, 2015 at 5:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> * pt/pull-tests (2015-05-18) 8 commits
>>  - t5520: check reflog action in fast-forward merge
>>  - t5521: test --dry-run does not make any changes
>>  - t5520: test --rebase failure on unborn branch with index
>>  - t5520: test --rebase with multiple branches
>>  - t5520: test work tree fast-forward when fetch updates head
>>  - t5520: test for failure if index has unresolved entries
>>  - t5520: test no merge candidates cases
>>  - t5520: prevent field splitting in content comparisons
>>
>>  Add more test coverage to "git pull".
>
> Sorry, but I lost track.  What's the doneness of this one?

Not done yet, but I'm working on it now, so if I don't have any issues
I'll have a re-roll out by the end of today or tomorrow.

Thanks,
Paul
