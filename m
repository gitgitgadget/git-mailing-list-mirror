From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: [RFC 0/3] Make git more user-friendly during a merge conflict
Date: Fri, 28 Feb 2014 08:13:52 -0600
Message-ID: <858usvz5nj.fsf@stephe-leake.org>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<20140226202601.GK7855@google.com> <857g8f1ugu.fsf@stephe-leake.org>
	<87fvn335sm.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 15:14:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJOCS-0007OO-5A
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 15:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbaB1ON6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 09:13:58 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:24401 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752305AbaB1ON4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 09:13:56 -0500
Received: from [75.87.81.6] ([75.87.81.6:53938] helo=TAKVER)
	by cdptpa-oedge01 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 2F/B4-10928-3A990135; Fri, 28 Feb 2014 14:13:55 +0000
In-Reply-To: <87fvn335sm.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Fri, 28 Feb 2014 11:11:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.118:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242961>

David Kastrup <dak@gnu.org> writes:

> Stephen Leake <stephen_leake@stephe-leake.org> writes:
>
>> I like commands that "do the right thing". So no, this would not be
>> confusing.
>
> I _hate_ commands that think they know better than to do what they are
> told.  In particular when doing destructive things.  And just because
> _you_ like them does not mean they are not confusing.

Ok, I should have said "not confusing for me".

People differ.

> In the long run, it is much more confusing if you come to rely on some
> commands doing "the right thing" while in other cases, the actually
> written thing is done.

There should always be the option of telling git exactly what to do. In
my emacs front end, the command that "does the right thing" is _called_
"do-the-right-thing". All of the other commands do exactly as told.

In this case, it is only "git reset" that would do the right thing,
since you did _not_ tell it specifically what to do.

Relying on a default is always problematic, in my experience; I much
prefer "no default" to "a default that people voted on 10 years ago, and
now we are stuck with it".

> "do the right thing" commands also tend to do the wrong thing
> occasionally with potentially disastrous results when they are used in
> scripts where the followup actions rely on the actual result.

That is bad, and should not be allowed. On the other hand, I have yet to
see an actual use case of bad behavior in this discussion.

-- 
-- Stephe
