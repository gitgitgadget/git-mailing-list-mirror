From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-blame.el
Date: Thu, 1 Feb 2007 14:12:13 +0100
Message-ID: <20070201131213.GB11611@diana.vm.bytemark.co.uk>
References: <87iren2vqx.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Feb 01 14:12:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCbjq-0006IG-Cw
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 14:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422857AbXBANM1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 1 Feb 2007 08:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422859AbXBANM1
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 08:12:27 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2665 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422857AbXBANM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 08:12:26 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HCbja-0003BE-00; Thu, 01 Feb 2007 13:12:14 +0000
Content-Disposition: inline
In-Reply-To: <87iren2vqx.fsf@morpheus.local>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38349>

On 2007-01-31 14:04:06 +0100, David K=E5gedal wrote:

> Here's another version of git-blame.el that automatically tries to
> create a sensible list of colors to use for both light and dark
> backgrounds. Plus a few minor fixes.

I've tried it, like the concept of in-buffer blame and the pretty
colors, and have a few comments and suggestions:

  1. For some files, but not all, emacs is unresponsive (and consumes
     lots of CPU) right after git-blame-mode is activated. Once
     git-blame has finished, it becomes responsive again, but this
     kind of defeats the whole "incremental" idea.

     This is most easily seen by holdnig down Ctrl+N or similar, to
     make the cursor move constantly.

  2. Getting to see the sha1 of the commit is not so useful when it
     can't be selected for copy-pasting. Maybe a keyboard shortcut for
     "copy-sha1-to-kill-ring"?

  3. Even after I've edited a line, or added a new line, they continue
     to be attributed to the same existing commits. They should either
     have no attribution, or possibly just "local edit" or something.
     I seem to recall this kind of functionality for git-blame being
     discussed very recently?

  4. It would be nice with a keyboard shortcut that (in a new buffer)
     printed more details about the commit under the cursor, kind of
     like the output from git-log. (Having this available would
     obviate the need for (2).)

  5. It would be nice with a keyboard shortcut for displaying the
     commit under the cursor in gitk. (For extra points: successive
     uses of this command should reuse the same gitk window if it's
     still open.)

  6. It would be nice with a keyboard shortcut for displaying (in a
     separate buffer) the diff to that file introduced by the commit
     under the cursor. This could be combined with (3) by having
     commit details followed by diff.

Oh, and try to have it done by Monday. ;-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
