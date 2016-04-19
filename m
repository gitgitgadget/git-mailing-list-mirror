From: Jan Durovec <jan.durovec@gmail.com>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Tue, 19 Apr 2016 20:04:23 +0200
Message-ID: <CABEqOBwqW+BO4rtOx4ax35VacE4RZhpo_1pbqzTP_EGiSWasiQ@mail.gmail.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
	<xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7-2mefGwfXRhvQZJFPD4QYAzZ1jYG82s6cnDzWVCiDS8w@mail.gmail.com>
	<xmqqfuuh35v5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxZkYTm7_m-Eeq-acN=Nse1vLGk8Gm44BihVGi27KaGiw@mail.gmail.com>
	<xmqq7fft32y9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 20:04:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asa0j-0004p7-O8
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 20:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbcDSSE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 14:04:26 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:33251 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754420AbcDSSEY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 14:04:24 -0400
Received: by mail-qg0-f66.google.com with SMTP id 7so2372343qgj.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=QaY7jGe26LL5loHTAmoFJ+nQFNGF0cOciUb7Cq7q6ZQ=;
        b=SIzoXIPrR4jgDA92jaAlqQr4P5ShKwKgcrVX096kuwhMpvMa3ZvjupUFXEjxSYhhP4
         g8XzU+33fpHmNj4lFyluA226ZVCAHyviOw9jo5F8eumoANbAaJNqVRpQvaUh8oItAWnv
         +h206skf0ZaslN9Lh6bcjmjXmNWFc+goEQyCPwEEgpfQdHw1uChA/0sWTg9EAjtTm0xj
         p1dBtVaXzdqEe3A/qixT/Nfad4cmCghmEXoiEOR+8Z9iiT4+PABSoE/4oDhjpHKuUfCv
         nzhF+sHwpt+ut83Gm9rUWkya7qWYewd9QwB7IY8jZvkA9EltSHqIMgWe0D0DB+YZP5xd
         fNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=QaY7jGe26LL5loHTAmoFJ+nQFNGF0cOciUb7Cq7q6ZQ=;
        b=gyMPpb/Fv7W9s2AZ48NqMApEI15zwyJKjFrw18a29txu9MywO62eC3Sxr0ToZ4OpF+
         LeWpFDANx27qRuKXNFfDGiozeS4eKjq4eCYXXxvz+GVh/kZ2yxsVXcm3py1S+6WmnJLc
         v5CmzGuKq8yMTQb2VpKwMda0qToDeKdlV6Ew3ShI5TykCdwJJhurms/xEkAsZm0DeMHy
         w4Ik1XKIRRnTIZVm7udmDTKNNFWrN/i3ALzMJUZLMgzCj5qc4UXYmQm7J37Jb+tYv3DB
         OUMC5XP3eTc3i9inAXCn6mxRX24qDiDaJL0tJL+68xl2rztN/xYwTyet62ayzHakQnYB
         8HVw==
X-Gm-Message-State: AOPr4FXnc9jrlbOqrlYLswli+gBpe2gKLPfCx5KZlBlJAlA5cU2Y6B+sTdMbxBWPKqTMyOrkRvH8qbJxUQ1doA==
X-Received: by 10.140.18.114 with SMTP id 105mr5356011qge.41.1461089063765;
 Tue, 19 Apr 2016 11:04:23 -0700 (PDT)
Received: by 10.55.49.10 with HTTP; Tue, 19 Apr 2016 11:04:23 -0700 (PDT)
In-Reply-To: <xmqq7fft32y9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291896>

Would it be acceptable the other way around? I.e. this patch followed
by the one that fixes code style (once this gets merged)?

Reason being that I don't know how to use submitGit to generate a patch
against a state that is not already in git repo (ie. based on another
patch).

In the following patch I'll
* add spaces before () for functions in t/lib-git-p4.sh
* remove name local variable in p4_add_job/user in t/lib-git-p4.sh
* fix t/t98* leading tabs where <<- is used

On Tue, Apr 19, 2016 at 7:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jan Durovec <jan.durovec@gmail.com> writes:
>
>> given the fact that the rest of the code just follows existing
>> source code style, i.e.
>>
>> * using %s not %d to add number to string (see git-p4.py:2301)
>
> This one I do not care too deeply about, as formatting anything that
> can be formatted via '%s' could just be more Pythonic style, in
> which case "%s" is perfectly fine.  It just didn't look kosher to my
> C trained eyes, that's all.
>
>> * no space between function name and parentheses (see all functions
>>   in t/lib-git-p4.sh)
>
> I thought I said "Not a new issue, but..." to this one, and it
> appears that leaving <<- here-doc unindented, which is stupid as
> that shows the person who is writing the here-doc does not know what
> the dash s/he is writing means at all, is also not a new issue.
>
>> * no tab when specifying in-line expected output (see t/t9826...)
>
>> ...is there anything left to fix in this patch or is it good as is?
>>
>> I.e. would you prefer me to change the code mentioned above at the cost
>> of code style consistency?
>
> Not really.
>
> If you really want to know the preference, we prefer a preliminary
> clean-up patch to correct existing style issues, followed by a new
> feature patch that builds on the cleaned up codebase.
>
