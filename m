From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 1/5] setup: add gentle version of read_gitfile
Date: Fri, 26 Jun 2015 11:09:00 -0700
Message-ID: <xmqqwpyqtk8z.fsf@gitster.dls.corp.google.com>
References: <1434397195-1823-1-git-send-email-erik.elfstrom@gmail.com>
	<1434397195-1823-2-git-send-email-erik.elfstrom@gmail.com>
	<20150626090331.GA4196@peff.net>
	<CAMpP7NbW++B-_OjXN6M3Z1+LW3TJJCnq2L_Jsr-U-Q-rJA5mSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: erik =?utf-8?Q?elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 20:09:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Y3o-0006hB-4l
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 20:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbbFZSJE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2015 14:09:04 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35703 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbbFZSJD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 14:09:03 -0400
Received: by iebrt9 with SMTP id rt9so80729758ieb.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=wJpCVDT+g4P/LvfyoOyfNc7FP5pS0U04H8tLwZmMCfg=;
        b=l+HYcgE21XdfEj9BHcYSG8xo5fIYIS1hx3i7Fa5MmYKKBRacxeUQOPKcYEtU/YLbR8
         s+UQSWYEZmPebR8ZpNIxKd2mjKfTyr4RN7scrObg+0IaWLiHPCbIciSrwh9QnnvW4pq9
         gCyHDD16yxmO+hs2L/jHCFSlZs4mCTBmXQjVPH8lvQ4Z2QePR2tAa4MOajW3R2CRZE6R
         M0f3JNxjHfTSVsto+/7Q9ubr2XwEgvrVFHs5lScs+T3ehGoJxrDSIYYA3m9jQSESHAgl
         G+MXTAzVJ1N3JZvt/s6E/beyiC5lNyS1mUiL7HWoVzyuh7YjA693dAaJuGNHRcMhxWOY
         mLBA==
X-Received: by 10.42.244.4 with SMTP id lo4mr4876073icb.65.1435342142309;
        Fri, 26 Jun 2015 11:09:02 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id fv2sm1302419igb.22.2015.06.26.11.09.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 11:09:01 -0700 (PDT)
In-Reply-To: <CAMpP7NbW++B-_OjXN6M3Z1+LW3TJJCnq2L_Jsr-U-Q-rJA5mSg@mail.gmail.com>
	("erik =?utf-8?Q?elfstr=C3=B6m=22's?= message of "Fri, 26 Jun 2015 19:53:01
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272809>

erik elfstr=C3=B6m <erik.elfstrom@gmail.com> writes:

> On Fri, Jun 26, 2015 at 11:03 AM, Jeff King <peff@peff.net> wrote:
>> I happened to be playing with clang's static analyzer today, and it
>> noticed that there is a subtle use-after-free here.
>
> Doh, sorry about that. Thanks for fixing my bug.

I missed that one while reviewing and queuing.

Thanks, both.
