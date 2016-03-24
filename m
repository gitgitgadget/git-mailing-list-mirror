From: elena petrashen <elena.petrashen@gmail.com>
Subject: [Outreachy] Git remote whitelist/blacklist
Date: Thu, 24 Mar 2016 17:50:54 +0300
Message-ID: <CAJPOeMdLHOJqgevGz8jirx-PnvNHbAUsHknBG_1hzZ5srBseEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: larsxschneider@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 15:51:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj6bw-0008DL-48
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 15:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756844AbcCXOve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 10:51:34 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34819 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757779AbcCXOvY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 10:51:24 -0400
Received: by mail-qg0-f45.google.com with SMTP id y89so40009943qge.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dVSjk99NzXlLOLPfO0K6VnO3FXw58y/mvJ1PfX6f3E0=;
        b=msQD9Eor2BlWJhttbS8FsvoiS2WML0zKfjCseFti8zj0hi14B/EC6CWnVQEBsRur2f
         WxvpgPRSxsZweQyHgh2KSRXTA0nXRMqXUJMQZkbDQ+TvNZQLMA5D8qGL4bV/o/ArXAH1
         q0rkwN4rRMDmRakI5ZSxRuYAq9hDPLdbYGf0amuZD6QFptzQ0aPpl+PUj8W+nfHmalAD
         j2LzLQojZyQsIWUTwfbN0ag017xYK6xk80GVPGMFRxYT7b08a/LachzhqMDOxImYNx1l
         nJLl7aD5C/cmNxIsNqBURwLKVSjGeG9cR3Q6dKegL/eVkPS7wfqkBJonyBu67EvlP/NP
         rFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dVSjk99NzXlLOLPfO0K6VnO3FXw58y/mvJ1PfX6f3E0=;
        b=JrQeAL7G/BHF2CJC7u5x9ATM3u+1Y+hIHXiC13KNaP6IXMAB1NRK9SyaWUXxwLa8Xf
         yyF9JUTnpMy8sZIpwvYFFw/47WY/wcIO7F1WF8y6dqN1Y1iNC+ASuOudORHZakF10oX/
         tmeLDsyegXPxCzhUBsFt0taO9oqHt81G1O1bG4FKp281NypRPpGaUAMww5dN/5lYJb16
         GysdWpjJDgaCm/6NlkJoaCN11pfq+2QrlN+kMlc9L6WRke0d79vf6kJczHHr+SfhZ4Tz
         2yh2y034N8Bp+XxJQxMZv43ni5BOEKWMWtgnUtU0cjYlrjkk7xfwpPEXgQB7BCqhjZiv
         3IQA==
X-Gm-Message-State: AD7BkJK6542Q6V7kleefYP0ACFFBdtZZD+yxfDtBxY5Z/hhAXKEZQl0lRRuyGU/w++f49yd4BaeRN5hbKGMUnQ==
X-Received: by 10.141.3.11 with SMTP id f11mr11710686qhd.90.1458831083908;
 Thu, 24 Mar 2016 07:51:23 -0700 (PDT)
Received: by 10.233.223.4 with HTTP; Thu, 24 Mar 2016 07:50:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289749>

Hi,

I'm thinking of applying to Outreachy program this round with Git
and the project I'm really interested in is "Git remote whitelist/blacklist"
project (http://git.github.io/SoC-2016-Ideas/).
I have drafted the description/timeline for this project
and it would be great to get feedback/suggestions.
(I'm actually a bit confused about the scale of this. The
Outreachy application doesn't ask for "proposal" in the way
GSoC seems to, but merely requests "details and the timeline",
so I'm not sure whether the shorter description of what's planned
is expected or should I go deeper in detail. I apologize if I
chose a wrong approach.)

Thank you!

>> What project(s) are you interested in (these can be in the
same or different organizations)?
My preferred project to work on is Git remote whitelist/blacklist
project listed on http://git.github.io/SoC-2016-Ideas/. I'm really
interested in doing this project as I think this kind of effort is
really important: I recently started using git myself, and sometimes
I was really scared to push something to the location I was not
supposed to push to. I would really appreciate the opportunity in
participating in making git a bit more newbie-friendly.

>> Who is a possible mentor for the project you are most interested in?
Lars Schneider

>> Please describe the details and the timeline of the work you
plan to accomplish on the project you are most interested in (discuss
these first with the mentor of the project):
The goal is to provide a safer environment for newcomers to Git to
 enabling the possibility to modify git config, adding there "allowed"
 and "denied" remotes for pushing. Code, tests, and documentation
 are to be created.

Timeline:
0. Analysis
  Apr 22 - May 22 - studying the current code and drafting the
implementation proposal
1. Design
 a. May 22-June 1 - discussion with the mentor regarding the task,
presenting the approach and amending it per mentor's feedback
 b. June 1st-June 15th - communicating with the community
regarding the suggested changes and agreeing on logic, scope
and format of changes.
2. Development
 c. June 15th-July 1st - submitting code for the first basic version,
amending it according to the feedback
 d. July 1st - July 15th - extending the code to cover all of the
agreed scope
 e. July 15th - Aug 1st - finalizing full coverage with tests and
documentation
3. Evaluation
 f. Aug 1st - Aug 23rd - adding nice-to-have features and other
suggestion by the community
