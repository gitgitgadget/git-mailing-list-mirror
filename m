From: elena petrashen <elena.petrashen@gmail.com>
Subject: Re: [Outreachy] Git remote whitelist/blacklist
Date: Mon, 4 Apr 2016 23:21:13 +0300
Message-ID: <CAJPOeMdzMa_75YZXW6_kEHApgKq-__A_zU_mDRePtA32Yr1xsA@mail.gmail.com>
References: <CAJPOeMdLHOJqgevGz8jirx-PnvNHbAUsHknBG_1hzZ5srBseEw@mail.gmail.com>
 <CAJPOeMe2p0eh6Lju2L3JB8zHFKcQozNAO673FUQtrc4q5fOfrA@mail.gmail.com>
 <BDAD45DF-8E1B-4BD7-AE5E-FC4788BC7634@gmail.com> <22DDACCE-6563-4097-9AE3-2CCD80CD0C1F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 04 22:21:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anB0O-00075W-M1
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 22:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756352AbcDDUVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 16:21:44 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34946 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756291AbcDDUVn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2016 16:21:43 -0400
Received: by mail-qk0-f177.google.com with SMTP id o6so67354997qkc.2
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=aGVuvv7TZ2yv4X4h1ZgDYp6JYWiwhp6jfAMcYB5XPso=;
        b=buhdkecSytbRPFIaNUP5KPxZ3TMvcCvg/7nj9iCehgCET+f+PB8N5XdnpdjMOisyiB
         wvpp0kQONudICByCRLlUg0Jepj5s3BxuyT8SPg0D4DG5ozoCijLNF1K3J73Oru8GTMxG
         QIFuiehCyij7G6x8NJVwVorBDldD87yDHyYsCFzdSKJFv6gdoIZ0nT0LAr4i2GNLcV+y
         js2B7J7MKYsvqBdbFTVHBEJBRw9ugLYrzRTq15IBpA0IiFGDxNvXC3GqnhehVt1dqlNw
         aLP/aCGAx2ij9Ybw8dzwq5DmusVvNDi4CcPW050NKSsbx9Y/neII+nH4PWdIXoHayfv3
         aWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=aGVuvv7TZ2yv4X4h1ZgDYp6JYWiwhp6jfAMcYB5XPso=;
        b=cbtKgFMsaY8bJ8+Yn2ZCr4xo/VUdjuuB6hcgn2C473CCW+RpezTxYjvyv/+txGUNMT
         BDnLChtAE6oalmrljL4LVmThqQxtxgOkeug4VBdNYOhhIlIQpz/m5JMthHkXMBzfm44z
         oc5nBPcvRQEuD2i28QIgZl8MywmREWCgDQyeVL4pdIAJE3WcWJMrqE/1hlWv/f9iRTAG
         dFN2zZSMtBLa6RM/ZyGEL8JBJFW4W0wx4ZaH74XGW6mAN/1D98A4F5Iw+OJYMyFUPrA3
         mfsMTMsi7OJXs0uMqGh5zCdQvNwCUKWW1wK+wlOoB8CbJFNuTPKdWQN5yrvB7HlYcMOJ
         Y1HQ==
X-Gm-Message-State: AD7BkJIqWKoM6o6ijNYml3ovcelO7CtN1f6ySA7wGNPL+PKV7S7ipalRMmJL9gPhppPSVG/+7DOgsFWh+xmbFA==
X-Received: by 10.55.73.6 with SMTP id w6mr35868584qka.82.1459801302542; Mon,
 04 Apr 2016 13:21:42 -0700 (PDT)
Received: by 10.233.223.4 with HTTP; Mon, 4 Apr 2016 13:21:13 -0700 (PDT)
In-Reply-To: <22DDACCE-6563-4097-9AE3-2CCD80CD0C1F@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290721>

Hi Lars,

thank you so much for reaching out to me! and thank you for your
suggestions too, I'm changing my application to reflect those. It does
really make sense to start the discussion earlier then I scheduled,
and add some extra ideas that could be completed after the
whitelist/blacklist. Probably if those ideas are the extensions to the
whitelist/blacklist, they could be also agreed on when discussing the
overall project scope.

Cheers,
Elena

On Wed, Mar 30, 2016 at 11:21 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> Hi Elena,
>
> I thought a bit more about your proposal. The Outreachy internship is scheduled for 3 months and I think you would be able to come up with a "Git remote whitelist/blacklist" implementation that the Git list considers to accept within a month. In that case it would be good if you would have a few extra ideas in your Outreachy proposal that you could tackle afterwards. These extras could be extensions to the "whitelist/blacklist" project or a contribution to a completely different part of Git. According to the Outreachy page [1] you can still change your application until April 22.
>
> In addition I wonder if you would be willing to start slowly with the "drafting the implementation" task even before April 22. I, and AFAIK the majority of the other people on the list, do not work full time on Git. That means some email responses might be delayed for reasons unrelated to Git. Therefore I think you will have a better experience if you work with a steady slow pace instead of high burst of list activity :-)
>
> Cheers,
> Lars
>
>
> [1] https://wiki.gnome.org/Outreachy#Submit_an_Application
>
>
>> On 29 Mar 2016, at 21:24, Lars Schneider <larsxschneider@gmail.com> wrote:
>>
>> Hi Elena,
>>
>> sorry for the late reply. I think it is great that you are interested in the Git remote whitelist/blacklist idea. Unfortunately I don't have any experience with Outreachy and I wonder what kind of feedback you are looking for.
>>
>> Thanks,
>> Lars
>>
>>
>>> On 26 Mar 2016, at 13:15, elena petrashen <elena.petrashen@gmail.com> wrote:
>>>
>>> Hi everyone,
>>>
>>> I think I will submit the application as it is now, but still
>>> it would be great to get feedback on it, as I don't think
>>> there was no reply because everything was perfect :(
>>>
>>> Thank you! And have an awesome weekend.
>>>
>>> On Thu, Mar 24, 2016 at 5:50 PM, elena petrashen
>>> <elena.petrashen@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> I'm thinking of applying to Outreachy program this round with Git
>>>> and the project I'm really interested in is "Git remote whitelist/blacklist"
>>>> project (http://git.github.io/SoC-2016-Ideas/).
>>>> I have drafted the description/timeline for this project
>>>> and it would be great to get feedback/suggestions.
>>>> (I'm actually a bit confused about the scale of this. The
>>>> Outreachy application doesn't ask for "proposal" in the way
>>>> GSoC seems to, but merely requests "details and the timeline",
>>>> so I'm not sure whether the shorter description of what's planned
>>>> is expected or should I go deeper in detail. I apologize if I
>>>> chose a wrong approach.)
>>>>
>>>> Thank you!
>>>>
>>>>>> What project(s) are you interested in (these can be in the
>>>> same or different organizations)?
>>>> My preferred project to work on is Git remote whitelist/blacklist
>>>> project listed on http://git.github.io/SoC-2016-Ideas/. I'm really
>>>> interested in doing this project as I think this kind of effort is
>>>> really important: I recently started using git myself, and sometimes
>>>> I was really scared to push something to the location I was not
>>>> supposed to push to. I would really appreciate the opportunity in
>>>> participating in making git a bit more newbie-friendly.
>>>>
>>>>>> Who is a possible mentor for the project you are most interested in?
>>>> Lars Schneider
>>>>
>>>>>> Please describe the details and the timeline of the work you
>>>> plan to accomplish on the project you are most interested in (discuss
>>>> these first with the mentor of the project):
>>>> The goal is to provide a safer environment for newcomers to Git to
>>>> enabling the possibility to modify git config, adding there "allowed"
>>>> and "denied" remotes for pushing. Code, tests, and documentation
>>>> are to be created.
>>>>
>>>> Timeline:
>>>> 0. Analysis
>>>> Apr 22 - May 22 - studying the current code and drafting the
>>>> implementation proposal
>>>> 1. Design
>>>> a. May 22-June 1 - discussion with the mentor regarding the task,
>>>> presenting the approach and amending it per mentor's feedback
>>>> b. June 1st-June 15th - communicating with the community
>>>> regarding the suggested changes and agreeing on logic, scope
>>>> and format of changes.
>>>> 2. Development
>>>> c. June 15th-July 1st - submitting code for the first basic version,
>>>> amending it according to the feedback
>>>> d. July 1st - July 15th - extending the code to cover all of the
>>>> agreed scope
>>>> e. July 15th - Aug 1st - finalizing full coverage with tests and
>>>> documentation
>>>> 3. Evaluation
>>>> f. Aug 1st - Aug 23rd - adding nice-to-have features and other
>>>> suggestion by the community
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
