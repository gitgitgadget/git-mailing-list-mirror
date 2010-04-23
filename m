From: Eli Barzilay <eli@barzilay.org>
Subject: Re: diff without num-stat
Date: Fri, 23 Apr 2010 13:14:31 -0400
Message-ID: <19409.54647.62163.893635@winooski.ccs.neu.edu>
References: <19408.40250.102191.314496@winooski.ccs.neu.edu>
	<4BD156F8.5090307@drmicha.warpmail.net>
	<7vwrvyzfr3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 23 19:14:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5MSd-0000mI-Ts
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 19:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758435Ab0DWROe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 13:14:34 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:34625 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758414Ab0DWROe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 13:14:34 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O5MSV-0004NT-2P; Fri, 23 Apr 2010 13:14:31 -0400
In-Reply-To: <4BD156F8.5090307@drmicha.warpmail.net>,
	<7vwrvyzfr3.fsf@alter.siamese.dyndns.org>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145629>

On Apr 23, Michael J Gruber wrote:
> Eli Barzilay venit, vidit, dixit 22.04.2010 21:02:
> > `git diff' has a `--numstat' flag, but is there any way to *avoid* the
> > numstat?  (I'm using `--stat' but want to void the summary line, and
> > I'd like to avoid piping it to `head'.)
> 
> So, what DO you want?
> [...]
> where "summary line" is something like
> 
> 5 files changed, 5974 insertions(+), 0 deletions(-)

An option that avoids that summary line.


On Apr 23, Junio C Hamano wrote:
> 
> Summary is "create mode ..." etc. and you can already enable/disable it.

Right -- I'm asking about the above numstat summary line, which seems
to always be included with `--stat'.


> That "N files +M/-N lines in total" is _not_ a summary; it is an
> integral part of ascii-graphical --stat output, which is supposed to
> produce output like "git diff -p | diffstat".  We won't split it out
> of --stat without a very good reason, there doesn't seem to be an
> option to "diffstat" for such a thing, so...

Well, the reason is to have an easy-to-glance-over summary of changes
for push notification emails.  I didn't realize that the intention of
--stat was to be completely compatible with `diffstat'.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
