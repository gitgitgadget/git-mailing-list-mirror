From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Thu, 1 Mar 2012 10:58:56 +1100
Message-ID: <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 00:59:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2tQb-0007Lv-AU
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 00:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757242Ab2B2X7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 18:59:19 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:62858 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162Ab2B2X7S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 18:59:18 -0500
Received: by wibhm11 with SMTP id hm11so6729wib.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 15:59:16 -0800 (PST)
Received-SPF: pass (google.com: domain of andrew.ardill@gmail.com designates 10.180.104.4 as permitted sender) client-ip=10.180.104.4;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of andrew.ardill@gmail.com designates 10.180.104.4 as permitted sender) smtp.mail=andrew.ardill@gmail.com; dkim=pass header.i=andrew.ardill@gmail.com
Received: from mr.google.com ([10.180.104.4])
        by 10.180.104.4 with SMTP id ga4mr21357009wib.17.1330559956873 (num_hops = 1);
        Wed, 29 Feb 2012 15:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kZx5sagUM6YOajAK5EbAy9dttOd/JM205N2RfLTs7Ho=;
        b=gvwevdx4fT4wVhAJsZpGY05NE6p/EPasZXz8odnnUxsVk5s4lQOw4VCGwfamt4kPSq
         9u2EDoJn2EMGh4DYcDvsE55+hR2jin4DixZ+37Fli2MGnDjpiOTiufU25Lz1Q8C6osQV
         mytdoOJzBYX5WGfr3B1pEXKyGWPwhj3pjnptw=
Received: by 10.180.104.4 with SMTP id ga4mr17095562wib.17.1330559956769; Wed,
 29 Feb 2012 15:59:16 -0800 (PST)
Received: by 10.223.96.133 with HTTP; Wed, 29 Feb 2012 15:58:56 -0800 (PST)
In-Reply-To: <20120229225304.GA9099@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191864>

On 1 March 2012 09:53, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Junio C Hamano wrote:
>> opticyclic <opticyclic@gmail.com> writes:
>
>>> Firstly, why is there no Bug Tracker such as JIRA for the git project?
>>
>> Probably because nobody volunteered to set-up, actively de-dupe, triage
>> and maintain it in general.
>
> By the way, my usual offer/shameless plug[*] still stands: anyone who
> can stand the interface is welcome to file, triage, and work on bugs
> in the bugtracker at <http://bugs.debian.org/src:git>, as long as it
> seems possible that your bugs might also affect Debian.
>
> "Work on" usually means "forward to the git mailing list", but maybe
> having a bug number is a comfort to some people. ;-) See
> <http://www.debian.org/Bugs/Reporting> for instructions.
>
> All that said, that is still not The Bug Tracker for the git project.
> I would not want it advertised on git-scm.com until we have had some
> more practice dealing with outside bugs, and maybe more contributors
> sorting through them.
>
> It may be that others provide a similar service.
>
> Hope that clarifies a little,
> Jonathan
>
> [*] http://thread.gmane.org/gmane.comp.version-control.git/181336/focus=181402

I mentioned I was going to do this a while ago, but decided to bite
the bullet and actually do it.

I have set up a JIRA instance using Atlassian's OnDemand service,
available at https://git-scm.atlassian.net/

The set-up is a work in progress, so don't be surprised if you log in
and it is not brimming with content!

For now I have locked it down so that anyone can sign up and log in,
but only approved users can create issues. I imagine this restriction
will be loosened down the track, but for now if you would like to
contribute please email me directly with your username and I will add
you as a 'Trusted User' (you will need to sign up first). For now,
normal users and trusted users are identical except that trusted can
create new issues.
If you want to update issues you will need to be a 'Developer' - if
you think you fall into this category please tell me and I will add
you to it as well (this is the role I think most people active on this
list will need to be)! This will allow you to edit issues, be assigned
issues and resolve them.

If anyone has experience administrating JIRA and want to help out
_please_ let me know as I know how quickly these things can grow and
become unmanageable. Additionally, if anyone has any ideas, or thinks
we should throw the gates open now (as opposed to locking it down for
a time) comment here and we can make it happen.

As I see it (and Junio has mentioned before) we are going to need
people who are able to manage the issues in this system, ensuring that
stale issues are closed out and progress matches what is happening on
the list. There is no intention to replace the list as a place where
issues are reported and discussed, however that may happen to some
degree anyhow. We should consider how a dedicated bug tracker like
this might impact the community and design for that.
For my mind, if JIRA was to become a 'mirror' of what goes on here in
the list that is ok - perhaps a duplication of efforts, but ok. If
nothing else, we will have a structured store of information keeping
track of issues that is very easy to access and work with.

I don't think I have enough context on all that is going on on the
list to be able to keep everything up-to-date myself, so if you think
you can assist in this capacity, again please contact me.

In case you were interested, some information on me:
I am a keen git user of who-knows-how-many years, and have been
following the list for the last 12 months or so. My day job is as a
JIRA Consultant (and everything else!) with the premier Atlassian
services partner [1].

Regards,

Andrew Ardill

[1] customware.net - we also work with Zendesk, and offer custom
plugins, customisations, theming, training and support packages as
well
