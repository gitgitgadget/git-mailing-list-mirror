From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead
 Of Pull Requests
Date: Thu, 01 Mar 2012 23:50:04 -0600
Message-ID: <4F505F8C.70802@gmail.com>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com> <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino> <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com> <8762eoimp0.fsf@thomas.inf.ethz.ch> <7vmx80nt68.fsf@alter.siamese.dyndns.org> <4F504699.3070406@gmail.com> <20120302041924.GG5248@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 06:50:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3LNY-0003aI-Uh
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 06:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923Ab2CBFuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 00:50:04 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47129 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786Ab2CBFuC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 00:50:02 -0500
Received: by yenl12 with SMTP id l12so651470yen.19
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 21:50:01 -0800 (PST)
Received-SPF: pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.154.137 as permitted sender) client-ip=10.236.154.137;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.154.137 as permitted sender) smtp.mail=nkreitzinger@gmail.com; dkim=pass header.i=nkreitzinger@gmail.com
Received: from mr.google.com ([10.236.154.137])
        by 10.236.154.137 with SMTP id h9mr11484471yhk.91.1330667401458 (num_hops = 1);
        Thu, 01 Mar 2012 21:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=u8rlCPTplry9jI0XkJO9B7eFSMv0IHex1YRYN2Fxaf8=;
        b=AWaJ8JddkM8u7VTQrsTeN417CKSmD4M4J9DlCqKrDA9FZAPLAMHN2E6O8XFxMeOynn
         u2aLLq+InHrx5Y7mXesNQUZX47HH7N/81UFgHjcdnruSxpa3Mgwuk12gtDh8Hx2W7q7s
         fLMY/o62J7/lm5WZgov+UKiqy0Zo50XFUDlhRvF63YjlvflnF8GVB47UHCRbY8zUNlxE
         QS0pLLuQH0h8K334Ajr+H/MpQP5wK4ibIMq9WKWpwGbeCmYgYsKQdOVxfR6eDoYNDu7H
         eeFGf+WgYJBoizVz3NadAUEpY6Q0BwrKKKu/ssdm/F/iSRHOkPypUNRf4+F+BhOngoEM
         1J5A==
Received: by 10.236.154.137 with SMTP id h9mr9088929yhk.91.1330667401412;
        Thu, 01 Mar 2012 21:50:01 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id g21sm7203624ani.13.2012.03.01.21.50.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Mar 2012 21:50:01 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <20120302041924.GG5248@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192001>

On 3/1/2012 10:19 PM, Jonathan Nieder wrote:
>
> That said, a good distributed bugtracker (which implies solving hard
> social problems like "what to do if different contributors disagree on
> severity"
How do you solve that now?  You can have a field in the bug-report.txt 
for "severity" or a severity-file in the commit.  If people keep 
changing it and don't listen to the appointed tie-breaker then those 
people's patches probably aren't going to get applied anyway.

>   and simple technical problems like "how to present a
> coherent conversation based on threads by people who might not have
> been aware of each other") would be a very nice thing to see,
> regardless of the choice of storage and network protocol used to back
> it.
You can have a field in bug-report.txt called "discussion thread" or a 
file called discussion-thread.txt that contains the link to the mailing 
list for that thread (even terminal emulators automatically bring up 
links when you click on them).  People would have discussions there like 
they do now.  Real progress updates would be recorded in git.  
Discussions would remain on the mailing list.  Thread posts could also 
be recorded as git-notes.

Please let me know what else is a "hard social problem".  I'm not a 
bug-tracker expert but I've used a few bug-tracking systems and worked 
plenty of bugs though never on an opensource project so maybe I'm not 
aware of the "hard social problems".

That being said, I was in a position where I fixed on average over one 
bug per day (reported, fixed, tested, moved to production) for a total 
of 2,000+ bugfixes over about 6 years.  The most in one day was about 
eight (1 per hour).  It was a home-grown bugtracking system based on 
lotus-notes (ie, email integration).  Git has send-mail and the mailing 
list.  The workflow was:

(1) User submits bug-report (or enhancement-request).  Status = 
Unassigned,  Severity = whatever.
(2) Manager reviews bug-report and assigns to developer or rejects it.  
Status = Development or Rejected, Severity = whatever (manager might 
change it).
(3) Developer makes fix and marks ready for QA.  Status = QA.
(3.1)  during development Developer makes comments that are sent as 
emails and User reciprocates.
(4) User/tester tests fix and gives signoff.  Status = Move-to-Prod.
(4.1)  during testing the user/tester and developer make comments that 
are sent as emails.
(5) Developer promotes fix to production.  Status = Completed.
(6) Manager receives notice and acknowledges.  Status = Closed.

Here's how that might work with git:

(1) User (john.doe@nowhere.com) submits bug-report (or request).  Status 
= Unassigned,  Severity = whatever.
[BUG]  (starts the thread)

(2) Manager (git-maintainer) reviews bug-report and assigns to developer 
(or lieutenant) or rejects it.  Status = Development or Rejected, 
Severity = whatever.
[DEV] | [REJ]  (assigned to developer/lieutentant or rejected)

(3) Developer makes fix and marks ready for QA.  Status = QA.
(3.1)  during development Developer makes comments that are sent as 
emails and User reciprocates. (makes posts to thread on mailing list)
[QA]  (fix is in next)

(4) User/tester tests fix and gives signoff.  Status = Move-to-Prod.
(4.1)  during testing the user/tester and developer make comments that 
are sent as emails. (makes posts to thread on mailing list)
[PAS]  (fix passed testing)

(5) Developer promotes fix to production.  Status = Completed.
[CMP]  (fix is in rc)

(6) Manager (git-maintainer) receives notice.  Status = Closed.
[CLS]  (fix is in release)

I realize this is not an exact match of the git-workflow, but you get 
the idea.  I'm also new to mailinglists so I'm not sure if you can 
change part of the subject line.  If not, a header in the body could 
possibly be used.

Thank you for your time and consideration.

v/r,
neal
