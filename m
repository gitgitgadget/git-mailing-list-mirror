From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 1/3] fixup: use xstrfmt instead of fixed-size buf +
 sprintf + xstrdup
Date: Mon, 12 Oct 2015 23:31:24 +0530
Message-ID: <CAOLa=ZTFrZK5B8ddVzkWQS-JbtrgrYrHRXjvaf0j8d+6p+LivQ@mail.gmail.com>
References: <vpqa8rp2xku.fsf@grenoble-inp.fr> <1444580188-18773-1-git-send-email-Matthieu.Moy@imag.fr>
 <xmqqk2qsm14x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 20:02:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlhQ7-0003Jc-S3
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 20:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbbJLSBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 14:01:55 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35816 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbbJLSBz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 14:01:55 -0400
Received: by vkha6 with SMTP id a6so33558717vkh.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 11:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NqM3z3jf1AVu0EnktRcOk5QyDXyyg+w38lAgmHWTSCU=;
        b=Ntkfa6h7RWcdTSlOjcLHz7igLc+ye+UDNcwpwxI2gPV5UJEl8wpeeUxNcEEVhAapwR
         2+uufVOWfw520El6ODxZvMEYVwkvWScQGX9ig8aXmHFp+SyMipJ+owB5wJbRu+K/tG0K
         VheostGPZSYVgtEeFfY/4DX2KQjWb/nnBHXxZoVs5x4T3Uku/xKRMQWZJzl2Jj6WHrwJ
         98mCykl+uQ740ZlAnc7YENdScyzN0OJQXcLP10OXz1LTa0H5o7QT9uiONOiazCI7Zq/f
         OIFHMMK2x99aSJheq2dknZ029z7knPp19xNk+750eRPOQWmkS72sUp+sg+I7zQE7bV3z
         27qA==
X-Received: by 10.31.161.142 with SMTP id k136mr19253771vke.17.1444672914120;
 Mon, 12 Oct 2015 11:01:54 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Mon, 12 Oct 2015 11:01:24 -0700 (PDT)
In-Reply-To: <xmqqk2qsm14x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279391>

On Mon, Oct 12, 2015 at 11:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> The char buf[40] is safe (at least while the strings are not
>> translated), but I'd rather avoid magic numbers like this 40 in the
>> code, and use a construct that does not have this size limitation.
>> Especially if it makes the code shorter.
>>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>
> The construct being fixed with this change looks very similar to
> Peff's a5e03bf5 (ref-filter: drop sprintf and strcpy calls,
> 2015-09-24) on jk/war-on-sprintf topic, but the new code since that
> commit cleaned up.
>

Yes, pretty much the same.

> I'd expect that this will be rolled into Karthik's series in the
> next reroll?
>
> Looking good.  Thanks.

Yes, I've adding this into my series.

-- 
Regards,
Karthik Nayak
