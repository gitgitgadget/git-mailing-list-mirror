From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] t0005: test git exit code from signal death
Date: Sat, 1 Jun 2013 16:41:36 -0500
Message-ID: <CAMP44s0skh8LGFpNNfTfYn0sMrmKi=s0hV=SZwW2mT_F8KKSzg@mail.gmail.com>
References: <1370094715-2684-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8Df-O=D5LQBXCbiVLB=uHfn6ETbAxADWq3hd-9pPX4+mg@mail.gmail.com>
	<CAMP44s0L1M+_s2eDM=Ogy=rxLhpZYwSb8qWTuEe30pB4KGDVtA@mail.gmail.com>
	<CACsJy8BFv7kJkymJ_rj9dwaN-zMcHtS9sjmqDSpLWB5TsUU_kg@mail.gmail.com>
	<CAMP44s2cBGc+uKH0t-KZko-5GYkZUK54+7wiYbWim55B7KGaGA@mail.gmail.com>
	<20130601172441.GB19234@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"John J. Franey" <jjfraney@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 01 23:41:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UitYU-0000NA-6j
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 23:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509Ab3FAVlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 17:41:39 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:55250 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590Ab3FAVlh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 17:41:37 -0400
Received: by mail-la0-f50.google.com with SMTP id ed20so2400737lab.9
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 14:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ejO+zGPHARPJN59LCxn6TamhQHHA/g/kWHiyPKe9lgw=;
        b=KGM5RoNZ13Pl5hZQM/dVZqvztGIDsb/orxILaLoOYFqIF57upzGeIw0TIUnTeQuvEC
         Lv+ZUgoQ1TUYVKZOnwot40pMtS/431eMoqoKfd7bv9Q2DJyWLpd4gBDYeJlEeBnY75Fo
         IlLf7/X3XLjofAXC0gh64kwTrFC/AzX6G3+1ASFQ76NrfXaC9QEFhgPGq1DXDveDIV5G
         yckiZ/+6DwYfbElJ7W1BLxfTkaqRTwnZ5tlrvmFUWXrUfI+Po20vevYoGCxYbGZM4iY3
         fbquhuOSNLeC+iAiSFJVWJ7AGBvwvoP5pbqOkb98I6fHGFRkqIb72mAV/w3o3YM+Q5cM
         jBPg==
X-Received: by 10.112.33.17 with SMTP id n17mr8209102lbi.72.1370122896351;
 Sat, 01 Jun 2013 14:41:36 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Sat, 1 Jun 2013 14:41:36 -0700 (PDT)
In-Reply-To: <20130601172441.GB19234@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226148>

On Sat, Jun 1, 2013 at 12:24 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Jun 01, 2013 at 10:01:49AM -0500, Felipe Contreras wrote:
>
>> Anyway, if you care so much about the current behavior, why isn't
>> there any tests that check for this?
>>
>> My patch passes *all* the tests.
>
> The test suite has never been (and probably never will be) a complete
> specification of git's behavior. Noticing that a desired behavior is not
> in the test suite is an opportunity to improve its coverage, not argue
> that a change which breaks the desired behavior must therefore be
> acceptable.

Nobody did such a thing. I asked a question, and it's good that you
are answering by filling the missing test-case.

-- 
Felipe Contreras
