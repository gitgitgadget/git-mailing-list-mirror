From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Cross-reference the manpages for git-name-rev and git-describe (was Re: Commits gone AWOL, but not reported by git-fsck --unreachable)
Date: Sun, 20 May 2007 14:37:06 +0200
Message-ID: <vpq7ir3658t.fsf_-_@bauges.imag.fr>
References: <20070519103011.GU17511@curie-int.orbis-terrarum.net>
	<20070519115245.GA10035@coredump.intra.peff.net>
	<20070519120933.GW17511@curie-int.orbis-terrarum.net>
	<20070519121154.GA10268@coredump.intra.peff.net>
	<pan.2007.05.19.15.45.46@progsoc.org> <vpq646opzio.fsf@bauges.imag.fr>
	<A04FB6C2-20B2-4263-9D58-6C281C04C6C4@silverinsanity.com>
	<vpq8xbkoir8.fsf@bauges.imag.fr>
	<839C7D1E-E1D0-4EA1-8221-789C418CB242@silverinsanity.com>
	<7vfy5sy91f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 14:41:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpkjI-0007uM-4u
	for gcvg-git@gmane.org; Sun, 20 May 2007 14:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097AbXETMlf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 08:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754441AbXETMlf
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 08:41:35 -0400
Received: from imag.imag.fr ([129.88.30.1]:37060 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702AbXETMle (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 08:41:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4KCb60K007923
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 20 May 2007 14:37:06 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hpkeo-0007Vm-BG; Sun, 20 May 2007 14:37:06 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Hpkeo-00078s-7Q; Sun, 20 May 2007 14:37:06 +0200
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, Brian Gernhardt <benji@silverinsanity.com>, Anand Kumria <wildfire@progsoc.org>,  git@vger.kernel.org
In-Reply-To: <7vfy5sy91f.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat\, 19 May 2007 11\:15\:24 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 20 May 2007 14:37:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47830>

Junio C Hamano <junkio@cox.net> writes:

> Brian Gernhardt <benji@silverinsanity.com> writes:
>
>> On May 19, 2007, at 12:55 PM, Matthieu Moy wrote:
>>
>>> Brian Gernhardt <benji@silverinsanity.com> writes:
>>>
>>>> On May 19, 2007, at 12:08 PM, Matthieu Moy wrote:
>>>>
>>>>> The commit introducing it is
>>>>> 566842f62bdf1f16c2e94fb431445d2e6c0f3f0b,
>>>>> and I'd say it's in git 1.5.1:
>>>>>
>>>>> $ git-describe --tags 566842f62bdf1f16c2e94fb431445d2e6c0f3f0b
>>>>> v1.5.1-34-g566842f
>>>>
>>>> Actually, I think that means it's 34 commits *after* v1.5.1, not
>>>> before.  It's in 1.5.2-rc0, but none of the 1.5.1.* series.
>>>
>>> You're right. Then, is there any easy way to ask git the oldest tag(s)
>>> that a commit is an ancestor of? In other words, which command should
>>> I have typed above?
>>
>> I did it the hard way with "git log v1.5.1..v.1.5.1.1", "..1.5.1.2",
>> and using grep to look for 566842.  Anybody better at constructing
>> these incantations want to chime in?
>
> Perhaps "git-name-rev --refs='refs/tags/v*' $it"?

Yes, that's the one I was looking for (I knew it, but mixed name-rev
and describe).

How about this documentation patch then?


>From c280d7db974faacf388314e0396c9d50b40d55aa Mon Sep 17 00:00:00 2001
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Sun, 20 May 2007 14:33:44 +0200
Subject: [PATCH] Cross-reference the manpages for git-name-rev and git-describe

Both commands achieve a very similar goal.
---
 Documentation/git-describe.txt |    4 ++++
 Documentation/git-name-rev.txt |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 47a583d..ff8383d 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -105,6 +105,10 @@ selected and output.  Here fewest commits different is defined as
 the number of commits which would be shown by "git log tag..input"
 will be the smallest number of commits possible.
 
+See Also
+--------
+gitlink:git-name-rev[1] (very similar to git-describe, but searches
+the succesors of the commit)
 
 Author
 ------
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index d6c8bf8..bdb0b27 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -57,6 +57,10 @@ Another nice thing you can do is:
 % git log | git name-rev --stdin
 ------------
 
+See Also
+--------
+gitlink:git-describe[1] (very similar to git-name-rev, but searches
+the ancestors of the commit)
 
 Author
 ------
-- 
1.5.2.rc3.32.ga3b1



-- 
Matthieu
