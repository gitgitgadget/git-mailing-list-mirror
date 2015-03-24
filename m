From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Git ignore help
Date: Tue, 24 Mar 2015 13:37:29 -0400
Message-ID: <CAPig+cQE6-BaOPZQuQJV-ENX+M7oXhozuZmY0LwkdbwDp8xQhw@mail.gmail.com>
References: <47F.3lxhK.7IviRa5Gutr.1L2}X3@seznam.cz>
	<CAPig+cRU38sNHRsn=8=60wPO_AoQt-zn1dicFHwjG0OK-9tecQ@mail.gmail.com>
	<CACsJy8CGuuRTGycj13cT9d-n=HavzL4LVWC7xjD4Ac=KQGEhBg@mail.gmail.com>
	<CAPig+cT5=3kzEu4CzfYW3QtKqDDHn5uSwocoscFLU-T9M-+wiw@mail.gmail.com>
	<CACsJy8DDC2FbKnu7o1cJR6F6Lh-NabaYtMYOKbm0xbn8PuKoEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: mdconf@seznam.cz, Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 18:37:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaSm1-0007dE-Mh
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 18:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbbCXRhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 13:37:36 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:34287 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755211AbbCXRhb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 13:37:31 -0400
Received: by lagg8 with SMTP id g8so165524634lag.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=PoC5k775rk1WCYGq5DQR5PhjJqDCZg9K1AnBuRtA5rI=;
        b=Q5vSewU3dFUcDNzDpWFYNyNEC4D3q6DZKL3SQhmA69Q/Q5Ye4ZxsxpLqfQDDw3Jhjp
         BinCr1CbOAPsJlMgrSdxSm+7fQ4uhmUz/oh5qANPsOUJKgrUkQdwBdffuYMnbvnw1vQM
         FOCaEwS4/B2rro+tHl6yrRLwJDMOeGa5VUZDsP9BYPl0CgvD5qAubt7gyc1nRZRNnnwf
         SkTsHRydQiesqm9f2JU/L7FLoYJnuXq3gPW5t+nJq/QZQjP7soU0BDhcwL5OMWlzQVfe
         3MYLpzVpZfkcKR+xlXkgn/nEwCGsIJF/qO2UUNKevkiUE9mEE+w31/cRxZyfUGmc9x7o
         X5lA==
X-Received: by 10.152.219.2 with SMTP id pk2mr4573223lac.107.1427218649837;
 Tue, 24 Mar 2015 10:37:29 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Tue, 24 Mar 2015 10:37:29 -0700 (PDT)
In-Reply-To: <CACsJy8DDC2FbKnu7o1cJR6F6Lh-NabaYtMYOKbm0xbn8PuKoEg@mail.gmail.com>
X-Google-Sender-Auth: vGn3ANPklmkxYscSU_Qn0YCx00g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266207>

On Tue, Mar 24, 2015 at 5:39 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Mar 24, 2015 at 8:55 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> e.g. "db", "reports" or "scripts", we could keep going for a while. I
>>> think I attempted to do this in the past and failed (don't remember
>>> exactly why). Maybe I'll try again some time in future.
>>
>> I also was pretty sure that you had attempted this, but couldn't find
>> a reference to it, so I didn't mention it in my response. However,
>> with some more digging, I finally located it[1].
>>
>> [1]: http://article.gmane.org/gmane.comp.version-control.git/259870
>
> Thank you. I only looked at my repo and no branch name suggested it
> (if only there is google search for a git repository..). So I gave up
> because of performance reasons again but that was for enabling it
> unconditionaly. If we enable it via a config variable and the user is
> made aware of the performance implications, I guess it would be ok. So
> it's back in my back log.

How much does a config variable actually help? In a sense, one could
argue that this is already an opt-in feature since it requires
crafting gitignore in a particular fashion. Existing projects which
have (properly) functioning gitignore rules won't trigger this
behavior. In many cases, Git already allows people to shoot themselves
in the foot if they desire, thus, as long as the potential performance
impact is properly documented, this could be considered another such
instance.
