From: Scott Chacon <schacon@gmail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Thu, 1 Mar 2012 08:52:53 -0800
Message-ID: <CAP2yMa+op58gbUPXvyHdx+cLcCBgHmmuBKGBojxA+puDRPSp1Q@mail.gmail.com>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com> <rmifwdti2ap.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 17:54:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S39HH-0003oU-DG
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 17:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758180Ab2CAQyg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 11:54:36 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54030 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757057Ab2CAQxN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2012 11:53:13 -0500
Received: by mail-pz0-f46.google.com with SMTP id r28so936513daj.19
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 08:53:13 -0800 (PST)
Received-SPF: pass (google.com: domain of schacon@gmail.com designates 10.68.194.65 as permitted sender) client-ip=10.68.194.65;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of schacon@gmail.com designates 10.68.194.65 as permitted sender) smtp.mail=schacon@gmail.com; dkim=pass header.i=schacon@gmail.com
Received: from mr.google.com ([10.68.194.65])
        by 10.68.194.65 with SMTP id hu1mr4895558pbc.75.1330620793260 (num_hops = 1);
        Thu, 01 Mar 2012 08:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=H73WVTb+XzN4bJ048ICRYuxrdVGDFVsEBHrIy/Ob+8k=;
        b=H5XDVIQBJzky3RlqeqB30ShebOXNLfB2BUUoWkIKHD3IjH6DbfqCtE/uaDyHsUJj5U
         1uY+qdWBN20lnY4ugJfMwe5oq3vPUnlW4rW+rWQnYMMNJs10eEB8lRsXGjnlv0u2TE+7
         r12RLxY/R+RNQai6IFWavF2ZaLmo069kj1U8Y=
Received: by 10.68.194.65 with SMTP id hu1mr4107651pbc.75.1330620793180; Thu,
 01 Mar 2012 08:53:13 -0800 (PST)
Received: by 10.68.5.72 with HTTP; Thu, 1 Mar 2012 08:52:53 -0800 (PST)
In-Reply-To: <rmifwdti2ap.fsf@fnord.ir.bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191945>

On Wed, Feb 29, 2012 at 4:37 PM, Greg Troxel <gdt@ir.bbn.com> wrote:
>
> =C2=A0I have set up a JIRA instance using Atlassian's OnDemand servic=
e,
> =C2=A0available at https://git-scm.atlassian.net/
>

Honestly I would argue against this, just because unless you want to
spend a lot of time on it, I don't think it's going to get used much.
Issue trackers in general tend not to get traction unless the
maintainer uses it and asks people to use it or it's included in the
workflow somehow.  I use issue trackers in most of my projects, but I
also don't use mailing lists - a lot of the things that work for my
workflows are not the way that the Git project does it and I think
you'll find that it's a bit of a waste of time to try to shoehorn them
in.

Besides, most of the things you are looking to get out of this are
generally pretty easily obtained from the ML.  If you're bored and
want a project to work on, ask the ML.  If you want to know the status
on something, search or ask the ML.  It's not quite as self-service as
a issue tracker, but it gets you into the community more, which I
think is also important.

> Do people really think it's reasonable to use non-Free tools to devel=
op
> git? =C2=A0That seems surprising to me.

This is particularly interesting to me.  Disclaimer: I work at GitHub
and have for most of the life of GitHub.  That said, it's interesting
to think about this.  What does the freedom of the tooling provide
you?  Data portability is one thing, but both JIRA and GitHub have
APIs to obtain basically any data in them (I think - I never use JIRA,
but I've worked on the GH APIs).

I do think that an interesting data point here is the cast of
kernel.org, though.  So that's all free, but also hugely and totally
failed everyone here.  It wasted hours of my time trying to clean up
all the broken links from git-scm.com over a month, which is after a
month of thinking that they couldn't possibly be down another day.
The wiki is still busted.  The docs are still gone.  GitHub has
contracted a designer and has started spending developer hours working
on a better git-scm.com to take over those functions so it won't
happen again.  More importantly, that will never happen to GitHub or
JIRA - there is no conceivable way that either of these relatively
large corporations would tolerate even a full day of downtime or data
loss.

So free is great, but what is more important in the tooling and
services that help you develop?  Is it freedom to some arbitrary
level, or is it simplicity and availability? I value my time a lot
more than if I can get the source code to the issue tracker that my
open source project uses.  If we're going to use an issue tracker, or
any other tool, I would really rather prefer we use one backed by a
company that takes downtime seriously as opposed to using something
that doesn't have the resources to fix things in any timeframe.
Having someone saying "it's going to keep working because if it
doesn't we all lose our jobs" is more freedom to me than having people
say "if it doesn't work at some point you have the freedom to spend
days of your time reimplementing it on your own hardware with maybe
some of our backed up data and our open source code".  Which is
literally what I'm doing today for the hosted man page documentation.

Just some thoughts.

Scott
