From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH v5 00/36] Massive improvents to rebase and cherry-pick
Date: Mon, 10 Jun 2013 21:09:59 -0400
Message-ID: <CABURp0qG6AqR-y1YLB0FdX-=kniHoZBfwUs0d7gPnfDfh9Pajw@mail.gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s2nbo97qFenwm3RaHYQ4K14knZpSvpLPPM3uPiFSRinuQ@mail.gmail.com>
 <CABURp0p7axsFHRLpXBCAZaMpeE1Ae5N1wNugEe3vsHCtX6_7EQ@mail.gmail.com> <CAMP44s10T55_OBQrzXg6jwPrtJh_J9dJnTfDKJhkUc_oCm_cOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 03:10:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmD6P-0005aA-Th
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 03:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab3FKBKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 21:10:21 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:49934 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472Ab3FKBKU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 21:10:20 -0400
Received: by mail-vb0-f46.google.com with SMTP id 10so4849182vbe.33
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 18:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tpu5DZuYtsnutbXeIwxiDlFY9//BwAedAZsXQFAG7AA=;
        b=gR8mFlwR5UEXcw7A2WXazUPRfnmpC2ubRWZIWWvuxfR4/eBkz2c0qhCzqOCq7hGJTQ
         mAhjpDvWor1vi6qGPs6Ph8/Jawp+24iiY00fYc/eidmb3GmDrt7L3T0QVBx6fIiZZNBd
         t7vz/TMATVKym3xNVKKq9g0vdMJLC21wMIF2Y53cibk2b6f4+sdtzQRjms880L8prGDE
         +Uy4Ua+mdPKoXvUuDeGK0FsOXW8hsboBe+9hb7uoJbrpOb/FSOwyGKzJBFm/jPOzX6il
         hkEMCDTPI4ul/Sab9ibM1WH4poLAWu2ETz3KHPVmNtoEE+Pp/Um8UYtIPt+ydenpTQeL
         eo6w==
X-Received: by 10.220.185.136 with SMTP id co8mr7161778vcb.25.1370913019936;
 Mon, 10 Jun 2013 18:10:19 -0700 (PDT)
Received: by 10.58.243.34 with HTTP; Mon, 10 Jun 2013 18:09:59 -0700 (PDT)
In-Reply-To: <CAMP44s10T55_OBQrzXg6jwPrtJh_J9dJnTfDKJhkUc_oCm_cOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227408>

On Mon, Jun 10, 2013 at 7:43 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Jun 10, 2013 at 5:55 PM, Phil Hord <phil.hord@gmail.com> wrote:
>> On Sun, Jun 9, 2013 at 3:37 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>>
>>> On Sun, Jun 9, 2013 at 2:24 PM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>> > Same as before, but:
>>>
>>> Also, remove the patches from Martin von Zweigbergk, because
>>> apparently some people have trouble understanding that they were not
>>> part of this series.
>>
>> Please try not to sound disgruntled. This attitude is toxic. You have
>> turned this change into a complaint: that "some people have trouble
>> understanding" which shows a genuine lack of understanding and
>> compassion on your part.  Instead you can phrase your change notes
>> more helpfully if you make changes only when you yourself actually
>> believe the change should be made.  If you cannot do this, perhaps you
>> can pretend.
>
> That would be dishonest. Moreover, there wasn't a good reason to
> remove these patches, I made it clear I added those patches only to
> make sure the real patches of this series worked correctly. Also, I
> clarified that to Thomas Rast[1], only to receive a totally
> unconstructive comment[2].
>
> Why don't you ask Thomas Rast to be more constructive[2]?
>
> Then Johan Herland uses that as an example of a constructive
> comment[3]. Why don't you correct Johan Herland?

I do not see what their comments have to do with your attitude.
Aren't your own man with cogent self-will and personal responsibility?
 Why should I also have to consider these other emails which I have
not bothered to read yet?

> No, you pick the easy target: me.

You seem to have mistaken me for someone else.  Moreover, you seem to
have mistaken you for someone else.  You are the least easy target I
know of on this list.  Everyone else seems open to community
standards.


> I already dd more than my fair share by carrying these 36 patches
> through several iterations, yet you ask *more* of me. Why don't you
> ask more of the people that just hit reply on their MUA?
>
> Thomas' task was easy; he simply had to say "Oh, these aren't meant to
> be applied, got it."
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/227039
> [2] http://article.gmane.org/gmane.comp.version-control.git/227040
> [3] http://article.gmane.org/gmane.comp.version-control.git/227102

I did not comment on their posts because they did not catch my eye.
Rebase and cherry-pick improvements are interesting to me, so I read
your post.  I will try not to make this mistake again.

Phil
