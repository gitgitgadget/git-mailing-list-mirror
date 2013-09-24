From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH v3] build: add default aliases
Date: Tue, 24 Sep 2013 07:06:44 -0400
Message-ID: <CAEBDL5V1kyRwtKSM+L_E_XbJRauvdmOLc+g2acbixt0+pd6_ag@mail.gmail.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5WQLx4rsN+yRs62fgTBWkuAhCSWDRkoCc8M_akpSqMKvg@mail.gmail.com>
	<CAMP44s3nQv97B2=mq-mn8S41sMA43qRfr+nC7eQ=Jft=zRgTRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 13:06:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOQSA-0005Er-4R
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 13:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843Ab3IXLGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 07:06:46 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:53263 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab3IXLGp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 07:06:45 -0400
Received: by mail-we0-f176.google.com with SMTP id u56so4323225wes.35
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 04:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nbMJErnBjSJgS4C5XMhouurwGbf1yenPexF7y1YTydc=;
        b=sTsAjg3L+AYGR+Cq6B+mqbqm9PfOBCGv9ijNMhOqpUBGipwBdW11rYUScf5ydhx1dD
         a6w7mlzgo6DNnWa9u7UGSja5bzdNtMMPRx9YD1vkH5WObVIgqxj6mhHSH02eXA4Fo2bu
         zmLxJlirVAHHFqaDU82DK1+cEQmlBrXVlDrJZX6vg/Jxk85ly9FOqNz0c1QeYUDMmuWl
         82pA7uIJsb3036hfqxh67mOciachkR5MLxgOQwXDDRlzAQFduP59+tLado4C0IxJIjXq
         yMxaKa07uz6zoXRLbf6a76w0ndoSbljbuzHKE+ZtBLtq5s/XMpIUIlGvuUXQNLwJvzdi
         14Jw==
X-Received: by 10.180.76.171 with SMTP id l11mr17646841wiw.39.1380020804614;
 Tue, 24 Sep 2013 04:06:44 -0700 (PDT)
Received: by 10.180.228.42 with HTTP; Tue, 24 Sep 2013 04:06:44 -0700 (PDT)
In-Reply-To: <CAMP44s3nQv97B2=mq-mn8S41sMA43qRfr+nC7eQ=Jft=zRgTRw@mail.gmail.com>
X-Google-Sender-Auth: qrg5extYrkhFAAMG1iC4O8PeLCM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235300>

On Tue, Sep 24, 2013 at 6:25 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Sep 24, 2013 at 4:19 AM, John Szakmeister <john@szakmeister.net> wrote:
>> On Sat, Sep 21, 2013 at 3:20 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> For now simply add a few common aliases.
>>>
>>>   co = checkout
>>>   ci = commit
>>>   rb = rebase
>>>   st = status
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>>
>>> I still think we should ship a default /etc/gitconfig, but the project needs to
>>> agree it's a good change, and nobody every agrees changes are good. So this is
>>> the minimal change that achieves the desired result.
>>
>> I wish you would stop attacking the project every time you send a
>> patch--it's simply not productive and it's certainly not getting you
>> any closer to a resolution.
>
> I'm not attacking the project, I'm making an objective claim, and I
> can back it up with several instances of evidence where 99% of the
> users would benefit from a change, yet it does not move forward.

There's nothing objective about "Nobody every (sic) agrees changes are
good".  If it were true, no changes would get in.

Also, you don't know that any of those changes would benefit "99% of
all users".  It's a guess or an estimate but it's not based on
anything concrete.  It might be a good guess--and in this case, I
think it is--but it's not a concrete fact.  Don't make it sound like
it is.

> If you don't agree my comment is accurate, that's one thing, but
> labeling it as an attack is another.

Don't turn it around.  A number of your patches and emails poke at the
community of the Git project and you know it.  It's simply not helping
the situation.

Your clearly a bright and motivated individual--which makes it all the
more frustrating that you don't approach this differently.  I even
agree with your motivations for Git: I'd like to see less shell and
perl involved and to see Git run faster on Windows.  But I wish you'd
stop with the jabs.

> I would admit I was wrong if an /etc/gitconfig is indeed shipped by
> default, and agree that the Git project is indeed welcome to change,
> but that's not going to happen.

And there it is again.  Predicting the future now?  Objectively and
accurately?  Please stop.

-John
