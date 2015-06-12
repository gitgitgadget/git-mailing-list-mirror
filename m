From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 03/12] for-each-ref: change comment in ref_sort
Date: Fri, 12 Jun 2015 23:18:16 +0530
Message-ID: <557B1B60.9020002@gmail.com>
References: <5579B253.4020804@gmail.com>
 <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
 <1434039003-10928-3-git-send-email-karthik.188@gmail.com>
 <xmqqy4joddul.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 19:48:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3T47-00026V-QY
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 19:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbbFLRsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 13:48:22 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34170 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbbFLRsW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 13:48:22 -0400
Received: by pabli10 with SMTP id li10so7816014pab.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 10:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=/QU76osKgPJzMDNQQduId0Q5xNe85yDpwTLB2OQBEYA=;
        b=XwXEAZFLuWuLUvbxF3UU8HIG54sZl//rFZ8BeiNxS1Jsk2fd6xy5crbJhX8Nu1UWw3
         CfFDfFesGZVac///jBW+MFcI49mvGyigCBQZretNOb2piubyWXHNfiqKoM+Q9bSio/Da
         pariAAYqEOCLUIIIAbsyYKzD5kaD8QzKMxcHsnKXWx1zZq5t9Tp/D5D/oRWSCDvasqdD
         DzF9gGnmwa65lNokojKV8ZFCLszeh3SE/1gcuaumBsPO+cfuljcCu9SbDW2KmecD/+dv
         MGXQYQkIPPNzKib/esjZ/51MtqmxQ3fRp3jqtTRQDDDe50fokFGnlJhu1zCf6Qhi6N2u
         Hhrg==
X-Received: by 10.68.167.66 with SMTP id zm2mr25351464pbb.164.1434131301765;
        Fri, 12 Jun 2015 10:48:21 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id j9sm3724561pbq.92.2015.06.12.10.48.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jun 2015 10:48:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
In-Reply-To: <xmqqy4joddul.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271504>

On 06/12/2015 11:10 PM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The comment in 'ref_sort' hasn't been changed 9f613dd.
>
> Bad grammar?  "hasn't been changed since 9f613dd", perhaps?

Yes! thanks :)

>
> But more importantly, don't just give an abbreviated object name.  I
> think "the comment hasn't changed since the for-each-ref command was
> originally introduced" is what you meant to say, and it is OK to
> append "since 9f613ddd (Add git-for-each-ref: helper for language
> bindings, 2006-09-15)" to that sentence as a supporting material.
>

Ok will do.

>> Change the comment to reflect changes made in the code since
>> 9f613dd.
>
> What change since 9f613dd do you have in mind, exactly, though?

Well initially the atoms were indexed into used_atom array, which
later was removed. Hence the comment becomes obsolete.

>
> I do not think the fact that this field indexes into used_atom[]
> array has ever changed during the life of this implementation.
> I see "static const char **used_atom;" in builtin/for-each-ref.c
> still in the 'master', and that is the array that holds the atoms
> that are used by the end-user request.
>
> So I do not think "The comment was there from the beginning, it
> described the initial implementation, the implementation was updated
> and the comment has become stale" is a good justification for this
> change, as I do not think that is what has happened here.
>
> You may be changing used_atom to something else later in your
> series, but then isn't that commit the appropriate place to update
> this comment?
>

But isn't that what happened here, the code was altered but the comment
was left the way it is.

What do you suggest I do?

-- 
Regards,
Karthik
