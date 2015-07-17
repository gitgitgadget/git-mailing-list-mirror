From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: A few "linked checkout" niggles
Date: Thu, 16 Jul 2015 23:11:15 -0400
Message-ID: <CAPig+cSB67wMs0T4OE9YS=2067bTvHeidx32PDGtu4O4q=nT2Q@mail.gmail.com>
References: <xmqqoajdui8w.fsf@gitster.dls.corp.google.com>
	<xmqqd1zr4z28.fsf@gitster.dls.corp.google.com>
	<CACsJy8CC_fju1Vy-hN69rKdpZ=XDUdZ_H_pmUb0bJdt-LdiPew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 05:11:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFw3U-00084N-R3
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 05:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbbGQDLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 23:11:16 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36349 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbGQDLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 23:11:16 -0400
Received: by ykay190 with SMTP id y190so80102348yka.3
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 20:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RFLgI+EM5ydAU3FKCdlRYU4X6TVrCpZRmOjKT2oe2Xg=;
        b=Qn4t5yanHsQDpXhEEE8TMGvxO/+0sfTKDT6iuz25SM0V5TUkZOZMbHgHYU1zeChoEU
         zbuq+M6QcoNZ5v3+yJT/Shm0Bqhw0l8Et/v0v/2viGi3xrmXTaDeacTCWSQPl/gQC9lB
         BMNQNWPZIZs4jpDl+2Uhg0VnOizrZU85yyrP8ECFPSXVrFSkWK+elnPPaBP5RBW2lpb6
         rdqyTl0FzBoZzhCY3aqm7vS3kqL0xBN/65j3kt2BIpWWVE0KgR5mwJwn5+TM8GlXGT/K
         jh98aGLMtMkOM0XZ/t/QjMlpkE7RqFtti+fRJjp0KbfNCRR2WZFjiUfB0HTSMOXD66Oh
         a5uQ==
X-Received: by 10.170.97.9 with SMTP id o9mr13399687yka.84.1437102675451; Thu,
 16 Jul 2015 20:11:15 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 16 Jul 2015 20:11:15 -0700 (PDT)
In-Reply-To: <CACsJy8CC_fju1Vy-hN69rKdpZ=XDUdZ_H_pmUb0bJdt-LdiPew@mail.gmail.com>
X-Google-Sender-Auth: zUGaTCKXlc4DicDso9KL8pslv1M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274057>

On Thu, Jul 16, 2015 at 7:13 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Jul 17, 2015 at 3:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Also in a linked checkout of git.git itself, t5601.21 seems to fail
>> with:
>>
>> fatal: Not a git repository: /home/gitster/w/src/.git/worktrees/rerere
>> not ok 21 - clone respects global branch.autosetuprebase
>> #
>> #               (
>> #                       test_config="$HOME/.gitconfig" &&
>> #                       git config -f "$test_config" branch.autosetuprebase remote &&
>> #                       rm -fr dst &&
>> #                       git clone src dst &&
>> #                       cd dst &&
>> #                       actual="z$(git config branch.master.rebase)" &&
>> #                       test ztrue = $actual
>> #               )
>> #
>>
>> This test is running in /home/gitster/w/rerere, whose .git points at
>> that directory the fatail: message complains about.
>
> I can't reproduce with either master, next or pu. Seems strange that
> git.git info is leaking into this test..

I also am unable to reproduce the failure...
