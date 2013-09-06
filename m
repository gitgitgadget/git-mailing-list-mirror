From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/5] t2024: Fix inconsequential typos
Date: Fri, 6 Sep 2013 22:53:04 +0200
Message-ID: <CALKQrgeyWzV_BxceHL9+NP9nnJXRbTYM1GuuW8aTPpZk-7MEJw@mail.gmail.com>
References: <1378464042-17476-1-git-send-email-johan@herland.net>
	<1378464042-17476-2-git-send-email-johan@herland.net>
	<xmqqwqmtyhxs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Per Cederqvist <cederp@opera.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 22:53:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI31p-0000ey-3x
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 22:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036Ab3IFUxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 16:53:12 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:49950 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab3IFUxL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 16:53:11 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VI31g-0007Ev-Pj
	for git@vger.kernel.org; Fri, 06 Sep 2013 22:53:08 +0200
Received: from mail-pd0-f176.google.com ([209.85.192.176])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VI31g-000HgR-Bw
	for git@vger.kernel.org; Fri, 06 Sep 2013 22:53:08 +0200
Received: by mail-pd0-f176.google.com with SMTP id q10so3729355pdj.35
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 13:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0dNsQzKeDX6FMDhXzQqAhZHA5F3IYTR3k2VhtTHH4yA=;
        b=QkiMxJjZsgQH1efE7QZaNk8iSr061DBEx+K5UteIxWaAHrpTP1pOyBvMoQDkGIruTk
         QnG3efQEceHLkh5LDjLvd/Eci6vMLxqaJYJy5kjSp8HQ4Ku7ARa772t2miDlRnPGzXCq
         sG+3pMhcrLuRDUDvFKgiNyCClcij0GgdkGEk4D8+PfgjNiZSoMagbUB3WaQkED/E9otN
         8Gq6OqPqjnBY5TGv+20cYCtFIafhKR58lcYKi1g8+xyR67fCWFPFt1v+/VL8AmGc7ear
         pVyUcQsAFYYoL+5DsTOys+/H55kqLFMlvM+4RLn2mUeO/8uWhBxbhlcoT7YPUllR0dfN
         hBWQ==
X-Received: by 10.68.189.98 with SMTP id gh2mr4990830pbc.181.1378500784516;
 Fri, 06 Sep 2013 13:53:04 -0700 (PDT)
Received: by 10.70.126.67 with HTTP; Fri, 6 Sep 2013 13:53:04 -0700 (PDT)
In-Reply-To: <xmqqwqmtyhxs.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234096>

On Fri, Sep 6, 2013 at 7:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>> diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
>> index dee55e4..6c78fba 100755
>> --- a/t/t2024-checkout-dwim.sh
>> +++ b/t/t2024-checkout-dwim.sh
>> @@ -113,9 +113,9 @@ test_expect_success 'setup more remotes with unconventional refspecs' '
>>               cd repo_d &&
>>               test_commit d_master &&
>>               git checkout -b baz &&
>> -             test_commit f_baz
>> +             test_commit d_baz
>
> Not limited to this hunk but there seems to be a breakage in the &&
> chain here.

Thanks, found 2 instances in the file (both in that test). Will be
fixed in the next iteration.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
