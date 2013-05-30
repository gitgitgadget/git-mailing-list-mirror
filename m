From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands provided
 by default for git
Date: Thu, 30 May 2013 10:32:48 -0500
Message-ID: <CAMP44s2G3NVUyVViF2NP0TEEuGLp-3z+xf-uhsjC-Np80WA-tA@mail.gmail.com>
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
	<20130530145447.GC4884@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 17:32:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui4qU-0004JZ-SR
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 17:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933482Ab3E3Pcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 11:32:51 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:42349 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932445Ab3E3Pcu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 11:32:50 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so706433lbi.18
        for <git@vger.kernel.org>; Thu, 30 May 2013 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=y6s5T5w9Pn3iDIn44G5ILzEvHoq9zldP/9x3L4vcJ1A=;
        b=bwBfkxPScx9/XR1qrbEDbnWto0r7f3PlCRuSrSNCJwhPf/+W/U7nQU+zkwlnqL3/tm
         U9zEhYbSjiyw85O48xZftqouDWDOtbU6ZoM1JzmT43NuJWS6NVh5kvj5BJfqglpyLtcg
         pcucnXmCQy3K6c/5W5qUNaKx0nIjMeLLrG9ncPAYdIZuVBwX7N3mGsjIlsyBztFgKv9w
         ucLNluYYEmamJiOPUQuIAwE9DgRZDC7h0xdqjQaCM9MYmzZ2EjSSnHJPlJ3ujLezXO35
         SeBrjJ72tAtpFhAUjF/+1o/m+UOSo0bRBNof+Ek2RApZ+OE2g9FmUy4HeLsAiP4AYE/Q
         7nHA==
X-Received: by 10.112.133.129 with SMTP id pc1mr1033262lbb.49.1369927968793;
 Thu, 30 May 2013 08:32:48 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Thu, 30 May 2013 08:32:48 -0700 (PDT)
In-Reply-To: <20130530145447.GC4884@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226013>

On Thu, May 30, 2013 at 9:54 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>> On Thu, May 30, 2013 at 12:23 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> Felipe Contreras wrote:
>>>> On Wed, May 29, 2013 at 6:43 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>>>>> A bigger problem (in my opinion) with allowing arbitrary changes to
>>>>> the meaning of existing commands is that scripts, whether placed in
>>>>> .sh files or given as commands to run over IRC, stop working
>>>>> altogether.  It's nice to have commands like "git log" and "git am"
>>>>> mean the same thing no matter what machine I am on.
>>>>
>>>> Except that's not true:
>>>
>>> It's not true that my opinion is that a bigger problem than the
>>> non-problem Ram mentioned with allowing arbitrary changes to the
>>> meaning of existing commands is that scripts stop working reliably?
>>
>> It's not true what you said:
>>
>> commands like "git log" and "git am" mean the same thing no matter
>> what machine I am on.
>
> It's not true that it's nice when they do?

Yeah, it's nice that the sun is purple. Never-mind the fact that it's not true.

The consistency you experience across machines has absolutely nothing
to do with Git, since Git can be configured in a way you don't
consider nice.

So this argument is invalid. Any proposed change to make Git more
configurable is not affected by this argument, because Git can
*already* be configured in a way that would break your experience, yet
it doesn't happen.

In other words; it's the policy or your machine users you have to
thank for, not Git's code, and changing Git's code is not going to
change that policy.

Either way this is a straw man, again, nobody is pushing to allow
builtins to be overridable.

The topic is default *aliases*.

-- 
Felipe Contreras
