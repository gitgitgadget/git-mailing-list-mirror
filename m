From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v3 1/9] t5520: fixup file contents comparisons
Date: Sun, 17 May 2015 15:47:51 +0800
Message-ID: <CACRoPnTLaJ+4Vc0Dg2rZxO2P3WUxF8++OUi24An00xNSbvTk6A@mail.gmail.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
	<1431508136-15313-2-git-send-email-pyokagan@gmail.com>
	<xmqqk2wcbmq5.fsf@gitster.dls.corp.google.com>
	<xmqqa8x8bkuc.fsf@gitster.dls.corp.google.com>
	<CAO2U3QgD0-tAwGnMeeMR5aqbUuqDsdWy0Sw8dQBPUpUNwJZpHg@mail.gmail.com>
	<xmqq4mnf8358.fsf@gitster.dls.corp.google.com>
	<CACRoPnSbekLANNiGOyxN70TCUd1c=wcrU_6Gfew5pp5EBpSEsA@mail.gmail.com>
	<xmqq7fs9hekc.fsf@gitster.dls.corp.google.com>
	<CACRoPnSP9xfyW47ZqU7QO5o4tyzROh4hGRPqG9g9OB5cquS+uw@mail.gmail.com>
	<xmqq617sfj05.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 17 09:47:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YttIj-0003yA-FJ
	for gcvg-git-2@plane.gmane.org; Sun, 17 May 2015 09:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbbEQHry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2015 03:47:54 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:34105 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbbEQHrw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2015 03:47:52 -0400
Received: by laat2 with SMTP id t2so177962652laa.1
        for <git@vger.kernel.org>; Sun, 17 May 2015 00:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dHh8H9NZtpfe8DJZUhHZ19wN7Xqanr0NVtOxQPn/5L0=;
        b=EkcklBLQiKJHEpqIYHAd6sks2Obiy8sDV6SkQkjLMfZvEjJFiN0ZgSzi9uusJM7+6m
         3Bcgf5iWfYrzb3uCMhKej/xMxypUCQ87MjNRKM7X2CfuV5GkTFSQNpxr0MszT7NxZtrM
         erwabNDFdmD0L0wLXufuKKhOYoUYddsXEJLdE1TFE6n0wFViwZnSh1LSdmKqKQ+Q2Ch4
         lzbIK2Q/5ZlTNBvM9L7c20a6zu1AtVBI4rP/QJTZKGnWuolA0bOXsvcfmV2rXy92KYQr
         3iiQIWYM4sskzOs0gbF8QVB2g9ExBA86+zKYtFvMBS69HfInsb12dw+lL+VYP6CHmzWi
         bDPg==
X-Received: by 10.152.6.105 with SMTP id z9mr12764435laz.98.1431848871156;
 Sun, 17 May 2015 00:47:51 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Sun, 17 May 2015 00:47:51 -0700 (PDT)
In-Reply-To: <xmqq617sfj05.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269217>

Hi Junio,

On Sun, May 17, 2015 at 2:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> Hi Junio,
>>
>> On Sat, May 16, 2015 at 2:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Just to avoid misunderstanding, please do not remove 'verbose '
>>> blindly without thinking while doing so, as you already did 1/3 of
>>> the necessary job to make things better.
>>
>> Eh? I thought we established that using "verbose" does not provide
>> anything more than what "set -x" already provides. So at the very
>> least, its use should be removed completely.
>
> I did not mean "do not remove and keep them".  I meant "do not
> remove without thinking; instead, take mental notes on patterns
> these silent ones may have while removing them".

Okay. Just to keep things moving, for now I will send a re-roll to
remove "verbose" and to fix other issues like [1] and [2].

[1] http://thread.gmane.org/gmane.comp.version-control.git/268950/focus=269052
[2] http://thread.gmane.org/gmane.comp.version-control.git/268950/focus=269132

Thanks,
Paul
