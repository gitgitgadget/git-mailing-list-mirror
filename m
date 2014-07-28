From: Sergei Organov <osv@javad.com>
Subject: Re: Amending merge commits?
Date: Mon, 28 Jul 2014 23:37:42 +0400
Message-ID: <87vbqhb7g9.fsf@osv.gnss.ru>
References: <22F01493C523F940B4B5E53BB6D0F5352275F207@G5W2738.americas.hpqcorp.net>
	<20140725221911.GL12427@google.com>
	<22F01493C523F940B4B5E53BB6D0F5352275F25B@G5W2738.americas.hpqcorp.net>
	<20140725223146.GM12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Besen\, David" <david.besen@hp.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 21:37:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBqk3-0005EJ-Pv
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 21:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbaG1Thq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 15:37:46 -0400
Received: from mail.javad.com ([54.86.164.124]:47229 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbaG1Thp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 15:37:45 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 9993261855;
	Mon, 28 Jul 2014 19:37:43 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1XBqju-0008C7-0k; Mon, 28 Jul 2014 23:37:42 +0400
In-Reply-To: <20140725223146.GM12427@google.com> (Jonathan Nieder's message of
	"Fri, 25 Jul 2014 15:31:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254352>

Jonathan Nieder <jrnieder@gmail.com> writes:

> David Besen wrote:
>> Jonathan Nieder wrote:
>
>>> This is how pull --rebase works.  It turns your single-parent commits
>>> into a sequence of patches on top of upstream and completely ignores
>>> your merge commits.
>>>
>>> There is a --rebase=preserve option that makes a halfhearted attempt
>>> to preserve your merges --- perhaps that would help?  The
>>> git-rebase(1) documentation has more details.
>>
>> Ah thanks, I'll RTFM better in the future.
>
> No, not a problem.  It's very useful to see examples of where git's
> behavior was counterintuitive and the documentation was more obscure
> than it could have been.

Should documentaion warn that "git pull --rebase=true" (and
pull.merge=true configuration) could be harmful, and that
--rebase=preserve (and pull.merge=preserve) should better be used
instead?

Is there any scenario at all where pull --rebase=true wins over
preserve?

-- 
Sergey.
