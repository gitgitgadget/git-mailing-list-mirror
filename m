From: Lachlan Patrick <loki@research.canon.com.au>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 17:47:16 +1000
Message-ID: <45387F04.5010101@research.canon.com.au>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>	<45357411.20500@utoronto.ca>	<200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca>	<Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>	<4536EC93.9050305@utoronto.ca>	<87lkncev90.wl%cworth@cworth.org> <453792A8.1010700@utoronto.ca>	<878xjc2qeb.wl%cworth@cworth.org> <453803E6.2060309@utoronto.ca>	<87ods727pn.wl%cworth@cworth.org> <45382120.9060702@utoronto.ca> <Pine.LNX.4.64.0610192202340.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 09:47:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gap6A-0007gE-Va
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 09:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992559AbWJTHrU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 03:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992560AbWJTHrU
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 03:47:20 -0400
Received: from a.ns.cisra.com.au ([203.12.173.51]:44017 "EHLO
	ebenezer.cisra.com.au") by vger.kernel.org with ESMTP
	id S2992559AbWJTHrT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 03:47:19 -0400
Received: from jaroslav.research.canon.com.au (edge-aide.cisra.com.au [203.12.173.254])
	by ebenezer.cisra.com.au (Postfix) with ESMTP id 74A9422243B;
	Fri, 20 Oct 2006 07:47:16 +0000 (UTC)
Received: from [10.2.8.174] (HASPRE.research.canon.com.au [10.2.8.174])
	by jaroslav.research.canon.com.au (Postfix) with ESMTP id 71EB15C041;
	Fri, 20 Oct 2006 07:47:16 +0000 (UTC)
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
To: bazaar-ng@lists.canonical.com
In-Reply-To: <Pine.LNX.4.64.0610192202340.3962@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29412>

Linus Torvalds wrote:
> 
> On Thu, 19 Oct 2006, Aaron Bentley wrote:
>> I understand your argument now.  It's nothing to do with numbers per se,
>> and all about per-branch namespaces.  Correct?
> 
> I don't know if that is what Carl's problem is, but yes, to somebody from 
> the git world, it's totally insane to have the _same_ commit have ten 
> different names just depending on which branch is was in.
> 
> In git-land, the name of a commit is the same in every branch.

I've been following the git-vs-bzr discussion, and I'd like to ask a
question (being new to both bzr and git). How does git disambiguate SHA1
hash collisions? I think git has an alternative way to name revisions
(can someone please explain it in more detail, I've seen <ref>~<n>
mentioned only in passing in this thread). It seems to me collisions are
a good argument in favour of having two independent naming schemes, so
that you're not solely relying on hashes being unique.

A strong argument is that a global namespace based on hashes of data is
ideal because the names are generated from the data being named, and
therefore are immutable. Same data => same name for that data, always
and forever, which is desirable when merging named data from many
sources. But the converse isn't true: one name does not necessarily map
to only that data. Have I misunderstood? Is this a problem?

Ta,
Loki
