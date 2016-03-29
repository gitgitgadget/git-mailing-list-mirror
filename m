From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [Outreachy] Git remote whitelist/blacklist
Date: Tue, 29 Mar 2016 21:24:41 +0200
Message-ID: <BDAD45DF-8E1B-4BD7-AE5E-FC4788BC7634@gmail.com>
References: <CAJPOeMdLHOJqgevGz8jirx-PnvNHbAUsHknBG_1hzZ5srBseEw@mail.gmail.com> <CAJPOeMe2p0eh6Lju2L3JB8zHFKcQozNAO673FUQtrc4q5fOfrA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: elena petrashen <elena.petrashen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:24:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akzFy-0001fd-OL
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbcC2TYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 15:24:47 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34188 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561AbcC2TYp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 15:24:45 -0400
Received: by mail-wm0-f45.google.com with SMTP id p65so153964652wmp.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QmhmHwfi5NG7THAw1Rku1HFVHL3wV3WyeiUh9lMzIQc=;
        b=Mlwjgf485yykRmWxKpdiw2ZzbZxk+6MBeCIzqXxqOHeU+54uRpOnrdhyZm2BHqpboh
         JkV38Ky2IPnSs0JibNk0qjkpVdeG6i6e3DMlAgRLCbxqW4qDIXOdJJbToNJibAGFsVFN
         hu1Aq8l4iceU55Ds0nKC3gAcKJq4uoYJv5JGO4z7R2zXZT6gc6m5KnkjB2p1xTSH2lv3
         KlZlegd/Vse65hsuK6aTrFPSQavSpw99r+wNDO5r1cU0NJ8cMzXY7FJktT6SHdYOMbaX
         aO0ea3cCU0l/FG6fIZn4PShfi5gVqVbpi1kUvNn9rQdCBrA8mAw1kQS8L6Wgvvl/cL68
         w5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QmhmHwfi5NG7THAw1Rku1HFVHL3wV3WyeiUh9lMzIQc=;
        b=TekyQTYsLwuV4nlRSt6OqkaiqSToX1Vczsj5Q3G7s3MP+Vp4gkK5CWGXOhVACo3Q7Y
         TwxKZCZjQE+SNIf6f99LvYW1KDAyZ+SEmx3VwLmfYC2A/Faa7d7zZvcX+B7EgYwnYene
         892FgGm4dB2xNIDFXSwhkfU2Qf1Ghh+EgjYyuBkvKdqO2bu1Og0z+tUzHLSuMwTk6lJB
         ZgU72WCedf1h+wVozrg+6zPqCfBGvz7t+BWON1D9+8m2E1NT3pWdIu076e7NpJs0v8aW
         /Qvrua0Dl8ZkQ3PE6FJS/D6skdXebLovgPb76HzT4KHpuw0yWYG6u7MTBZgPMWCz2sEC
         T64Q==
X-Gm-Message-State: AD7BkJJTPnkUa0rl06JAPfte/xDgrxCmMoG53M/wzWkBBZgUAkCqjeQY7LZZss2rOZ+a2g==
X-Received: by 10.194.83.42 with SMTP id n10mr4690387wjy.20.1459279483676;
        Tue, 29 Mar 2016 12:24:43 -0700 (PDT)
Received: from slxbook4.fritz.box (p508BA602.dip0.t-ipconnect.de. [80.139.166.2])
        by smtp.gmail.com with ESMTPSA id fv6sm206224wjc.12.2016.03.29.12.24.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 12:24:42 -0700 (PDT)
In-Reply-To: <CAJPOeMe2p0eh6Lju2L3JB8zHFKcQozNAO673FUQtrc4q5fOfrA@mail.gmail.com>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290169>

Hi Elena,

sorry for the late reply. I think it is great that you are interested in the Git remote whitelist/blacklist idea. Unfortunately I don't have any experience with Outreachy and I wonder what kind of feedback you are looking for.

Thanks,
Lars


> On 26 Mar 2016, at 13:15, elena petrashen <elena.petrashen@gmail.com> wrote:
> 
> Hi everyone,
> 
> I think I will submit the application as it is now, but still
> it would be great to get feedback on it, as I don't think
> there was no reply because everything was perfect :(
> 
> Thank you! And have an awesome weekend.
> 
> On Thu, Mar 24, 2016 at 5:50 PM, elena petrashen
> <elena.petrashen@gmail.com> wrote:
>> Hi,
>> 
>> I'm thinking of applying to Outreachy program this round with Git
>> and the project I'm really interested in is "Git remote whitelist/blacklist"
>> project (http://git.github.io/SoC-2016-Ideas/).
>> I have drafted the description/timeline for this project
>> and it would be great to get feedback/suggestions.
>> (I'm actually a bit confused about the scale of this. The
>> Outreachy application doesn't ask for "proposal" in the way
>> GSoC seems to, but merely requests "details and the timeline",
>> so I'm not sure whether the shorter description of what's planned
>> is expected or should I go deeper in detail. I apologize if I
>> chose a wrong approach.)
>> 
>> Thank you!
>> 
>>>> What project(s) are you interested in (these can be in the
>> same or different organizations)?
>> My preferred project to work on is Git remote whitelist/blacklist
>> project listed on http://git.github.io/SoC-2016-Ideas/. I'm really
>> interested in doing this project as I think this kind of effort is
>> really important: I recently started using git myself, and sometimes
>> I was really scared to push something to the location I was not
>> supposed to push to. I would really appreciate the opportunity in
>> participating in making git a bit more newbie-friendly.
>> 
>>>> Who is a possible mentor for the project you are most interested in?
>> Lars Schneider
>> 
>>>> Please describe the details and the timeline of the work you
>> plan to accomplish on the project you are most interested in (discuss
>> these first with the mentor of the project):
>> The goal is to provide a safer environment for newcomers to Git to
>> enabling the possibility to modify git config, adding there "allowed"
>> and "denied" remotes for pushing. Code, tests, and documentation
>> are to be created.
>> 
>> Timeline:
>> 0. Analysis
>>  Apr 22 - May 22 - studying the current code and drafting the
>> implementation proposal
>> 1. Design
>> a. May 22-June 1 - discussion with the mentor regarding the task,
>> presenting the approach and amending it per mentor's feedback
>> b. June 1st-June 15th - communicating with the community
>> regarding the suggested changes and agreeing on logic, scope
>> and format of changes.
>> 2. Development
>> c. June 15th-July 1st - submitting code for the first basic version,
>> amending it according to the feedback
>> d. July 1st - July 15th - extending the code to cover all of the
>> agreed scope
>> e. July 15th - Aug 1st - finalizing full coverage with tests and
>> documentation
>> 3. Evaluation
>> f. Aug 1st - Aug 23rd - adding nice-to-have features and other
>> suggestion by the community
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
