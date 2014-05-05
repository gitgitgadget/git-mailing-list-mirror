From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Bump core.deltaBaseCacheLimit to 96m
Date: Mon, 5 May 2014 18:35:40 +0700
Message-ID: <CACsJy8CtcbfUHL+yntyU9zLW7Qc7EobbvFTwVzVsiwCJTsVtOg@mail.gmail.com>
References: <1399223637-29964-1-git-send-email-dak@gnu.org>
 <CACsJy8BG8fRPk74R_-YABCGMn-YwbDcLHtjUNX7KE66jX1mR4A@mail.gmail.com> <vpqwqe0a3ne.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Kastrup <dak@gnu.org>, Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 06 19:13:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhhyS-0005Yp-QN
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756593AbaEELgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 07:36:11 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:32912 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756527AbaEELgL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 07:36:11 -0400
Received: by mail-qc0-f174.google.com with SMTP id c9so7431446qcz.5
        for <git@vger.kernel.org>; Mon, 05 May 2014 04:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yejR694ViR+X/1jDM7153JFqUh42nm1LHrtSlW6FJLc=;
        b=aCOoQ1YScYpPARwfvZnZzTezhL23bL6IRfRcPdRgaAQ8BNtMztSk7DyhpWAs63ZJcF
         aO8zXK/wzfuHzg37YC+zoR0MR63vg3OzkwS7M64MpSFb+651zMpKLiIG90EX4RWFWmeG
         UBIg2QMd+dEQjcKBcrnJmGbtLeydIA6fBM3sO8WfX9Eqwr21qZlDQcMZ/bOS5OUvMrH7
         tVTSyNxom9tcBy62W8PEk4dDLH7sYKsn7dTu7DcEUPOyT+uPMbh78GOaQMHQlOQkBEvD
         0Qm6XtD9faslbTe9IRiasE9+9sLLsBBRDaScmJGyHfzWtiiu5YtqFylmxW2fmTUhHPG8
         wO+A==
X-Received: by 10.229.192.7 with SMTP id do7mr43071640qcb.1.1399289770581;
 Mon, 05 May 2014 04:36:10 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Mon, 5 May 2014 04:35:40 -0700 (PDT)
In-Reply-To: <vpqwqe0a3ne.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248175>

On Mon, May 5, 2014 at 6:03 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>>> -Default is 16 MiB on all platforms.  This should be reasonable
>>> +Default is 96 MiB on all platforms.  This should be reasonable
>>>  for all users/operating systems, except on the largest projects.
>>>  You probably do not need to adjust this value.
>>
>> So emacs.git falls exactly into the "except on the largest projects"
>> part. Would it make more sense to advise git devs to set this per repo
>> instead?
>
> What's the impact of changing the default for small projects?

Good question. With "git log --patch" or something like that, we could
use up to the limit, which is now 96MB. On modern machines that's
probably nothing.

> My guess is that changing from 16 to 96Mb is just following Moore's law.
> Machines average RAM has increased a lot since the time 16Mb has been
> chosen, and few people would actually notice the difference in RAM usage
> nowadays.
>
> If increasing the default does not harm small projects and benefits to
> big projects, then we should obviously go this way.

I wrote without thinking it through. I agree with you.

> (perhaps adding advices for people using Git on machines with low RAM)
-- 
Duy
