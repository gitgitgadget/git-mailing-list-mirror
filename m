From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: `git stash pop` UX Problem
Date: Tue, 25 Feb 2014 14:48:09 -0600
Message-ID: <85r46q537a.fsf@stephe-leake.org>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<vpqlhx0a3cb.fsf@anie.imag.fr> <530C893D.7000108@ira.uka.de>
	<vpqzjlf5q2z.fsf@anie.imag.fr>
	<xmqqwqgj57n9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 25 21:55:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIP2E-0007yr-Aj
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 21:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbaBYUzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 15:55:15 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.232]:7030 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753469AbaBYUzO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Feb 2014 15:55:14 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Feb 2014 15:55:14 EST
Received: from [75.87.81.6] ([75.87.81.6:50482] helo=TAKVER)
	by cdptpa-oedge02 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 39/37-30151-B810D035; Tue, 25 Feb 2014 20:48:11 +0000
In-Reply-To: <xmqqwqgj57n9.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 25 Feb 2014 11:12:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.130:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242683>

Junio C Hamano <gitster@pobox.com> writes:

> "status" is about reminding the user what changes are already in the
> index (i.e. what you would commit) and what changes are in the
> working tree, from which you could further update the index with
> (i.e. what you could commit).

I believe "status" should tell me everything git knows about the current
workspace in a resonably concise way. That includes the stash.

> One _could_ argue that stashed changes are what could be reflected
> to the working tree and form the source of the latter, but my gut
> feeling is that it is a rather weak argument.  At that point you are
> talking about what you could potentially change in the working tree,

No, I saved things in the stash on purpose. For example, I had changes
that were not ready to commit, but I wanted to do a merge from upstream.

There are workflows where the stash is not important; provide an option
to 'git status' that means "ignore stash". 

> So, I tend to agree with you, while I do understand where "I want to
> know about what is in stash" is coming from (and that is why we do
> have "git stash list" command).

My Emacs front end currently checks both 'git status' and 'git stash
list' to build "the status of the current workspace".

-- 
-- Stephe
