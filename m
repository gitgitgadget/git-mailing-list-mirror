From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2016, #06; Thu, 21)
Date: Sun, 24 Apr 2016 00:12:57 +0530
Message-ID: <CAFZEwPOyhUBphjnSGTxcF0TKV7gGJm3qOv=vtsRN2hcF-WfvuA@mail.gmail.com>
References: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPMYSGe0k0eAZCQFtBOHw2yZp0w+HL6iN9YPDX5EvJcg-w@mail.gmail.com>
	<xmqq60v9r20i.fsf@gitster.mtv.corp.google.com>
	<xmqq7ffpnvht.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 20:43:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1au2WI-0001zn-Cu
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 20:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbcDWSm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2016 14:42:59 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34886 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbcDWSm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2016 14:42:58 -0400
Received: by mail-yw0-f193.google.com with SMTP id v81so18590314ywa.2
        for <git@vger.kernel.org>; Sat, 23 Apr 2016 11:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=jC/VerlNf8ZsLebNCSqvXyp8Bc9XwtNthnm1zhKnHv0=;
        b=RheQeHtErOoeD098GrBYpfNqO3d2EFLW7QGC6OsCycOoFT4CpFwYegxGH40rhmXR57
         FVyl4/KuJEUJCRI4bhrVULWdRM1qXmge88gcTE2A6/MN2EMPs2+GUe6J6Xo2GQlc7+7V
         OS5RMgnuQxQngQvTmbaqCTb3MfY931RNEMQEXaAHrEU6nMqXVCo6GagDFYnu0cX76IDw
         n24y8JTDoS9CIPpwJJIiwys8ptLGBj4xkfm+sWdEGr/otmCSIuzMI6qNPLny5kXA0fuH
         QJvBzRI3pGWmrmFn4n0RIOf7+/d44m+j50jutTGg2QeQFSYfhA6KPoBrKl8F6c8ICT6c
         B4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=jC/VerlNf8ZsLebNCSqvXyp8Bc9XwtNthnm1zhKnHv0=;
        b=KppxRif4MNyDZahkvdzgNtBwGFGwZeKLZCnVHbV3zypWQzXhK+aBhfj+Czn5GFyT6k
         lKhX53sSoI3D7xP8FyL7FebaR+F+JQ0CWuitLbE3WK3HqnKQgp2ZUXdtAkM5UxOMiRPG
         Li2jgjB99trTl0GT+/9pd+qgYVOX0RxCUUu4jRXY0f1BcjulMETmxnfhEh9C7OZlVBqI
         9pNWO1xA2NMCYp/WJN0FC4nmMUpuhRGo7a0Ze2aazWuv/N33rUe4J3jyxFJhxVQFC4nK
         LmtjNT0+AtSx9GpmTCQXP+6XH6XdqtoG5M1DBFGbxSKPTuwlv++Fv/N+C0ZFMYZHIGk0
         aOkA==
X-Gm-Message-State: AOPr4FVEGz7NLZlHG3QTutzobNIhVxQiun0YYB7zXUqmhWoorYC6axogQdtwx+n/OE1O2K3Z9GgSDnlnpTmVQw==
X-Received: by 10.37.87.135 with SMTP id l129mr16828289ybb.7.1461436977664;
 Sat, 23 Apr 2016 11:42:57 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Sat, 23 Apr 2016 11:42:57 -0700 (PDT)
In-Reply-To: <xmqq7ffpnvht.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292305>

On Sat, Apr 23, 2016 at 3:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>>>  Is this going to be rerolled?
>>>>  ($gmane/291382)
>>>
>>> The changes weren't that big enough and I had my end semester exams
>>> coming so I decided not to re-roll it.
>>> If you think contrary, I can do a re-roll with the changes suggested
>>> by Eric Sunshine.
>>
>> I agree that this was pretty close to be done.  Let me see if I can
>> find time to finish it up in the coming few days.
>
> I looked at the reviews again and I take the above back--the end
> result of applying all patches may not have to change a lot, but
> the ordering and structure of the series may need cleanign up.

Surely I can work on the patches. I will have to try and squeeze out
some time from studying so you can expect the patches in around 1
week. I will once again clarify with Eric about the tests since there
was quite misunderstanding.

Regards,
Pranit Bauva
