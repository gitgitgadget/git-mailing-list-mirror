From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: [RFC 0/3] Make git more user-friendly during a merge conflict
Date: Fri, 28 Feb 2014 11:26:23 -0600
Message-ID: <85zjlb1740.fsf@stephe-leake.org>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<20140226202601.GK7855@google.com> <857g8f1ugu.fsf@stephe-leake.org>
	<87fvn335sm.fsf@fencepost.gnu.org> <858usvz5nj.fsf@stephe-leake.org>
	<87txbj1fnw.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 18:26:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJRCi-0006BB-5O
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 18:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbaB1R02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 12:26:28 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.229]:40098 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752809AbaB1R01 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 12:26:27 -0500
Received: from [75.87.81.6] ([75.87.81.6:49272] helo=TAKVER)
	by cdptpa-oedge01 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 0B/C9-10928-2C6C0135; Fri, 28 Feb 2014 17:26:26 +0000
In-Reply-To: <87txbj1fnw.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Fri, 28 Feb 2014 15:21:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.118:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242991>

David Kastrup <dak@gnu.org> writes:

> Stephen Leake <stephen_leake@stephe-leake.org> writes:
>
>> David Kastrup <dak@gnu.org> writes:
>>
>>> "do the right thing" commands also tend to do the wrong thing
>>> occasionally with potentially disastrous results when they are used
>>> in scripts where the followup actions rely on the actual result.
>>
>> That is bad, and should not be allowed. On the other hand, I have yet
>> to see an actual use case of bad behavior in this discussion.
>
> Huh.
>
> <http://permalink.gmane.org/gmane.comp.version-control.git/242744>

That's about backward incompatibility, which is bad, but not what I was
talking about above.

Specifically, the proposed change is:

'git reset' will have different default actions depending on context:

- if a merge is not in progress, it will do 'git reset --mixed'

- if a merge is in progress, it will do 'git reset --merge'

Is there a use case where this will do the wrong thing?

Of course, I fully understand that not being able to come up with a
"wrong thing" use case is not the same as proving it cannot happen,
especially for a system as complex as git.

So it would be ok to say "we don't do that so we are not exposed to
unintended consequences".

But "wrong thing" use cases are more convincing :).

-- 
-- Stephe
