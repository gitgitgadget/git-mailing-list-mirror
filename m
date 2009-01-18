From: "George Spelvin" <linux@horizon.com>
Subject: Re: fatal: git grep: cannot generate relative filenames containing
 '..'
Date: Sun, 18 Jan 2009 11:58:23 -0500
Message-ID: <20090118165823.24501.qmail@science.horizon.com>
References: <20090115222905.8157.qmail@science.horizon.com>
 <7vr634ow3r.fsf@gitster.siamese.dyndns.org>
 <83vdsefz9j.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux@horizon.com, git@vger.kernel.org
To: gitster@pobox.com, azure@iki.fi
X-From: git-owner@vger.kernel.org Sun Jan 18 17:59:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOb02-0008A7-5R
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 17:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757587AbZARQ60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 11:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756903AbZARQ6Z
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 11:58:25 -0500
Received: from science.horizon.com ([192.35.100.1]:16173 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755417AbZARQ6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 11:58:25 -0500
Received: (qmail 24502 invoked by uid 1000); 18 Jan 2009 11:58:23 -0500
In-Reply-To: <83vdsefz9j.fsf@kalahari.s2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106242>

Hannu Koivisto <azure@iki.fi> wrote:
> It turns out that this "entire git tree" is practically my only use
> case when using normal (find and) grep and when I first tried git
> grep, I actually expected it to do just that with no path specified.
>
> Why?  Because of the way at least git diff and git log work.  I
> thought that just like with them, "git grep foo" would search the
> entire git tree and I would have to say "git grep foo ." to limit to
> the current directory and its subdirectories.  git-grep(1)'s "Look
> for specified patterns in the working tree files..." at least
> didn't seem to disagree with my expectation so I was a bit puzzled.
>
> So I'd rather see git grep behave in a way consistent with git log
> and git diff (I realize that would change current behaviour instead
> of extending it).

D'oh.  You're completely right.  Space-dot is trivial to type if you
want the current directory only, and that is more consistent.

Could that be considered for 1.7?
