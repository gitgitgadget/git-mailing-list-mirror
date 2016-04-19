From: Jan Durovec <jan.durovec@gmail.com>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Tue, 19 Apr 2016 18:56:10 +0200
Message-ID: <CABEqOBxZkYTm7_m-Eeq-acN=Nse1vLGk8Gm44BihVGi27KaGiw@mail.gmail.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
	<xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7-2mefGwfXRhvQZJFPD4QYAzZ1jYG82s6cnDzWVCiDS8w@mail.gmail.com>
	<xmqqfuuh35v5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 18:56:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asYwp-0004nC-Dd
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 18:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933674AbcDSQ4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 12:56:18 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:36318 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933671AbcDSQ4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 12:56:16 -0400
Received: by mail-qg0-f66.google.com with SMTP id f74so1918405qge.3
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=f36aCX9g5A7FTwakLkHfwSZhBrTraeb5hFaP6gdQcms=;
        b=DI5HJS+ljFOJu9q6h5YNiTOD9PImUo6xVuTfBQ9P4+6b94lFjhLDr802hn+S0YQiNz
         wivPlkx0816KpTf4AHdWN/tolLBJVk9DmGttoVwDvS/+1wIAMFepfTpWq2Nv5DBhDVq2
         APlNomTPhdcJF2Bg3NddwfiXzQVDamlDaXhmRJj77gOIKzPVJIG9RtXbSAwr/1KDmWEa
         qbsYsjBwx4VX5ISvJa/gPVtLYfcvzzwVt783jjoQ4rSQUowTcsiMFiDiQpwJ5Tz2Q9Lu
         yfewVPZyI7U1EDACq+bc0VUg4Oo6aPdc6lhAaYKhRyyoziXUCsdannQkDothPoQOJn5G
         MoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=f36aCX9g5A7FTwakLkHfwSZhBrTraeb5hFaP6gdQcms=;
        b=ZryMnfHbLd8iHpC4s9puBK9trJQuwOXvEd10PqrIZmknf+0xgvH+ATBv15EKQJAQQm
         xCA9Z6sVx/BTpx5p6/Az/gkDbF+frGQJgG1y1r9/y6Pwz8w2hjtNERhcfIQI8CqBMvOx
         rZY1rterShRkAD0iPsw+9bfFFFLgwAx/DuZfwjPXLQGj+uGh3wdosl6wbnTyQP/bjHkd
         pfDx1otiSY0FbMKy7CURN0AB5LV9rRNc/8XqrwiMW39srYGrbEPFiB7BgTAlDr1qi8wh
         ZSM4/OFlPhBF9Uz60/qpBVA60MSKrdIXzAEcyQoevYqEp2GVQxcYPDwlIFqiW2INH8/l
         jHNQ==
X-Gm-Message-State: AOPr4FXYoeqVDLMNOCKGUXj/v+jVEdsTcp5VW/Nf3b9dQ8aqXCzc6MuD+I/YG7NHE/JWtwB2ZsV+OMcfHYwFTA==
X-Received: by 10.140.229.69 with SMTP id z66mr5099921qhb.48.1461084970646;
 Tue, 19 Apr 2016 09:56:10 -0700 (PDT)
Received: by 10.55.49.10 with HTTP; Tue, 19 Apr 2016 09:56:10 -0700 (PDT)
In-Reply-To: <xmqqfuuh35v5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291882>

Hi,

given the fact that the rest of the code just follows existing
source code style, i.e.

* using %s not %d to add number to string (see git-p4.py:2301)
* no space between function name and parentheses (see all functions
  in t/lib-git-p4.sh)
* no tab when specifying in-line expected output (see t/t9826...)

...is there anything left to fix in this patch or is it good as is?

I.e. would you prefer me to change the code mentioned above at the cost
of code style consistency?

Is there something else that I have missed in my enumeration?

Regards,
Jan

On Tue, Apr 19, 2016 at 6:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>>> I am not familiar with "Perforce jobs", but I assume that they are
>>> always named as "job" + small non-negative integer in a dense way
>>> and it is OK for this loop to always begin at 0 and immediately stop
>>> when job + num does not exist (i.e. if job7 is missing, it is
>>> guaranteed that we will not see job8).
>>
>> This is OK - P4 jobs have arbitrary names, but this code is just
>> extracting an array of them from the commit by index.
>
> Ah, thanks, that is what I was missing and this part of the code
> makes perfect sense to me now.
