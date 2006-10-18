From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 23:27:50 -0400
Message-ID: <45359F36.6050609@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<20061018000026.GH20017@pasky.or.cz>	<45357596.8050702@utoronto.ca>	<200610180328.31234.jnareb@gmail.com> <87zmbucs86.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Oct 18 05:29:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga26t-0003Ro-TZ
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 05:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWJRD2t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 23:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWJRD2t
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 23:28:49 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:58568 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S932068AbWJRD2s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 23:28:48 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Ga26h-0007rx-00; Tue, 17 Oct 2006 23:28:46 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87zmbucs86.wl%cworth@cworth.org>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29184>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Carl Worth wrote:
> On Wed, 18 Oct 2006 03:28:30 +0200, Jakub Narebski wrote:
>> Isn't it easier to review than "bundle", aka. mega-patch?
> 
> There are even more important reasons to prefer a series of
> micro-commits over a mega-patch than just ease of merging.

A bundle isn't a mega-patch.  It contains all the source revisions.  So
when you merge or pull it, you get all the original revisions in your
repository.


> We have great tools like bisect to identify commits that introduce
> bugs. I know that I'd be delighted to see bisect comes back pointing
> at some minimal commit as causing a bug, (which would make finding the
> bug so much easier).

Bisect should work equally well with revisions pulled or merged from a
bundle as revisions re-committed from patches.

> But it's also been my experience that the largest commits are also the
> most likely to be the things returned by bisect. Big commits really do
> introduce bugs more frequently than small commits.

The number of changes shown in the diff has nothing to do with the
number of changes made per commit.

> Now, I do admit that it is often useful to take the overall view of a
> patch series being submitted. This is often the case when a patch
> series is in some sub-module of the code for which I don't have as
> much direct involvement. In cases like that I will often do review
> only of the diff between the tips of the mainline and the branch of
> interest, (or if I trust the maintainer enough, perhaps just the
> diffstat between the two). But I'm still very glad that what lands in
> the history is the series of independent changes, and not one mega
> commit.

So the difference here is that bundles preserve the original commits the
changes came from, so even though it's presented as an overview, you
still have a series of independent changes in your history.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNZ820F+nu1YWqI0RAjNyAJ90HMCAiopuAMvkKlcCEdc4F6QKLwCdGEWI
VOZThAQrvqybe5z93eC44BY=
=xBZM
-----END PGP SIGNATURE-----
