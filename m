From: Christian Couder <christian.couder@gmail.com>
Subject: Re: GSoC 2014: Summary so far, discussion starter: how to improve?
Date: Sat, 19 Oct 2013 12:41:03 +0200
Message-ID: <CAP8UFD0KF_X8sbmUNNvRkHz+XFwAZ7aW+YfVyCnt0yJ_WfW2Bg@mail.gmail.com>
References: <8761stx04i.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Ben Straub <bs@github.com>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	David Michael Barr <davidbarr@google.com>,
	Edward Thomson <ethomson@microsoft.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Martin Woodward <martin.woodward@microsoft.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Michael Schubert <schu@schu.io>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Philip Kelley <phkelley@hotmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Russell Belfer <rb@github.com>,
	Scott Chacon <schacon@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Thomas Gummerer <t.gummerer@gm
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sat Oct 19 12:41:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXTy3-0003pV-M9
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 12:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573Ab3JSKlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 06:41:07 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:52598 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab3JSKlF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 06:41:05 -0400
Received: by mail-wg0-f43.google.com with SMTP id b13so4749153wgh.10
        for <git@vger.kernel.org>; Sat, 19 Oct 2013 03:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OQXVdIOeXj62IVXLETNfNchHsmiSXzoJTjAKBzULnyw=;
        b=HXuhGAjpzQM8RFrUYCitsbzdnuFt5F+00MFNLBthCOwPLjjP8MDytSgi37FlkJXmzL
         f2vpvxqlWoK0BJ9fi+Zgxus3g37t6boABk65pltUDPhk2ZbwMMsbU5nVyYBPOrrSv4sQ
         UUMm2dz0Aegvm6+IANbpjlApwMoQEgNimOJmL1+hz7QpN1QtAkzxVrprG6voq7iQ2kVQ
         ulzJYJ/bq/A5F5hJ8jfDf1CdiibdvDIbGyDv3pY59aawgyVd2EGbSHnIspOuD+lWTlhK
         ZRPXhpTFHyGroVo1BYkGdDl7yktZa5trqrmfHm/bbVWfcpdqnrJoF5owMABE7Ac6P/S8
         LO8A==
X-Received: by 10.180.182.15 with SMTP id ea15mr2822564wic.16.1382179263902;
 Sat, 19 Oct 2013 03:41:03 -0700 (PDT)
Received: by 10.216.227.20 with HTTP; Sat, 19 Oct 2013 03:41:03 -0700 (PDT)
In-Reply-To: <8761stx04i.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236394>

Hi,

On Sat, Oct 19, 2013 at 8:09 AM, Thomas Rast <tr@thomasrast.ch> wrote:
>
> Previous Episodes
> =================
>
> Git participated in Google Summer of Code (GSoC) 2007-2012, but did not
> participate in 2013 based on discussion in February [1].  At Git-Merge
> in Berlin there was a discussion round [2] that this post attempts to
> summarize as a basis for further discussion and (hopefully)
> participation in GSoC'14.
>
> Much sooner than in previous years, Google has already confirmed that
> GSoC'14 will in fact happen [3].
>
> Note that while mistakes herein are mine, many ideas and opinions
> aren't.  This really tries to be a summary.  Please flame >/dev/null,
> not me.

Thank you for sending this very good summary.

> Theories
> ========
>
> These are the hypotheses that I have heard (mostly in [1] and [2]) as
> to what is bad about Git's prior GSoC participations.
>
> * Aiming far too high, focusing on cool/shiny projects with a large
>   impact.  This also affects the students, who tend to cluster around
>   the largest, shiniest project suggestions.

Yeah, focusing on _too big_ projects.

> * Diminishing returns: Git is too mature, with little low-hanging
>   fruit left, making such projects harder
>
> * Projects are too political, progress depending on non-technical
>   arguments
>
> * Our mentors suck on various axes, notably not supporting students
>   enough in things that matter:
>   - smooth interaction with community
>   - ensure fast iteration/short cycles
>   - navigating the code base

Yeah, "fast iteration/short cycles" means submitting the work early
and often _to the mailing list_.

One of the thing we learned too is that focusing on selecting the
"best" students didn't really worked.
What worked was selecting students who have already contributed
patches, but unfortunately there are not many potential students who
have already contributed.

> Further steps
> =============
>
> * Discuss :-)
>
>   And then apply this hard-won knowledge systematically.  In
>   particular I think it wouldn't hurt to keep the project proposals
>   out of this thread until we have agreed on goals/standards to
>   measure them against.

Based on the above, what about the following:

1) Advertise early and widely that we will very strongly favor
students who have already contributed and that we can help them
contribute long before their application process starts. Maybe we
could even have a pre GSoC application process for potential students.

2) Advertise that we will really favor small projects over big/shiny ones.

3) Come up with a list of criteria like the following to measure
student/application:

- has the student already contributed much: 0-30 points:
0 means no contribution to any open source project,
5 means some contribution to another open source project,
20 means long time Git contributor

- what is the size of the project: 0-10 points:
0 means big project (one month or more for a regular contributor)
10 means small project (one week for a regular contributor)

- does the student appear willing to act on advice: 0-5 points

- does the student appear to have the necessary skills: 0-5 points

- does the proposal look good: 0-5 points

> * Gather a list of potential mentors.

I would be happy to mentor next year.

Thanks,
Christian.
