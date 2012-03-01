From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Thu, 1 Mar 2012 12:54:21 +0100
Message-ID: <CACBZZX4T28m6k7A53Zc32Aquk-jh7_R0KPeq983bSQ3B-r27cA@mail.gmail.com>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com> <8762eoimp0.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 01 12:54:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S34ax-0000TM-6q
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 12:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450Ab2CALyp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 06:54:45 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:59580 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab2CALym convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2012 06:54:42 -0500
Received: by wejx9 with SMTP id x9so291413wej.19
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 03:54:41 -0800 (PST)
Received-SPF: pass (google.com: domain of avarab@gmail.com designates 10.180.107.169 as permitted sender) client-ip=10.180.107.169;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of avarab@gmail.com designates 10.180.107.169 as permitted sender) smtp.mail=avarab@gmail.com; dkim=pass header.i=avarab@gmail.com
Received: from mr.google.com ([10.180.107.169])
        by 10.180.107.169 with SMTP id hd9mr9922328wib.0.1330602881455 (num_hops = 1);
        Thu, 01 Mar 2012 03:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=H8L8pvw0jM2ScTdHYgIOaj9p5vj+JRulWacTThcGNCE=;
        b=HaDnPo34pitPbWdvf3pqnBZDoXtaN++bfjOCbJFDqB6skvMgRlyk/nSSGKEapPpOIw
         0EHONaoHlsO2BQI3tIx09FqQ9CuShPihkINtVj6ai/s8Os9RVSL7Nw3q1i9E7oLqF6AN
         guwh7hKdsS+B6KVghUazEP/ZOVlpwrzB6PG6w=
Received: by 10.180.107.169 with SMTP id hd9mr7921514wib.0.1330602881293; Thu,
 01 Mar 2012 03:54:41 -0800 (PST)
Received: by 10.223.69.133 with HTTP; Thu, 1 Mar 2012 03:54:21 -0800 (PST)
In-Reply-To: <8762eoimp0.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191917>

On Thu, Mar 1, 2012 at 12:29, Thomas Rast <trast@inf.ethz.ch> wrote:
> Andrew Ardill <andrew.ardill@gmail.com> writes:
>
>> I have set up a JIRA instance using Atlassian's OnDemand service,
>> available at https://git-scm.atlassian.net/
> [...]
>> As I see it (and Junio has mentioned before) we are going to need
>> people who are able to manage the issues in this system
>
> Note that you are not the first one to try. =C2=A0The most elaborate =
plan and
> writeup that I know of sits at
>
> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/136500 =
=C2=A0[1]
>
> Jan "jast" Kr=C3=BCger also mentioned server issues today, so *.jk.gs=
 is
> presumably down because of that, not because gitbugs.jk.gs is no long=
er
> valid.
>
> Nevertheless, AFAIK it has never been used for "real work", so you ma=
y
> want to look into why that happened, and do something different.

As someone who submits patches every once in a while I can echo other
sentiments in this thread, just because you have a list of issues that
doesn't mean anyone is working on them.

However I'd also sometimes like to work on some random issue because
I'm bored, and having a collection of issues ordered by priority (or
popularity) would be useful when that happens.

But I think any proposal to set up a wholly external system is going
to fail, we do most of our bug submission / commenting etc. on this
mailing list, and that isn't going to change, so there's always going
to be a large chasm between the list and any external system.

What I think *would* work however is a system that feeds off the
mailing list. This could be as simple as a mailing list aggregator
that allowed you to star certain messages, and the most starred
messages would be the popular issues.

A more fancy solution would:

 * Consume every single message that gets sent to the list
 * Group each thread and allow it to be categorized as a
   bug/issue/enhancement/complaint
 * Allow you to mark a collection of threads as describing the same
   issue, so you'd have duplicates marked & the full history of a
   discussion on some issue.
 * Allow you to mark an issue as outstanding / resolved / allow voting
   on it.

Thus you'd automatically build up an issue database without anyone
going out of their way, all it would need is the same people who
complain that they can't file bugs either categorizing existing posts,
or categorizing a post they just made.

Many bug trackers can be made to work with E-Mail (e.g. Jira, RT
etc.), although I don't know if they're well set up to follow a
mailing list like this. I think e.g. Jira assumes that you have a the
bug id in the subject, and might not be smart enough to group things
by In-Reply-To headers.
