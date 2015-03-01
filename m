From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Add hint for translators for y/n reply.
Date: Sun, 1 Mar 2015 08:30:00 +0800
Message-ID: <CANYiYbFs_-4B4dko-KE3Gi2hDoQ1DkyR1xNkVc+uwOQrtz3dVw@mail.gmail.com>
References: <xmqq1tlfqcd8.fsf@gitster.dls.corp.google.com>
	<1425137944-13667-1-git-send-email-jn.avila@free.fr>
	<CANYiYbGuRjNZARc278py=MzDDXukAfLJv3kWdnBa6_ia7WDvRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jean-Noel Avila <jn.avila@free.fr>
X-From: git-owner@vger.kernel.org Sun Mar 01 01:31:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRrnY-000701-Mm
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 01:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbbCAAaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 19:30:04 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:44380 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbbCAAaC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2015 19:30:02 -0500
Received: by wesk11 with SMTP id k11so26836120wes.11
        for <git@vger.kernel.org>; Sat, 28 Feb 2015 16:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MMzm+5DOuY2RjdKbGxbq4dodSf3L6P9RXYlqxlfKEKg=;
        b=XJkS9E9RoLtmrjiYteV8nrpjBX6eGMwU9sO1ZbYOTXmM+9WREwt6Y0jmnFc/VmLEc0
         2r730VKkV8RgxWURQQ0MSYpbFi61RoOrNRqtWxR7+aOrvOYKU9CAk18ouBTHxNX/O8vN
         r2m5rAZXkEXJTVaG0JAfFgR/RSEFXTUjGF3ahAQ4u1/TPf3IqStMDzA73bX5H3injOcT
         mKo4bW/gd+icUj3FEHz5KGx8FeMYLMxEi5RbITlvz08L3hjWgVKnYw5anv1WqwlL/ATD
         cqbcUQvYdemv9FTACEvnX2+XT3+eKBUNfVRz/5k1mi28b28SXU5UvdrguoQK/Kgr2/Vw
         5JHg==
X-Received: by 10.194.185.9 with SMTP id ey9mr43797772wjc.135.1425169800940;
 Sat, 28 Feb 2015 16:30:00 -0800 (PST)
Received: by 10.194.80.131 with HTTP; Sat, 28 Feb 2015 16:30:00 -0800 (PST)
In-Reply-To: <CANYiYbGuRjNZARc278py=MzDDXukAfLJv3kWdnBa6_ia7WDvRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264541>

2015-03-01 8:18 GMT+08:00 Jiang Xin <worldhello.net@gmail.com>:
> 2015-02-28 23:39 GMT+08:00 Jean-Noel Avila <jn.avila@free.fr>:
>> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
>> ---
>>  builtin/clean.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/builtin/clean.c b/builtin/clean.c
>> index 7e7fdcf..2c98661 100644
>> --- a/builtin/clean.c
>> +++ b/builtin/clean.c
>> @@ -754,6 +754,9 @@ static int ask_each_cmd(void)
>>                 /* Ctrl-D should stop removing files */
>>                 if (!eof) {
>>                         qname = quote_path_relative(item->string, NULL, &buf);
>> +                       /*TRANSLATORS: Make sure to include [Y] and [n] in your
>> +                       translation. The program will only accept English input
>> +                       at this point. */
>>                         printf(_("remove %s? "), qname);
>
> Yes, it may confuse.  In order to let the translators notice this and update,
> you'd better change the code like this:
>
>         printf(_("remove %s [y/N]? "), qname);
>

What's more, you should capitalize the leading character letter of the
word remove.
My English.

>
> --
> Jiang Xin
