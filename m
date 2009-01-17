From: Hannu Koivisto <azure@iki.fi>
Subject: Re: fatal: git grep: cannot generate relative filenames containing '..'
Date: Sat, 17 Jan 2009 04:21:44 +0200
Message-ID: <83vdsefz9j.fsf@kalahari.s2.org>
References: <20090115222905.8157.qmail@science.horizon.com>
	<7vr634ow3r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "George Spelvin" <linux@horizon.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 03:49:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO1Fn-0005ft-6W
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 03:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757058AbZAQCsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 21:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756328AbZAQCsD
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 21:48:03 -0500
Received: from s2.org ([195.197.64.39]:57599 "EHLO kalahari.s2.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753874AbZAQCsB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 21:48:01 -0500
X-Greylist: delayed 1566 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Jan 2009 21:48:01 EST
Received: from azure by kalahari.s2.org with local (Exim 4.69)
	(envelope-from <azure@iki.fi>)
	id 1LO0oi-00042C-KC; Sat, 17 Jan 2009 04:21:44 +0200
In-Reply-To: <7vr634ow3r.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 15 Jan 2009 17:52:56 -0800")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: azure@iki.fi
X-SA-Exim-Scanned: No (on kalahari.s2.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106011>

Junio C Hamano <gitster@pobox.com> writes:

> "George Spelvin" <linux@horizon.com> writes:
>
>> Could someone fix this some day?
>
> As far as I know you are the first to ask for this, so perhaps people never
> considered this was something to "fix"....

I for one have faced that problem and considered it something that
would be nice to have fixed.  Then again, I consider the default
behaviour (when you pass no path) a bigger usability problem.

>> While you're at it, an option to search the entire git tree rather than
>> the current subdirectory would also be useful.  I was thinking about
>> a flag like -r (for "root"),...

It turns out that this "entire git tree" is practically my only use
case when using normal (find and) grep and when I first tried git
grep, I actually expected it to do just that with no path specified.

Why?  Because of the way at least git diff and git log work.  I
thought that just like with them, "git grep foo" would search the
entire git tree and I would have to say "git grep foo ." to limit to
the current directory and its subdirectories.  git-grep(1)'s "Look
for specified patterns in the working tree files..." at least
didn't seem to disagree with my expectation so I was a bit puzzled.

So I'd rather see git grep behave in a way consistent with git log
and git diff (I realize that would change current behaviour instead
of extending it).

-- 
Hannu
