From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10 02/13] ref-filter: print output to strbuf for formatting
Date: Wed, 12 Aug 2015 22:26:59 +0530
Message-ID: <CAOLa=ZSCnTz-ZuKebSxN_UO-rGb5drow6p0AezgWNPD4fL_Acw@mail.gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
 <1439129506-9989-3-git-send-email-Karthik.188@gmail.com> <xmqqlhdhso8i.fsf@gitster.dls.corp.google.com>
 <CAOLa=ZSo9wXj_2wPCfZ=kEYhnFHzqT2AUFKvoDoKh_BD9v+1Hw@mail.gmail.com> <xmqq7fp0mpwz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 18:57:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPZLJ-0007fW-RJ
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 18:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbbHLQ53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 12:57:29 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36545 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492AbbHLQ53 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 12:57:29 -0400
Received: by obnw1 with SMTP id w1so17310408obn.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 09:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0zSq2bRjo2QsVACIbY2Hxon0t3S3a1YtDkuOBakCPa4=;
        b=Oz2WrCZMPK8o7GgiY8q+7XkbkHvYwtJwULrmXfoAdT5os+E5GilLEmNgMWFbemnhRX
         L5e/k8AhUHm0x8x24y8dL/Jp3TvBKDxjxfxGonjYOOq8j1GSYaLCP3G+faplaKV/79uu
         ZtvYjF2bI6ksxxCpuOE7T8PPCxvKqE2zz6AbIaAmnvnCrVbpPCBCORUh36O9+0BuuGAH
         I2ybevyggYSfsEGr1BzjYz1A+R9PIClv1vMUYKWt+1LPEEL2R3fTFOLIs7tRUqljc0Ij
         DACKjSNPmc55wwHIrnOvpx4Cw9+B19CltTedhkB1ZvFLn/vNo2V643cxgHI03jkwWgLT
         wXBA==
X-Received: by 10.60.92.37 with SMTP id cj5mr31107425oeb.30.1439398648433;
 Wed, 12 Aug 2015 09:57:28 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 12 Aug 2015 09:56:59 -0700 (PDT)
In-Reply-To: <xmqq7fp0mpwz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275783>

On Wed, Aug 12, 2015 at 9:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>>> +             format_quote_value(atomv, quote_style, &output);
>>>
>>> If the one to add a literal string (with %hex escaping) is called "append_",
>>> then this should be called append_quoted_atom() or something, no?
>>
>> Although it does append like "append_non_atom" this is more of formatting based
>> on the quote given hence the name.
>
> Appending formatted values is still appending, no?

Of course :)

-- 
Regards,
Karthik Nayak
