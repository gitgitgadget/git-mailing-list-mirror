From: elena petrashen <elena.petrashen@gmail.com>
Subject: Re: [Outreachy] Git remote whitelist/blacklist
Date: Sat, 26 Mar 2016 15:15:25 +0300
Message-ID: <CAJPOeMe2p0eh6Lju2L3JB8zHFKcQozNAO673FUQtrc4q5fOfrA@mail.gmail.com>
References: <CAJPOeMdLHOJqgevGz8jirx-PnvNHbAUsHknBG_1hzZ5srBseEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 26 13:16:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajn8O-0004FD-Au
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 13:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbcCZMP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2016 08:15:57 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33370 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbcCZMP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2016 08:15:56 -0400
Received: by mail-qg0-f47.google.com with SMTP id j35so77443819qge.0
        for <git@vger.kernel.org>; Sat, 26 Mar 2016 05:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=j92Epj2VCOg8X2rasjpMUxUwmSnll7/L1rja2ScMTys=;
        b=rRYfHVE+CzwAmk8OXj+sZURTGCTgNsn5fM++poSEhIMR3sH394pDqRj3OVCO5Yv7OW
         22gmM6eYDopsYP6pFH1+BUNiXthRbP39NSp3fkL70lJFfsqi3A8hd9FvpxPfav+G5Lf0
         l++luDwYgbmhxtT+NPHh2paIT75GNmUFkVHrG26UFipNVg2lmnI0nL5ojcEXENuJclM4
         BH9xd3cKhMqKPqdU7qxb7iOvmCH4LLYhYArPAvxItcz/HkmP2i25pcwvcRft22WMjgip
         5UTwU6AQN+XQl3dlBlWtdMYee5qioibHhJ8KLOr+XhgzFInP/VlZmqQHZe6GS6x6p9fp
         1xOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=j92Epj2VCOg8X2rasjpMUxUwmSnll7/L1rja2ScMTys=;
        b=VAJPgw6rttYCxtbvkhMi2OcZYOrOMwNtv2Ccuo5F1EcOiMhd1EYdJiZRMCYZtVJnRL
         0bDERaTAxtFwU9LCK6z3VKK1HppwWnMcn1jOXdueVNY/7Rjc9HvefL2OS1G8uTe1dUUh
         dbpdFjzrWSfLRYCGUSXzO1vpCoxrO92MaHYHWA1QD6N8Sn96S5OuAlDnNUsMI5NrmV1X
         zuREBKYmWzCNg+eahWQvrGy7o2n6GoSq1p+abtgBY8qczFFw5hvOfUyxbsHQvCodQXYb
         X684+sci7MdAMA9S7D47NKfDt5DSsuXBpNzS1X5lwmzygFM6D8Si8PMYZIOFEsQvHdnl
         ur8A==
X-Gm-Message-State: AD7BkJJBadi8rJjG0/L/TOnG38c2ZIje9RUDOeYGWo6Of4Ta92ZL5EcMLvKjIcsEsSOSQVJ6zOBn3CfYGqHp0Q==
X-Received: by 10.140.42.137 with SMTP id c9mr23316441qga.5.1458994555284;
 Sat, 26 Mar 2016 05:15:55 -0700 (PDT)
Received: by 10.233.223.4 with HTTP; Sat, 26 Mar 2016 05:15:25 -0700 (PDT)
In-Reply-To: <CAJPOeMdLHOJqgevGz8jirx-PnvNHbAUsHknBG_1hzZ5srBseEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289983>

Hi everyone,

I think I will submit the application as it is now, but still
it would be great to get feedback on it, as I don't think
there was no reply because everything was perfect :(

Thank you! And have an awesome weekend.

On Thu, Mar 24, 2016 at 5:50 PM, elena petrashen
<elena.petrashen@gmail.com> wrote:
> Hi,
>
> I'm thinking of applying to Outreachy program this round with Git
> and the project I'm really interested in is "Git remote whitelist/blacklist"
> project (http://git.github.io/SoC-2016-Ideas/).
> I have drafted the description/timeline for this project
> and it would be great to get feedback/suggestions.
> (I'm actually a bit confused about the scale of this. The
> Outreachy application doesn't ask for "proposal" in the way
> GSoC seems to, but merely requests "details and the timeline",
> so I'm not sure whether the shorter description of what's planned
> is expected or should I go deeper in detail. I apologize if I
> chose a wrong approach.)
>
> Thank you!
>
>>> What project(s) are you interested in (these can be in the
> same or different organizations)?
> My preferred project to work on is Git remote whitelist/blacklist
> project listed on http://git.github.io/SoC-2016-Ideas/. I'm really
> interested in doing this project as I think this kind of effort is
> really important: I recently started using git myself, and sometimes
> I was really scared to push something to the location I was not
> supposed to push to. I would really appreciate the opportunity in
> participating in making git a bit more newbie-friendly.
>
>>> Who is a possible mentor for the project you are most interested in?
> Lars Schneider
>
>>> Please describe the details and the timeline of the work you
> plan to accomplish on the project you are most interested in (discuss
> these first with the mentor of the project):
> The goal is to provide a safer environment for newcomers to Git to
>  enabling the possibility to modify git config, adding there "allowed"
>  and "denied" remotes for pushing. Code, tests, and documentation
>  are to be created.
>
> Timeline:
> 0. Analysis
>   Apr 22 - May 22 - studying the current code and drafting the
> implementation proposal
> 1. Design
>  a. May 22-June 1 - discussion with the mentor regarding the task,
> presenting the approach and amending it per mentor's feedback
>  b. June 1st-June 15th - communicating with the community
> regarding the suggested changes and agreeing on logic, scope
> and format of changes.
> 2. Development
>  c. June 15th-July 1st - submitting code for the first basic version,
> amending it according to the feedback
>  d. July 1st - July 15th - extending the code to cover all of the
> agreed scope
>  e. July 15th - Aug 1st - finalizing full coverage with tests and
> documentation
> 3. Evaluation
>  f. Aug 1st - Aug 23rd - adding nice-to-have features and other
> suggestion by the community
