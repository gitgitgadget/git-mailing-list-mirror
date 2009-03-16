From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: Generalised bisection
Date: Mon, 16 Mar 2009 22:08:15 +0000
Message-ID: <efe2b6d70903161508i19c16f6bm7f695452748a06a1@mail.gmail.com>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
	 <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
	 <efe2b6d70903111515p2b9f656bp186d0b3cc7ae483d@mail.gmail.com>
	 <43d8ce650903112345x3d40b70ap7e4c0f8c7d0b6069@mail.gmail.com>
	 <alpine.DEB.1.00.0903121154560.10279@pacific.mpi-cbg.de>
	 <d9c1caea0903121102y5452603fua0e7a1b82e121b01@mail.gmail.com>
	 <efe2b6d70903130549m63ae9bdeg1cd3f24a43b3e66f@mail.gmail.com>
	 <d9c1caea0903130819u770686b1w867f074ffef8fabf@mail.gmail.com>
	 <efe2b6d70903151216q4a8881e5t797cf5d3bebc5697@mail.gmail.com>
	 <d9c1caea0903160329v3c1a1600m9913eafa00cc2f37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	John Tapsell <johnflux@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>
To: Steven Tweed <orthochronous@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 23:09:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjL0G-0007Dn-8O
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 23:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbZCPWIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 18:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752422AbZCPWIT
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 18:08:19 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:64461 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbZCPWIS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 18:08:18 -0400
Received: by fxm24 with SMTP id 24so3688970fxm.37
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 15:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kpq1V8LaeXp8hv+8BJ2K4YcW/dfEUJ2S1ZsY/nBjsmY=;
        b=UBWQAEZVVOI19i12xPClMMuJ9UMbLobDQ1kAANzHzYHMaz98NImyAWEK0wcrKfmSQH
         h4RdW9iIf9RryrsPuEJSnXxrIiihRjU1bud2Iw2P05T8zp7ebr5D1om6zHbjVUzOYnMg
         s2ZPixyxLQUXIB4Yha4ylVgopos+VwkUux9qI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XaYwRJm2Q2Y7FairOete9DuwAVzeyWKjqGQ6pm/zWg5yVDgV6tzurnASknS2B/Dy2r
         ilEvzKujmuK92dfv+hyLvyzu5+xGmGi2cR5QW0VCg6ZDk3fOW0YS+PCYF76wCxYl7AE6
         Am1il4e3FQ+/WwIfeViF0JOQWxZ/lVUeyLV2U=
Received: by 10.204.103.203 with SMTP id l11mr1782540bko.71.1237241295781; 
	Mon, 16 Mar 2009 15:08:15 -0700 (PDT)
In-Reply-To: <d9c1caea0903160329v3c1a1600m9913eafa00cc2f37@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113392>

On Mon, Mar 16, 2009 at 10:29 AM, Steven Tweed <orthochronous@gmail.com> wrote:

> I had a look over the weekend, and got a bit sidetracked on one of
> your assumptions. You seem to be assuming that the bug is such that
> observing a single positive observation of the symptom at a position i
> in the linear history _does not_ completely rule out that the guilty
> commit occurs after that point. I would have thought the generally
> more applicable assumption is that, given that generally you don't
> have a bug ridden system where more than one bug causes the same
> symptom _within the history of interest_, that a single observation of
> the symptom does totally rule out the bug after that point (whilst
> intermittency clearly not having observed the bug before that point
> doesn't completely rule out the guilty commit being earlier, although
> it should increase the liklihood estimate of the bug being later).

I must have been unclear somewhere, because I do indeed assume that
a single observation of the symptom rules out the origin of the bug being
later than that observation.

 If you have a play with the software in manual mode, you can see that its
behaviour reflects this  - it starts out doing something like an
ordinary binary search, albeit skewed towards older revisions (it
seems to go for
a roughly 1:2 division, rather than the usual 1:1). Then once it has got to the
point where a deterministic search would end, it hammers away at the parent(s)
of the newest revision where the fault was observed, until it is satisfied that
it cannot be found there. All this just emerges from the generic least-entropy
algorithm; I didn't know what it would do until I got it running.

> I wonder what your thoughts are on this? (I started formulating a
> model over the weekend, but work is a bit hectic so I may not get to
> write it up in LaTeX very quickly.)

It will be interesting to see whether your model turns out to be different from
mine. I'm only doing this in my spare time, so I'm in no hurry.

Ealdwulf
