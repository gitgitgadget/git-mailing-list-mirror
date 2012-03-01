From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Thu, 1 Mar 2012 23:46:37 +1100
Message-ID: <CAH5451mx-f0vuJzTRRhs5Ttr6D1HvB6ptoj_=-kyWqkZ=KHJ_Q@mail.gmail.com>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
 <8762eoimp0.fsf@thomas.inf.ethz.ch> <CACBZZX4T28m6k7A53Zc32Aquk-jh7_R0KPeq983bSQ3B-r27cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 13:47:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S35PW-0000LV-OS
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 13:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759149Ab2CAMrA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 07:47:00 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38438 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755286Ab2CAMq7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2012 07:46:59 -0500
Received: by wibhm2 with SMTP id hm2so286816wib.19
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 04:46:57 -0800 (PST)
Received-SPF: pass (google.com: domain of andrew.ardill@gmail.com designates 10.180.24.7 as permitted sender) client-ip=10.180.24.7;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of andrew.ardill@gmail.com designates 10.180.24.7 as permitted sender) smtp.mail=andrew.ardill@gmail.com; dkim=pass header.i=andrew.ardill@gmail.com
Received: from mr.google.com ([10.180.24.7])
        by 10.180.24.7 with SMTP id q7mr10349687wif.14.1330606017949 (num_hops = 1);
        Thu, 01 Mar 2012 04:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=DwQ+FG5aOORo5VtsX8ZKeqxhOrHV86/Wi08YQ03ED2M=;
        b=YHGVRaOprs1CfskU96glQa4vMuQENVL6fcm2tdT5NQO6YuRrD25Rs3gkpdKUW9Qjfi
         gGIdbapCPEyicl1XX7HukBaUmWMuFMkQ7Cy5q+SrVpVayBjYXJhc2sqjdcaUsIPwkfFx
         UwGEtnjSmqT2Gwb6pqRZkkmCxiMPcyq1qqftw=
Received: by 10.180.24.7 with SMTP id q7mr8288918wif.14.1330606017778; Thu, 01
 Mar 2012 04:46:57 -0800 (PST)
Received: by 10.223.96.133 with HTTP; Thu, 1 Mar 2012 04:46:37 -0800 (PST)
In-Reply-To: <CACBZZX4T28m6k7A53Zc32Aquk-jh7_R0KPeq983bSQ3B-r27cA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191929>

On 1 March 2012 22:54, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com> wrote:
> As someone who submits patches every once in a while I can echo other
> sentiments in this thread, just because you have a list of issues tha=
t
> doesn't mean anyone is working on them.
>
> However I'd also sometimes like to work on some random issue because
> I'm bored, and having a collection of issues ordered by priority (or
> popularity) would be useful when that happens.

JIRA is particularly good at categorising backlogs and filtering out
issues, so this is a very achievable outcome.

> But I think any proposal to set up a wholly external system is going
> to fail, we do most of our bug submission / commenting etc. on this
> mailing list, and that isn't going to change, so there's always going
> to be a large chasm between the list and any external system.

I agree wholeheartedly.

> What I think *would* work however is a system that feeds off the
> mailing list. This could be as simple as a mailing list aggregator
> that allowed you to star certain messages, and the most starred
> messages would be the popular issues.

This is an interesting idea, not sure how that would be implemented
though. Seems like you would need some client or webservice email
reader that could be extended like that.

> A more fancy solution would:
>
> =C2=A0* Consume every single message that gets sent to the list
> =C2=A0* Group each thread and allow it to be categorized as a
> =C2=A0 bug/issue/enhancement/complaint
> =C2=A0* Allow you to mark a collection of threads as describing the s=
ame
> =C2=A0 issue, so you'd have duplicates marked & the full history of a
> =C2=A0 discussion on some issue.
> =C2=A0* Allow you to mark an issue as outstanding / resolved / allow =
voting
> =C2=A0 on it.
>
> Thus you'd automatically build up an issue database without anyone
> going out of their way, all it would need is the same people who
> complain that they can't file bugs either categorizing existing posts=
,
> or categorizing a post they just made.
>
> Many bug trackers can be made to work with E-Mail (e.g. Jira, RT
> etc.), although I don't know if they're well set up to follow a
> mailing list like this. I think e.g. Jira assumes that you have a the
> bug id in the subject, and might not be smart enough to group things
> by In-Reply-To headers.

JIRA allows creation of issues by sending emails to a special email
address. The process that is used is as follows (take from [1]):

The subject  of an email message is examined for an existing issue key:
 - If an issue key is found in the subject, the content of the email
message's body is processed and added as a comment to the issue with
that issue key.
 - If an issue key is NOT found in the subject, the in-reply-to header
 is examined:
    - If the email message is found to be a reply to another email
message from which an issue was previously created, the body is
processed and added as a comment to that issue.
    - If the email message is NOT found to be a reply, a new issue is c=
reated.

As you can see, it _should_ respect in-reply-to headers, however we
should probably test this :)

Currently only emails that contain issue keys are being captured,
however I will enable issue creation in a throwaway project so we can
test them. I might even set up a forwarder to capture all or most of
the list traffic to see what happens. If we capture any useful issues
in that throwaway project, a valid workflow might be to move them over
to the 'real' project to which they belong. Perhaps the volume will be
low enough in reality that we can enable issues being created directly
in that project, without the move step.

One thing to consider is the notifications sent out by JIRA on
different events. We could potentially send an email to the list
whenever an issue is commented on, resolved, or something else. The
possibilities (and permissions around those possibilities) are quite
versatile, and well worth investigating. For now I will try my best to
stop _all_ automated responses going to the list, until we can be
certain that it won't be just more spam.


Thanks for your thoughts, I think your ideas give a really strong
direction for us to investigate further.

Regards,

Andrew Ardill

[1] http://confluence.atlassian.com/display/JIRA/Creating+Issues+and+Co=
mments+from+Email#CreatingIssuesandCommentsfromEmail-Issuecommentcreati=
on
