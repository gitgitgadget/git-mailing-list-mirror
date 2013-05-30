From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands
 provided by default for git
Date: Thu, 30 May 2013 07:54:47 -0700
Message-ID: <20130530145447.GC4884@elie.Belkin>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
 <CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
 <CAMP44s0Cx-FCZLOFZxcpC86sY+H03HKBi0nKFMgit=B5XCy71g@mail.gmail.com>
 <CALkWK0mBOB1RM+MXH+Nvos29M5vqc2yAtC__zPyowf7imfnz9Q@mail.gmail.com>
 <CAJri6_uScqjovt5eK9f9+Z4ehtsdYQNuiEX1MERiDBEJWueAXg@mail.gmail.com>
 <CALkWK0=5BwterP7ATM1GgFvLUs391w_MW4YrwbnvsbM6Q4_Opg@mail.gmail.com>
 <20130529234335.GE28153@google.com>
 <CAMP44s3807Dk0SOZcBbaOKTLj5k36bW0SA9F5ZBY2MwS1Nnxiw@mail.gmail.com>
 <20130530052318.GA2923@elie.Belkin>
 <CAMP44s2ZWA8+ShRDX0uS==THgHPWtoTfXwECFkPXyjSoyXHM=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?Q?Br=C3=A1ulio?= Bhavamitra <brauliobo@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 16:55:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui4G4-0001Ui-AP
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 16:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933040Ab3E3Oy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 10:54:56 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:52298 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757918Ab3E3Oyx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 10:54:53 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so495296pbb.20
        for <git@vger.kernel.org>; Thu, 30 May 2013 07:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2H2F1nH87rSvhRxSYRt53IZ4ArhHj4ySUHAjxxAC1Xo=;
        b=kyMIX/noo0UcDwfqq7lXI5iELpxPv+SeWP4xByXddojlagOmDUNS9R69aCHJfaIHkh
         BBHecDJ4Cgb449xQCiVTuQn/W+XmOFfXyzwP1WRU5mzNHYHFh/vUmoRWwA3oqgNaj7DX
         oh08OtjcHY5CIxFQy3ik6mL7XkfMdzCg+aFpf3WLcnmGDcOd6QD9jXiCx35z5YbDo0Mc
         zDR3M5Q6d7MFFHqJDA+sf0C/HMowaYaZnn1KJEEZt+PfeLEtUlMJRW5lgXE728ESPftc
         nUIRqBnc3J6PxbyjeAilf2oT1f96ywHSz5YsVWrEWfCrEC2oD/TmyoTJKqDc8tSnt74y
         paNA==
X-Received: by 10.68.243.40 with SMTP id wv8mr4452574pbc.34.1369925692494;
        Thu, 30 May 2013 07:54:52 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id ya4sm42312940pbb.24.2013.05.30.07.54.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 30 May 2013 07:54:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s2ZWA8+ShRDX0uS==THgHPWtoTfXwECFkPXyjSoyXHM=A@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226006>

Felipe Contreras wrote:
> On Thu, May 30, 2013 at 12:23 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Felipe Contreras wrote:
>>> On Wed, May 29, 2013 at 6:43 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>>>> A bigger problem (in my opinion) with allowing arbitrary changes to
>>>> the meaning of existing commands is that scripts, whether placed in
>>>> .sh files or given as commands to run over IRC, stop working
>>>> altogether.  It's nice to have commands like "git log" and "git am"
>>>> mean the same thing no matter what machine I am on.
>>>
>>> Except that's not true:
>>
>> It's not true that my opinion is that a bigger problem than the
>> non-problem Ram mentioned with allowing arbitrary changes to the
>> meaning of existing commands is that scripts stop working reliably?
>
> It's not true what you said:
>
> commands like "git log" and "git am" mean the same thing no matter
> what machine I am on.

It's not true that it's nice when they do?

>> This combative style of communication is toxic.  It kills the chance
>> of a calm, pleasant discussion, even with patient people who don't
>> even fundamentally disagree.  Please stop it.
>
> Stop assuming bad faith[1].

Perhaps you mean "I'm trying, but I'm human  --- please bear with me
while I work on improving.  Know that my intentions are good."

Unfortunately, good intentions are not enough.  Communicating in a way
that clearly conveys what you mean instead of something else that
derails the conversation is a real skill and, as I said, it's an
important one that is basic to being able to have a productive
conversation.  If you are working on it and are not there yet, my best
advice would be to lurk more and speak less, to learn from the example
of others, and to start by working on how to receive criticism and to
clear up misunderstandings, which can at least mitigate the damage
when things go wrong.

You have accused others of assuming bad faith in the past, which only
escalates things.  It's not a good way to move forward.  It's possible
that the best way to move forward involves some way (e.g., mail client
configuration that holds messages in "drafts" for a little while
before sending them out) of being able to cool down when discussions
get hot.

Sincerely,
Jonathan
