From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: `git stash pop` UX Problem
Date: Thu, 27 Feb 2014 07:18:02 -0600
Message-ID: <85r46o3d9x.fsf@stephe-leake.org>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<vpqlhx0a3cb.fsf@anie.imag.fr> <530C893D.7000108@ira.uka.de>
	<vpqzjlf5q2z.fsf@anie.imag.fr>
	<xmqqwqgj57n9.fsf@gitster.dls.corp.google.com>
	<85r46q537a.fsf@stephe-leake.org>
	<xmqq4n3m6dic.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 14:18:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ0qr-0000r6-3F
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 14:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbaB0NSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 08:18:08 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:26282 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750742AbaB0NSH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 08:18:07 -0500
Received: from [75.87.81.6] ([75.87.81.6:52626] helo=TAKVER)
	by cdptpa-oedge02 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 78/BC-30151-C0B3F035; Thu, 27 Feb 2014 13:18:05 +0000
In-Reply-To: <xmqq4n3m6dic.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 25 Feb 2014 14:20:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.130:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242820>

Junio C Hamano <gitster@pobox.com> writes:

> Stephen Leake <stephen_leake@stephe-leake.org> writes:
>
>>> One _could_ argue that stashed changes are what could be reflected
>>> to the working tree and form the source of the latter, but my gut
>>> feeling is that it is a rather weak argument.  At that point you are
>>> talking about what you could potentially change in the working tree,
>>
>> No, I saved things in the stash on purpose. For example, I had changes
>> that were not ready to commit, but I wanted to do a merge from upstream.
>
> I often save things by running "git diff >P.diff" on purpose.

Ok. How is that better than 'git stash save'?

> Should "git status" read these patches and tell me what paths I
> could change in the working tree by applying it?  

No, 'git stash save' appears to be the method git provides to do this,
so it is the only one that git needs to support.

(The content of 'P.diff' already tells you what paths are modified, as
does 'git stash show')

But I am new to git, so I could just be missing the point.

>Where does it end?

Where we agree it ends :).

>> There are workflows where the stash is not important; provide an option
>> to 'git status' that means "ignore stash". 
>
> How is that different to tell those who want to know what are in the
> stash to type "git stash list" when they want to learn that
> information?

You are correct, this is a question of style. The question is:

Which style is best for git, considering the needs of newbies and
seasoned users?

As a newbie, I find these things confusing:

- the stash status is not displayed by 'git status'

- 'git add' does not report that all pending merge conflicts are now
resolved.

I'm sure I will discover other confusing things in the future :).


I am a seasoned user of CM systems in general; in all cases, I have
customized an Emacs front-end to do _exactly_ what I want, rather than
relying on the command line tools directly. So I have a rather extreme
perspective on this :). I do rely on the command line tools while
learning a new CM system.

In general, I expect seasoned users to be more accepting of the need to
provide additional options to customize the tools to their workflow.

-- 
-- Stephe
