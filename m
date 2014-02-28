From: He Sun <sunheehnus@gmail.com>
Subject: Re: [PATCH] OPTION_CMDMODE should be used when not accept an
 argument, and OPTION_NUMBER is of special type. So change the mode to OPTION_CMDMODE
Date: Sat, 1 Mar 2014 07:50:02 +0800
Message-ID: <CAJr59C097u0HK5RqmZj6rUTAgeoSMjpoCJR_NGHiot02tQHDMg@mail.gmail.com>
References: <1393597765-14164-1-git-send-email-sunheehnus@gmail.com>
	<CAJr59C1qHrQ9qPdDWfGzj9QX3L-EwEcP+updu0SDn24r4i7UMQ@mail.gmail.com>
	<CACsJy8BM=m6=tv2P6F3EAcVPupovSTKC3s+5gkus3V+GZ4owRw@mail.gmail.com>
	<xmqqsir3t39f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 00:50:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJXBz-0007rY-Ab
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 00:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbaB1XuF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Feb 2014 18:50:05 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:55349 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbaB1XuD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 18:50:03 -0500
Received: by mail-wg0-f46.google.com with SMTP id z12so1143248wgg.5
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 15:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=2Gjrd9nN/ooAbZ8+88c9jX7W15J2FnQcoWZ1/ATrDyA=;
        b=ysRyJ0r7stbcHEID7hwOGh6YNoPjZfdb+2mO26m3eDxSHAoQeqfHBsUhXaG7MMBPSK
         1gEbzrO1+xLj6T9VQY4XKTqy7O2yUUMaXk2U6wiXiv32DE8LVKh2XH2GRZqpDJ9YZqEV
         ejK1CPF/wNs+Q4ni4sn4rjmejZV9HnvJcmevk2PcEMTI6cE5ZeaiY/FmZWj4mOzROYTu
         syxrshfOTQHLNd5MLZ/aEpoyLej9ekSOfcmnnyDYxWLBTRnXkrLIQlxZNwwnor/XL4FS
         9cB6tlXG1ySqaeXuNXONjvNn/bSX68hCOjJ6UdKzqTl/QTdIRpbA/vsHVwcgyF8PQFz7
         2Uvw==
X-Received: by 10.180.205.130 with SMTP id lg2mr5535797wic.59.1393631402353;
 Fri, 28 Feb 2014 15:50:02 -0800 (PST)
Received: by 10.216.203.69 with HTTP; Fri, 28 Feb 2014 15:50:02 -0800 (PST)
In-Reply-To: <xmqqsir3t39f.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243030>

2014-03-01 4:02 GMT+08:00 Junio C Hamano [via git]
<ml-node+s661346n7604560h61@n2.nabble.com>:
> Duy Nguyen <[hidden email]> writes:
>
>> Way too long subject line. Keep it within 70-75 chars. The rest coul=
d
>> be put in the body.
>>
>> On Fri, Feb 28, 2014 at 9:32 PM, =CB=EF=BA=D5 <[hidden email]> wrote=
:
>>> I am not sure if this is a bug.
>>> I need your help to find out it.
>>
>> Tip:git has a wonderful history (most of it anyway). Try "git log
>> --patch parse-options.[ch]" to understand parse-options evolution. A=
dd
>> -SOPTION_NUMBER (or -SOPTION_CMDMODE) to limit to only commits whose
>> diff contains that keyword.
>
> Also, I do not think this should be done in a single patch.  What if
> it turns out that explicitly making sure that CMDMODE does not take
> any argument is a good idea, but the other change is a bad one?

OK, I will try to figure it out.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to [hidden email]
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> ________________________________
> If you reply to this email, your message will be added to the discuss=
ion
> below:
> http://git.661346.n2.nabble.com/PATCH-OPTION-CMDMODE-should-be-used-w=
hen-not-accept-an-argument-and-OPTION-NUMBER-is-of-special-typeE-tp7604=
513p7604560.html
> To start a new topic under git, email
> ml-node+s661346n661346h27@n2.nabble.com
> To unsubscribe from git, click here.
> NAML
