From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Mon, 10 Jun 2013 01:40:06 +0200
Message-ID: <51B51256.5060602@gmail.com>
References: <20130608164902.GA3109@elie.Belkin> <CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com> <20130608173447.GA4381@elie.Belkin> <CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com> <20130609014049.GA10375@google.com> <CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com> <20130609052624.GB561@sigill.intra.peff.net> <CAMP44s3NhNUuCvW37UaMo9KbHHxZqBE8S15h845vtRi89Bu6WA@mail.gmail.com> <20130609174049.GA1039@sigill.intra.peff.net> <CAMP44s35w_ysvd5c8oANF8YpWvsquY50bUjSfjOxtujdpgBCPQ@mail.gmail.com> <20130609181002.GC810@sigill.intra.peff.net> <CAMP44s0ky7ad3cGBQs0DNht4Uo4MR08VrNx+PigcNraDP76CLA@mail.gmail.com> <CALKQrgc5K0U2qCHjjzgxw1=70FbmHdokU3H0tfB_=+7gDVNzsA@mail.gmail.com> <51B4F6CA.8020807@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 10 01:40:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlpDi-0002yo-TP
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 01:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480Ab3FIXkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 19:40:19 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:47304 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab3FIXkS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 19:40:18 -0400
Received: by mail-ea0-f180.google.com with SMTP id k10so5024981eaj.25
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 16:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=+yZiayWoMbWAAwJhRyDm/NlFy1VDFAriBRLAtk3qqBQ=;
        b=gyTCPvcygj5fj5NK3VC6G83Jdof0ju8lwaJRztatWRKcYCy25jx3LbLxQ8W7J+eczf
         U9RkTjKHu2gYNMEzheFRSt5oQmAbmUkEZYoUME7zW3E4f/EHZXgjs5GlyVtFR+y0yMeu
         cWbp3RG+IJzT9iEh2oj8e3lPuanpnfHUNC4fP68B/j9wQMMgcPZxJfvIecayb9wuJzH5
         D16+WPzDdpJn9GvcpfgXLiuk1zzDyg9aKouK52JXNYrhBB5eTb2I6rEd7wdTlIZ+dWp0
         mDxeDQJ+wbRnvt4NoFjxpbPnlBT2dxQiG5wsFxgcQ4eVjB9Hjndyfzw7vI2Ol0LSTbrE
         7lSQ==
X-Received: by 10.14.216.201 with SMTP id g49mr8177499eep.42.1370821216833;
        Sun, 09 Jun 2013 16:40:16 -0700 (PDT)
Received: from [192.168.178.20] (host93-95-dynamic.6-79-r.retail.telecomitalia.it. [79.6.95.93])
        by mx.google.com with ESMTPSA id a5sm18869332ees.6.2013.06.09.16.40.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 16:40:15 -0700 (PDT)
In-Reply-To: <51B4F6CA.8020807@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227217>

[Sorry for the full quote, but sometimes, repetita iuvant]

On 06/09/2013 11:42 PM, Michael Haggerty wrote:
> On 06/09/2013 09:11 PM, Johan Herland wrote:
>> [...]
>> FWIW, I'd like to express my support for the opinions expressed by
>> Jonathan, Jeff and Thomas. They accurately describe my impression of
>> these discussion threads.
> 
> I also agree.  In my opinion, Felipe, your abrasiveness, your disregard
> of project standards, and your eternal argumentativeness outweigh the
> benefit of your contributions, large though they may be.
> 
> Writing code is only a small part of keeping the Git project going.
> 
> * Reviewing code is an essential, more thankless, and therefore more
> precious, contribution.  Therefore the Git project has standards to make
> code review less unpleasant and more effective; for example: (1) patches
> shouldn't cause regressions; (2) commit messages have to be written to
> very high standards; (3) reviewers' comments should be accepted
> gratefully and taken very seriously.  Almost everybody in the Git
> community accepts these standards.  Felipe, you do not seem to.  The
> result is that reviewers' time and goodwill are wasted, and they
> justifiably feel unvalued.  We can't afford to misuse reviewers; they
> are the bedrock (and the bottleneck) of the project.
> 
> * Gaining and keeping contributors is important to maintaining the
> success of the project.  The mailing list is the main forum for the
> development community; therefore, it is important that the mailing list
> be a place where people display a high degree of technical excellence,
> but also respect for one another, friendliness (or at least a lack of
> hostility), and discussions that do turn into flame wars.  It is
> possible to have a profound technical disagreement without losing
> respect for the other side; contrariwise it is NOT acceptable to twist a
> technical disagreement into a personal attack, even by the slightest
> insinuation.  Felipe, in my opinion your participation in the mailing
> list lowers the tone dramatically, and will result in loss of other
> contributors and the failure to attract new contributors.
> 
> Felipe, I wish that you would devote a small fraction of your prodigious
> energy to the very difficult challenge of feeling empathy,
> understanding, and respect for the other members of the community.  But
> if things continue the way they have, I personally would, with sadness
> in my heart, prefer to forgo your patches in exchange for the more
> important benefit of a more collegial (and therefore overall more
> productive and sustainable) community.
> 
> Michael
> 
FWIW, from the meager but I hope not utterly irrelevant point
of view of a non-contrib-but-not-clueless user as I am:

  *a complete and hear-felt +1 on what Michael said here*

Until a couple of months ago, skimming this list was mostly a real
pleasure, and would often give me some valuable insight on the
upcoming features/incompatibilities of Git, help me organize my own
workflow as a Git user, and also steadily improve my understanding
and command of netiquette in both "generic" mailing lists and Open
Source and/or Free Software communities.

Now, when I open my mail and get to the "git" folder, I more and
more end up asking myself:

  1. "What kind of flame am I going to have to see today?"; and

  2. "How much chaff will I have to navigate through to finally
      to get to interesting stuff (if any is actually left)?"

*To reiterate:*

Sadly, the environment of the Git mailing list has been steadily
and slowly *sinking* -- sinking from being pleasant and useful
and even "educational", into being annoying and frustrating and
often somewhat toxic.  I usually jeer and despise he who makes
public accusations by simply adding his voice to the disapproval
of the "community", but this time, I feel compelled to do exactly
that:

  I do accuse Felipe's *attitude* to bring on and nourish such
  unpleasantness toxicity.  His technical merits and the possible
  qualities of his patches do *nothing* to remove or quell such
  issues.

Sorry for the extra potential controversy, but sometimes one has
to speak up,

  Stefano
