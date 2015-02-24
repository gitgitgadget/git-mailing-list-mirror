From: Guilherme <guibufolo@gmail.com>
Subject: Re: Copyright on wildmatch.c
Date: Tue, 24 Feb 2015 10:29:43 +0100
Message-ID: <CAMDzUtz_BhW_tuQLy+AiNY7hz_HXCmHOtUNDgMBc=Taeon_Dwg@mail.gmail.com>
References: <CAMDzUtyitrK__iE9ykfTuP+Ooq0FwMPp_NVgBfBGbSV52+OPoQ@mail.gmail.com>
 <CAMDzUtymj21ckMrA87q1TATeWuH6kS_TBrsJ_jVjfeH50CaniA@mail.gmail.com> <CACsJy8Do77QSKSERPE26bKJ0gANB0XmPVBLwb1QKAW4qe0ouAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 10:30:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQBp4-0003yu-DB
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 10:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbbBXJa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 04:30:27 -0500
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35158 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbbBXJaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 04:30:25 -0500
Received: by wggz12 with SMTP id z12so3991545wgg.2
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 01:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Z4SQS1ZeovNTf/5tzZiW7r4vw931aGpmI/+2tJWVfVA=;
        b=NutAOOa+NOpr9iWenHl6eGfgJlL0qyDVp4cZF6QhERXZgISJwzGMGHLdOW05GzkCk7
         CmhG9AQvbhwjsOtOzJ2yswsOVMOiXt8FkZmzG5yWhiI5yQe8MWyrfI697K9KbfJSFDLo
         1oFhhlIfcBNJBhGkx/rGh+Ts84UD9HZiaav6oSxnU4GaVM4A1BXsFswfjieXuyvwWXUr
         94PkkSvXuYF6SvsAbsX64PUo7wIKYt0sB+G6/NRYGI/B6NsyfYv6fW2NTNvEQNs5MnxX
         owdb0usnB8Xl5e063rhMeBnlS7IW/eZdF70MT4ZqBCwwHGtqSVMGmVzP6q5JSUwTeQM3
         yeDg==
X-Received: by 10.180.211.111 with SMTP id nb15mr12218355wic.37.1424770223825;
 Tue, 24 Feb 2015 01:30:23 -0800 (PST)
Received: by 10.27.95.230 with HTTP; Tue, 24 Feb 2015 01:29:43 -0800 (PST)
In-Reply-To: <CACsJy8Do77QSKSERPE26bKJ0gANB0XmPVBLwb1QKAW4qe0ouAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264316>

That discussion seems to have just died off.

Whom should i write to about making the license change effective? You
(Duy Nguyen) seemed to be fine with the license change. Can you, or
anyone else, further guide me on the process on making sure i can use
the file(s) in TSS?

Thank you.

On Tue, Feb 24, 2015 at 9:58 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Feb 24, 2015 at 3:08 PM, Guilherme <guibufolo@gmail.com> wrote:
>> Hello,
>>
>> I have already posted this to the users mailing list but i guess it's
>> more appropriate to have it here.
>
> Related thread about relicensing wildmatch.c for tss
>
> http://thread.gmane.org/gmane.comp.version-control.git/259764/focus=259798
>
>>
>> ---------- Forwarded message ----------
>> From: Guilherme <guibufolo@gmail.com>
>> Date: Tue, Feb 24, 2015 at 9:02 AM
>> Subject: Copyright on wildmatch.c
>> To: "git-users@googlegroups.com" <git-users@googlegroups.com>
>>
>>
>> Hello,
>>
>> I'm trying to implement support for gitignore files in
>> the_silver_searcher (https://github.com/ggreer/the_silver_searcher).
>> It is a source code optimized version of grep. And it is way faster
>> than ack.
>>
>> The problems at hand is that I'd like to use wildmatch.c and some
>> dependencies (hex.c, some portions of compat-util.h) but it seems that
>> git is GPL whereas tss is Apache2 licensed.
>>
>> Is there any possibility to re-license the files above to Apache2 for
>> the TSS project?
>>
>> If not, is there any c library that provides support gitignore patterns?
>>
>> Thank you very much,
>> Bufolo
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Duy
