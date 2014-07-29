From: Sergei Organov <osv@javad.com>
Subject: Re: Amending merge commits?
Date: Tue, 29 Jul 2014 13:58:35 +0400
Message-ID: <87r4147agk.fsf@osv.gnss.ru>
References: <CAK3OfOjr6ej5VdGU=bLmtag9cca1=ogLxVakCFTMG7b-A2uBiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Besen\, David" <david.besen@hp.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 11:58:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC4B9-0008D6-EO
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 11:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217AbaG2J6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 05:58:39 -0400
Received: from mail.javad.com ([54.86.164.124]:51624 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184AbaG2J6i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 05:58:38 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id D687961814;
	Tue, 29 Jul 2014 09:58:36 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1XC4B1-0000Fm-5U; Tue, 29 Jul 2014 13:58:35 +0400
In-Reply-To: <CAK3OfOjr6ej5VdGU=bLmtag9cca1=ogLxVakCFTMG7b-A2uBiA@mail.gmail.com>
	(Nico Williams's message of "Mon, 28 Jul 2014 16:47:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254411>

Nico Williams <nico@cryptonector.com> writes:

> On Mon, Jul 28, 2014 at 3:00 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Sergei Organov wrote:
>>
>>> Is there any scenario at all where pull --rebase=true wins over
>>> preserve?
>>
>> Basically always in my book. ;-)
>>
>> When people turn on 'pull --rebase', they are asking for a clean,
>> simplified history where their changes are small discrete patches in a
>> clump on top of upstream.
>
> +1.  Words to develop by.
>
> There are exceptions.  E.g., when you pull commits from multiple
> [forked] upstreams, then you can't keep your local commits on top.
>
> That exception aside, keeping all local commits "on top" by always
> rebasing them onto the upstream is extremely useful: a) in simplifying
> conflict resolution, b) making it easy to identify as-yet-unintegrated
> local commits, c) making it easy to contribute local commits.

But 'pull --rebase=preserve' does rebase local commits onto the
upstream, and result is exactly the same as 'pull --rebase=true', unless
you have some of your own merges to be rebased. That's where the
difference between these two options appears. It's --rebase=false that
performs merges rather than rebase.

Overall, I still can't see where '--rebase=true' wins over
'--rebase=preserve'.

-- 
Sergey.
