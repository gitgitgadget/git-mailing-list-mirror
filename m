From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv1] git-p4: workaround p4 removal of client directory
Date: Fri, 29 Apr 2016 21:47:29 +0100
Message-ID: <CAE5ih786AiiZw==QVhTzz5qSziirsKJkb8CtaiRTMh_Ejy51YQ@mail.gmail.com>
References: <1461915626-10250-1-git-send-email-luke@diamand.org>
	<1461915626-10250-2-git-send-email-luke@diamand.org>
	<CAE5ih78yvMe2MLqE6+KOnPUd+D_0-cO5-LY2WsbjfMmTMqBK9w@mail.gmail.com>
	<1A001D64-FAEA-49DA-9C2D-12DA04AA5F29@gmail.com>
	<CAE5ih7_V_ZNmouUGyi_NLgzjOGt_ZvNfj3K9a_+7LRyn6m8cNw@mail.gmail.com>
	<0F0D8F8A-47CB-44E3-90A6-13047D5A71F5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jacob Smith <jaroslov@gmail.com>, Git Users <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 22:47:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awFK3-00055S-0w
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 22:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914AbcD2Urb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 16:47:31 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35290 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbcD2Ura (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 16:47:30 -0400
Received: by mail-oi0-f67.google.com with SMTP id w198so16793422oiw.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 13:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to;
        bh=3WLbxatUnDB/jFLyUMAJvEiia5T69MjykZrM4mthJCk=;
        b=BCR71yqg4O177WpsJZC802LsgFKboREeIv7VenFcuPjFboYQgc1v0DnJgOdFOpVStd
         Xrr3LjKpOF9CqZHi2ZVI+urRk7ONCQutrxu9FzxAdU//PTk7iwYi3Gdd6K62Pjc+a49T
         kk2+kFn8TNYP+oNHQzig2twH1Jk0V6ZylwHOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to;
        bh=3WLbxatUnDB/jFLyUMAJvEiia5T69MjykZrM4mthJCk=;
        b=O/Yh/exuTltc8zpWSXr5JchIPDcdenuzXiWJ+pt08i9U/F3paObORoJJT+LKcgZzHh
         IzKrqPrK+Z9FBWcv5y4kD2Nb9VAEaogqNyDpGiMrluo1cH2KpbCsqrHJEGoRlYSEMO22
         R2ZhMmgtkz7TDl9PgVXvgnVNfv4S6IqQJObHDT5zGKjgd4iPlhJ9TpKwgFGwuAXOatoZ
         4ITvSUs3RBsxBYucHW5xpHauP588R/2+s3Eqg1E7ATM35N3YMINE0uu86UduoO6Ztclt
         YxhYpBBEQe1RKehhfUa3kS5hCrx3JuDSmIFicwnNQdH9cifElp75b75xKxWItpWAzVc8
         Vf+A==
X-Gm-Message-State: AOPr4FUCPTHVQ1L7Sokr2HodLDEd6wh/3PslNRDxUfRxfp9oY3DnhGu2vrib7ahGAM6nVZa4rQTNTESU7FcU4Q==
X-Received: by 10.157.32.114 with SMTP id n105mr10963449ota.108.1461962849753;
 Fri, 29 Apr 2016 13:47:29 -0700 (PDT)
Received: by 10.157.37.88 with HTTP; Fri, 29 Apr 2016 13:47:29 -0700 (PDT)
In-Reply-To: <0F0D8F8A-47CB-44E3-90A6-13047D5A71F5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293053>

[+Git, Junio]

On 29 April 2016 at 15:10, Jacob Smith <jaroslov@gmail.com> wrote:
> That's the identical patch I'm maintaining internally; it appears to work.

Thanks, I think that counts as a "Tested-by" then.

Luke


>
> Sent from my iPhone
>
>> On Apr 29, 2016, at 8:52 AM, Luke Diamand <luke@diamand.org> wrote:
>>
>>> On 29 April 2016 at 13:34, Jacob Smith <jaroslov@gmail.com> wrote:
>>> Thank you, Luke! I'll raise a radar so (hopefully) it gets integrated into Apple's distribution.
>>
>> Can you check if it works for you? I can't reproduce it here.
>>
>> Thanks!
>> Luke
>>
>>
>>
>>
>>>
>>>> On Apr 29, 2016, at 2:39 AM, Luke Diamand <luke@diamand.org> wrote:
>>>>
>>>> Adding correct email for Jacob.
>>>>
>>>>> On 29 April 2016 at 08:40, Luke Diamand <luke@diamand.org> wrote:
>>>>> On some platforms, "p4 sync -f" will remove the workspace
>>>>> directory after we have just created it; on some it won't.
>>>>> This causes problems later when git finds itself in an
>>>>> orphaned directory.
>>>>>
>>>>> Workaround this by cd'ing back to the directory after
>>>>> the "p4 sync -f".
>>>>>
>>>>> Signed-off-by: Luke Diamand <luke@diamand.org>
>>>>> ---
>>>>> git-p4.py | 5 ++++-
>>>>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/git-p4.py b/git-p4.py
>>>>> index 527d44b..2b75a61 100755
>>>>> --- a/git-p4.py
>>>>> +++ b/git-p4.py
>>>>> @@ -1,4 +1,4 @@
>>>>> -#!/usr/bin/env python
>>>>> +#!/usr/bin/env python2
>>>>> #
>>>>> # git-p4.py -- A tool for bidirectional operation between a Perforce depot and git.
>>>>> #
>>>>> @@ -1956,6 +1956,9 @@ class P4Submit(Command, P4UserMap):
>>>>>            if new_client_dir:
>>>>>                # old one was destroyed, and maybe nobody told p4
>>>>>                p4_sync("...", "-f")
>>>>> +
>>>>> +                # sometimes p4 will unlink the directory and recreate it
>>>>> +                chdir(self.clientPath, is_client_path=True)
>>>>>            else:
>>>>>                p4_sync("...")
>>>>>        self.check()
>>>>> --
>>>>> 2.8.1.218.gd2cea43.dirty
>>>>>
