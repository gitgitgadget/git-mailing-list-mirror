From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 00/36] Massive improvents to rebase and cherry-pick
Date: Mon, 10 Jun 2013 18:43:55 -0500
Message-ID: <CAMP44s10T55_OBQrzXg6jwPrtJh_J9dJnTfDKJhkUc_oCm_cOA@mail.gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s2nbo97qFenwm3RaHYQ4K14knZpSvpLPPM3uPiFSRinuQ@mail.gmail.com>
	<CABURp0p7axsFHRLpXBCAZaMpeE1Ae5N1wNugEe3vsHCtX6_7EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 01:44:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmBkn-0004TW-Nk
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 01:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989Ab3FJXn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 19:43:58 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:48512 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437Ab3FJXn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 19:43:57 -0400
Received: by mail-la0-f43.google.com with SMTP id gw10so6240809lab.2
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 16:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=e1+J7PQEqgPcWSWn6FNX6aoej9Dr6IxqHBfVtwNpsbc=;
        b=zNCS75BazTS9hPsJkPxOVDLiTcrM/RFQfu5kGfnuhwtrulaU7QupMEBLuzkZhoP/eG
         QqC+M7nSe3a+WdK4/z07edB5u2sPS/nopOs5/iGhrt3ZztVW83UOgAVSNt/BrYohzqX8
         VJrxo6+t2q5ZezHx3O/Ku7B8ZO8xYY3kvWHPy/BVs/Ss5zXIMvuxlAo6+HonOhT3la7t
         4KK6QW8mAynXY+8xX8jDM4CuzvUkfzaBZ61Vd6U5r+I5Q8xvU/V1ZTZMslKde6tvn5+v
         S24iSjCzg8gIHo7Kck1YLMCwlz3P3FUlO3CxqzUvPt51ibGwcNX0+u3KcCZjXk3sg/tZ
         gyjQ==
X-Received: by 10.112.140.231 with SMTP id rj7mr7703387lbb.16.1370907835902;
 Mon, 10 Jun 2013 16:43:55 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Mon, 10 Jun 2013 16:43:55 -0700 (PDT)
In-Reply-To: <CABURp0p7axsFHRLpXBCAZaMpeE1Ae5N1wNugEe3vsHCtX6_7EQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227404>

On Mon, Jun 10, 2013 at 5:55 PM, Phil Hord <phil.hord@gmail.com> wrote:
> On Sun, Jun 9, 2013 at 3:37 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>>
>> On Sun, Jun 9, 2013 at 2:24 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>> > Same as before, but:
>>
>> Also, remove the patches from Martin von Zweigbergk, because
>> apparently some people have trouble understanding that they were not
>> part of this series.
>
> Please try not to sound disgruntled. This attitude is toxic. You have
> turned this change into a complaint: that "some people have trouble
> understanding" which shows a genuine lack of understanding and
> compassion on your part.  Instead you can phrase your change notes
> more helpfully if you make changes only when you yourself actually
> believe the change should be made.  If you cannot do this, perhaps you
> can pretend.

That would be dishonest. Moreover, there wasn't a good reason to
remove these patches, I made it clear I added those patches only to
make sure the real patches of this series worked correctly. Also, I
clarified that to Thomas Rast[1], only to receive a totally
unconstructive comment[2].

Why don't you ask Thomas Rast to be more constructive[2]?

Then Johan Herland uses that as an example of a constructive
comment[3]. Why don't you correct Johan Herland?

No, you pick the easy target: me.

I already dd more than my fair share by carrying these 36 patches
through several iterations, yet you ask *more* of me. Why don't you
ask more of the people that just hit reply on their MUA?

Thomas' task was easy; he simply had to say "Oh, these aren't meant to
be applied, got it."

[1] http://article.gmane.org/gmane.comp.version-control.git/227039
[2] http://article.gmane.org/gmane.comp.version-control.git/227040
[3] http://article.gmane.org/gmane.comp.version-control.git/227102

-- 
Felipe Contreras
