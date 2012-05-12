From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: Finding all branches(remote and local) include given commit?
Date: Sat, 12 May 2012 21:52:11 +0900
Message-ID: <CAFT+Tg9rnYAkEVC+kyf=rfXgVLvzSSa+fzqy9ocEZ+rRbA82uw@mail.gmail.com>
References: <CAFT+Tg9nJZ7E3FB3nA6+_TR=KUqu80128rL8b2DuRGtBavsj-Q@mail.gmail.com>
	<1336824434.3002.17.camel@centaur.lab.cmartin.tk>
	<CAFT+Tg-cYCatcaP3fR7X7+GnpazUb3ys96A5AP6HTjvD_=+UyQ@mail.gmail.com>
	<1336826919.3002.18.camel@centaur.lab.cmartin.tk>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sat May 12 14:52:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STBo1-0001HV-Jo
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 14:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656Ab2ELMwN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 May 2012 08:52:13 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64404 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab2ELMwM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 May 2012 08:52:12 -0400
Received: by obbtb18 with SMTP id tb18so4635306obb.19
        for <git@vger.kernel.org>; Sat, 12 May 2012 05:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=OTDcHdMRxUrZoC+WdMxzHVrk0jnk2GIvpwh1HWT2Ygk=;
        b=FeL16OZqjRnzQLNIwzSQgX6HgrAJOTT+/q5fjYBj9s1gPp6quxrc7AGuHYY8o66r9G
         QblPHUcYW/khhrQh0wj6qietUDQFZScmpOLB+2lcHOFTwgg6lS7xnbfz4L+w0Bp1reWB
         Xy+3DQKBPBvsNVImmJEeNcfzP6n2xJMBixOk7Y2bzzagKjFXxZ4ku1yHxPVl/Bl3HUY3
         RZ38DypcnMmXDBQIbKMQNFHg0DgrewDCJbXePddmNcdNoC98EmNh1X6Oc70uQi44U7rN
         1FlqHN596aPusI7Q3jUngW1O0NNQkvzwqvNYpBMX/IaO8GYq0HnOHgVvQhlIKVdujsRc
         ArWw==
Received: by 10.60.7.103 with SMTP id i7mr2244121oea.64.1336827131950; Sat, 12
 May 2012 05:52:11 -0700 (PDT)
Received: by 10.182.53.39 with HTTP; Sat, 12 May 2012 05:52:11 -0700 (PDT)
In-Reply-To: <1336826919.3002.18.camel@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197733>

> The branch command has had long-form since 1.7.8

That sounds good to me! Thanks for letting me know.

2012/5/12 Carlos Mart=EDn Nieto <cmn@elego.de>:
> On Sat, 2012-05-12 at 21:25 +0900, Yi, EungJun wrote:
>> Wow, I should do like this:
>>
>> $ git branch -a --contains 499e7b31509cfbb59dcb2a046f8e2fd1a3e73d6f
>> * master
>> =A0 remotes/origin/HEAD -> origin/master
>> =A0 remotes/origin/master
>> =A0 remotes/origin/next
>> =A0 remotes/origin/pu
>>
>> git-branch has '-a' but not '-all', and git-remote has '--all' but n=
ot '-a'.
>
> The branch command has had long-form since 1.7.8
>
>>
>> This is a bit confusing for me. Why don't the two commands have the
>> option under the same name?
>>
>>
>> 2012/5/12 Carlos Mart=EDn Nieto <cmn@elego.de>:
>> > On Sat, 2012-05-12 at 20:42 +0900, Yi, EungJun wrote:
>> >> Is there any way to find remote and local branches include given =
commit?
>> >>
>> >> e.g.
>> >>
>> >> $ git branch --all --contains 499e7b31509cfbb59dcb2a046f8e2fd1a3e=
73d6f
>> >> * master
>> >> =A0 remotes/origin/next
>> >>
>> >> As you know, it does not work and "git branch --contains" finds o=
nly
>> >> local branches.
>> >
>> > Works For Me. What version are you trying it with? Are you sure th=
at
>> > remote-tracking branches do contain that commit?
>> >
>> > From a quick look through the log and release notes, it was never
>> > mentioned as a fix. The log contains 3f7701a4 from 2007 which fixe=
s 'git
>> > describe --all --contains' which, though unlikely, might be relate=
d.
>> > This commit was however part of release 1.5.4, which makes it unli=
kely
>> > you'd be using something older.
>> >
>> > =A0 cmn
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
>
