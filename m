From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH 1/3] pretty: add conditional %C?colorname placeholders
Date: Mon, 26 Apr 2010 09:20:07 +0100
Message-ID: <x2u5b9751661004260120t46494b18yea74c3f908b5742e@mail.gmail.com>
References: <1272210175-20484-1-git-send-email-wmpalmer@gmail.com> 
	<1272210175-20484-2-git-send-email-wmpalmer@gmail.com> <z2y81b0412b1004252330m189e68bcv19d7d1cb988820b6@mail.gmail.com> 
	<r2o5b9751661004260113m7b6c387bm8467a063c13e5a0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 26 10:26:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Jdl-0001Rv-Pl
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 10:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471Ab0DZIZ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 04:25:58 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:57197 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab0DZIZ5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Apr 2010 04:25:57 -0400
Received: by bwz19 with SMTP id 19so4146bwz.21
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 01:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=6MkV9VdkZcmxm5WkE9KJE3hA0a9S9TqBaWPc5ZCF62g=;
        b=UsmnwXXuqId6LMhzHlt5cyUhEEf7H8LYWy5HGIN2n6mnx5EeYvesBpYHw4h1G7du9w
         byo1Iv36FkzlT0mkOvXCesiNwUxtVepNGkwRSwG9QEExfakT8gZQDmpIonmpvC0nm7zQ
         6g7QFd5duOB3pjrPtYe1ppnESNGAvBEHWyLmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=CseGLknFXqfQ/stiXZURW7y6TMfpngQplUulVoiAuiK8B/9YKjcOxEnHNt9SFgDLbk
         wc2yxlH6RMG0DJIOvSH0x0EH0iNzbQf+4lJaH//ImvVA7b4sBf7fqwWtRlBeiGTqh2LC
         xVpEWeNSsSv7Y4VmN73NsCKrvZDt9vw3Te+m4=
Received: by 10.103.86.32 with SMTP id o32mr2015905mul.99.1272270027160; Mon, 
	26 Apr 2010 01:20:27 -0700 (PDT)
Received: by 10.103.239.12 with HTTP; Mon, 26 Apr 2010 01:20:07 -0700 (PDT)
In-Reply-To: <r2o5b9751661004260113m7b6c387bm8467a063c13e5a0f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145798>

On Mon, Apr 26, 2010 at 7:30 AM, Alex Riesen <raa.lkml@gmail.com> wrote=
:
> On Sun, Apr 25, 2010 at 17:42, Will Palmer <wmpalmer@gmail.com> wrote=
:
>> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty=
-formats.txt
>> index 1686a54..53eb903 100644
>> --- a/Documentation/pretty-formats.txt
>> +++ b/Documentation/pretty-formats.txt
>> @@ -132,6 +132,7 @@ The placeholders are:
>> =A0- '%Cblue': switch color to blue
>> =A0- '%Creset': reset color
>> =A0- '%C(...)': color specification, as described in color.branch.* =
config option
>> +- '%C?...: switch to specified color, if relevant color.* config op=
tion specifies that color is ok
>
> You missed the closing quote character. Besides, how do you think to
> distinguish between "%C?diff.color" and "%C?diff.colorcontinuation te=
xt"?
> The "%C(...)" has a placeholde termination rule (the closing bracket)=
, yours
> does not seem to have one (unless something is missing in the documen=
tation).
>
> Ah... I see. Definitely something missing. The spec should be: '%C?(.=
=2E.)'.
>

It's meant to handle both %C?green and %C?(green), perhaps I should
list those out on separate lines?
Missing quote noted, thanks.
