From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v3 00/19] new git check-ignore sub-command
Date: Fri, 28 Dec 2012 19:39:46 +0000
Message-ID: <CAOkDyE8gfW9TvyP=iE7gVEXOqCpOqMRjpr=Vnyd_pnummy4Qsg@mail.gmail.com>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
	<7v38yqj9ix.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 20:40:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tofmx-0004Mo-S8
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 20:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235Ab2L1Tjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 14:39:52 -0500
Received: from mail-wi0-f177.google.com ([209.85.212.177]:47102 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932148Ab2L1Tjs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 14:39:48 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm2so6083931wib.4
        for <git@vger.kernel.org>; Fri, 28 Dec 2012 11:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=5m5VmyFdUpUkzkppt11wNU+xmQSsCqkBByGaoNGJSWk=;
        b=DQwYU4ozT8xIwz50WcUz3rYlAsZj4xcsM0oT04ZSdrWrJKBVgimQeWlJhIBcF4hXrV
         2C69p7tixOrq3bpcDXdPdwUkyzPkaTrRthP/5HAr1tJNZ7kkL1kCftMtZITa1Ry3zruy
         etkr8KkIc0v1CnK9O/MSadLxbXDSlj9d1LpFc5e8hEgGbwV3MRRm2Qflz9/3MGhlDuSr
         0H/bwMB9TzNQZTM3McAnaQjg4Li4NrB7H2e5HESCsQzG9kFAPLqzDO+5lTQe6BdrwH+X
         /Mpm/QWNH8PNHy3bPtnXHxX1GQVzaUeJvjrhjv/FYdPTOgw9NCDqmTDgFOGgVmh9O2T1
         H2hg==
Received: by 10.194.85.234 with SMTP id k10mr55097674wjz.53.1356723586468;
 Fri, 28 Dec 2012 11:39:46 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Fri, 28 Dec 2012 11:39:46 -0800 (PST)
In-Reply-To: <7v38yqj9ix.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: D3sgqdvHHIv-7fT-E9nZmayMw30
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212253>

On Fri, Dec 28, 2012 at 6:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Spiers <git@adamspiers.org> writes:
>
>> This v3 re-roll of my check-ignore series is a reasonably substantial
>> revamp over v2, and applies on top of Junio's current
>> nd/attr-match-optim-more branch (82dce998c202).
>
> Thanks.
>
> Does this (and should this, if it doesn't) interact with the more
> recent discussion around "git status --untracked/--ignored" [*1*],
> which also wants to touch the recursive directory traversal logic in
> "dir.c"?

I cannot think of a reason why they would or should interact.  If I'm
wrong, I expect that either set of unit tests would show me up :-)
