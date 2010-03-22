From: Eli Barzilay <eli@barzilay.org>
Subject: Re: git rev-list formatting
Date: Mon, 22 Mar 2010 10:42:53 -0400
Message-ID: <m3aau0pgcy.fsf@winooski.ccs.neu.edu>
References: <m3iq8opp8u.fsf@winooski.ccs.neu.edu>
	<m3eijcpoud.fsf@winooski.ccs.neu.edu>
	<4BA76BDF.6060106@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 22 15:43:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntiqa-0007c6-3a
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 15:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279Ab0CVOnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 10:43:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:60345 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532Ab0CVOnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 10:43:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NtiqP-0007UD-6Y
	for git@vger.kernel.org; Mon, 22 Mar 2010 15:43:05 +0100
Received: from winooski.ccs.neu.edu ([129.10.115.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 15:43:05 +0100
Received: from eli by winooski.ccs.neu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 15:43:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: winooski.ccs.neu.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:c9CbSVuQrCROiaRpCck0dt7R2G0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142935>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The rev-list man page lists all commands of that family, with
> rev-list being the bare bones version, and log and friends being
> more "high level". log and rev-list walk the revision tree, show
> does not. Most of that can be changed through options. whatchanged
> is a special family member...
>
> diff is from a completely different family (see git help diff or git
> help diffcore). It never walks, but compares revisions (or other things).
>
> The log family never compares things, but can show a patch, i.e. the
> difference to the ancestor(s).

(That's why I put `git diff' into the mix...)

Anyway -- thanks for the overview.  So IIUC, `rev-list' and `log' are
different in that the second can also format diffs -- ?


>> Also related, it looks like `--abbrev-commit' has no effect on `git
>> rev-list', but does on `git log', even through it's documented in the
>> former's man page.  So it looks like either there are more
>> (undocumented?) differences, or maybe that's also a bug?
>
> I consider this a bug. In fact, it has an effect, but not a visible one.
> You would have to use --abbrev=7 or such.
>
> A patch is upcoming.

Thanks.

And one more question -- is there some %-escape that shows the whole
contents?  Something like "%(contents)" in `for-each-ref'?  (Which has
a different set of escapes...)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
