From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [Outreachy] Git remote whitelist/blacklist
Date: Wed, 30 Mar 2016 10:21:18 +0200
Message-ID: <22DDACCE-6563-4097-9AE3-2CCD80CD0C1F@gmail.com>
References: <CAJPOeMdLHOJqgevGz8jirx-PnvNHbAUsHknBG_1hzZ5srBseEw@mail.gmail.com> <CAJPOeMe2p0eh6Lju2L3JB8zHFKcQozNAO673FUQtrc4q5fOfrA@mail.gmail.com> <BDAD45DF-8E1B-4BD7-AE5E-FC4788BC7634@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: elena petrashen <elena.petrashen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 10:31:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alBNb-0001Wf-Pd
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 10:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758678AbcC3IV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 04:21:26 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37049 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbcC3IVX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2016 04:21:23 -0400
Received: by mail-wm0-f47.google.com with SMTP id p65so60058397wmp.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 01:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=S6LgLMygse/vykKV8qcWmLk+zglpQbFdBBfrZUbsn90=;
        b=GgsA1ONMwt4VBRQlIAotxJUTPDI16rXmqNw9LlUUUCCEXaCVTaut0wGkq5065lmN+J
         Q0PzT9Yg1izfOWYWtkQlUgbwf29OQIe6Bt/wssv1vvcHwYHdESJIjooN5JSUtZbhF8Nx
         tqPgVHEimcPro/3rsMHsjthEN4KONQ3m4wR4I9VOW909HhMz55gK5lr+MpH0+FvI5apj
         IxMOaNMPz7Gz7TtKTFX2Xsz2yRHl4FAyNKiijVeW2cNsqrAOhYWvekuwP0My+Mg39xB4
         KBzXfID1tdgOBQFDKVBoaI3ifDFLO5Fne7R0C6j5ESEjSnbMB+VBKdjJpcFnSjGMQPVY
         eTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=S6LgLMygse/vykKV8qcWmLk+zglpQbFdBBfrZUbsn90=;
        b=Fe1w4j/QgQA7sa8AcgoUNN8rB26ft8uarkiiyr9uPIdQyNs4oyqp52dMAsJ5pvpzYZ
         B2zPj58Yxo4OyGRAnErqorfWyExryQBD6AmLiFempsuy+GOGVdqQgQpm6PrhsRS4cVtQ
         fA36jUZXH2eTlIBiF37DL+7w8Q/ngnrbz4uAsH1aeBIz9T14AltFvtIFdh7BzTL63ap3
         gLWy9pjxctPS9galyswXLWmFYPSMl83vMmMaCqAwJWRBCUFRnjmf29YW6JuGn1YsD1ud
         Ih5U77R/jKzH5gABIR0nL4o9Co6K91RvauOmOWQe9qDk8i9vA92VFG0V6dxGNpbJ2vNf
         onHw==
X-Gm-Message-State: AD7BkJKoVntYeZhIhbWEL95dnj0pb1XgCUxiQdzgoPheqHgkO4vHmubZSKPW6K/eENiSKA==
X-Received: by 10.28.220.215 with SMTP id t206mr8330792wmg.68.1459326080535;
        Wed, 30 Mar 2016 01:21:20 -0700 (PDT)
Received: from slxbook4.fritz.box (p508BA13A.dip0.t-ipconnect.de. [80.139.161.58])
        by smtp.gmail.com with ESMTPSA id wr2sm2615686wjc.49.2016.03.30.01.21.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 01:21:19 -0700 (PDT)
In-Reply-To: <BDAD45DF-8E1B-4BD7-AE5E-FC4788BC7634@gmail.com>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290277>

Hi Elena,

I thought a bit more about your proposal. The Outreachy internship is scheduled for 3 months and I think you would be able to come up with a "Git remote whitelist/blacklist" implementation that the Git list considers to accept within a month. In that case it would be good if you would have a few extra ideas in your Outreachy proposal that you could tackle afterwards. These extras could be extensions to the "whitelist/blacklist" project or a contribution to a completely different part of Git. According to the Outreachy page [1] you can still change your application until April 22.

In addition I wonder if you would be willing to start slowly with the "drafting the implementation" task even before April 22. I, and AFAIK the majority of the other people on the list, do not work full time on Git. That means some email responses might be delayed for reasons unrelated to Git. Therefore I think you will have a better experience if you work with a steady slow pace instead of high burst of list activity :-)

Cheers,
Lars
  

[1] https://wiki.gnome.org/Outreachy#Submit_an_Application


> On 29 Mar 2016, at 21:24, Lars Schneider <larsxschneider@gmail.com> wrote:
> 
> Hi Elena,
> 
> sorry for the late reply. I think it is great that you are interested in the Git remote whitelist/blacklist idea. Unfortunately I don't have any experience with Outreachy and I wonder what kind of feedback you are looking for.
> 
> Thanks,
> Lars
> 
> 
>> On 26 Mar 2016, at 13:15, elena petrashen <elena.petrashen@gmail.com> wrote:
>> 
>> Hi everyone,
>> 
>> I think I will submit the application as it is now, but still
>> it would be great to get feedback on it, as I don't think
>> there was no reply because everything was perfect :(
>> 
>> Thank you! And have an awesome weekend.
>> 
>> On Thu, Mar 24, 2016 at 5:50 PM, elena petrashen
>> <elena.petrashen@gmail.com> wrote:
>>> Hi,
>>> 
>>> I'm thinking of applying to Outreachy program this round with Git
>>> and the project I'm really interested in is "Git remote whitelist/blacklist"
>>> project (http://git.github.io/SoC-2016-Ideas/).
>>> I have drafted the description/timeline for this project
>>> and it would be great to get feedback/suggestions.
>>> (I'm actually a bit confused about the scale of this. The
>>> Outreachy application doesn't ask for "proposal" in the way
>>> GSoC seems to, but merely requests "details and the timeline",
>>> so I'm not sure whether the shorter description of what's planned
>>> is expected or should I go deeper in detail. I apologize if I
>>> chose a wrong approach.)
>>> 
>>> Thank you!
>>> 
>>>>> What project(s) are you interested in (these can be in the
>>> same or different organizations)?
>>> My preferred project to work on is Git remote whitelist/blacklist
>>> project listed on http://git.github.io/SoC-2016-Ideas/. I'm really
>>> interested in doing this project as I think this kind of effort is
>>> really important: I recently started using git myself, and sometimes
>>> I was really scared to push something to the location I was not
>>> supposed to push to. I would really appreciate the opportunity in
>>> participating in making git a bit more newbie-friendly.
>>> 
>>>>> Who is a possible mentor for the project you are most interested in?
>>> Lars Schneider
>>> 
>>>>> Please describe the details and the timeline of the work you
>>> plan to accomplish on the project you are most interested in (discuss
>>> these first with the mentor of the project):
>>> The goal is to provide a safer environment for newcomers to Git to
>>> enabling the possibility to modify git config, adding there "allowed"
>>> and "denied" remotes for pushing. Code, tests, and documentation
>>> are to be created.
>>> 
>>> Timeline:
>>> 0. Analysis
>>> Apr 22 - May 22 - studying the current code and drafting the
>>> implementation proposal
>>> 1. Design
>>> a. May 22-June 1 - discussion with the mentor regarding the task,
>>> presenting the approach and amending it per mentor's feedback
>>> b. June 1st-June 15th - communicating with the community
>>> regarding the suggested changes and agreeing on logic, scope
>>> and format of changes.
>>> 2. Development
>>> c. June 15th-July 1st - submitting code for the first basic version,
>>> amending it according to the feedback
>>> d. July 1st - July 15th - extending the code to cover all of the
>>> agreed scope
>>> e. July 15th - Aug 1st - finalizing full coverage with tests and
>>> documentation
>>> 3. Evaluation
>>> f. Aug 1st - Aug 23rd - adding nice-to-have features and other
>>> suggestion by the community
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
