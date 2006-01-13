From: Pavel Roskin <proski@gnu.org>
Subject: StGIT: "stg new" vs "stg new --force"
Date: Fri, 13 Jan 2006 04:24:51 -0500
Message-ID: <1137144291.20073.104.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 13 10:25:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExLB4-0007s2-QX
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 10:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161508AbWAMJYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 04:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161509AbWAMJYz
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 04:24:55 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:25261 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1161508AbWAMJYz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 04:24:55 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1ExL8e-0000mY-TQ
	for git@vger.kernel.org; Fri, 13 Jan 2006 04:22:29 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1ExLAy-0001TV-2N; Fri, 13 Jan 2006 04:24:52 -0500
To: Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
X-Mailer: Evolution 2.5.4 (2.5.4-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14621>

Hello, Catalin!

Maybe I don't understand something in StGIT, but it seems strange that
"stg new" creates empty patch by default and requires "--force" to
create a non-empty patch.

It's much easier to give a patch a name once I know what it does.  Most
times I don't even intend to make a patch.  Suppose, I compile
something, then I find that some quick hack is needed to compile, then
the hack becomes a reasonable general solution.  When does it make sense
to run "stg new"?  Obviously, at the point when I know the patch is good
enough to be kept and sent upstream.  It happens after I change some
files, not before.

It's actually very rare that I decide to fix something like "bug #42
from the tracker" before having changed a single line.  It's also rare
that I follow through without getting distracted or realizing that I'm
fixing some other bug instead.

Also, "--force" is a strong word for a switch.  It's normally used for
options that could trigger information loss or unintended consequences
that are hard to undo.  Telling StGIT to record my changes hardly
qualifies as anything dangerous.

I know of "stg rename", but I don't want to be forced to name a patch
before it's ready.

Possible solutions:

1) "stg new --force" becomes "stg new" and "stg new" becomes "stg new
--empty", i.e. empty files can only be created with the "--empty"
switch.
2) "stg new --force" becomes "stg record" or something.
3) "stg new --force" becomes "stg new --record" or something.
4) "stg new" works both with and without modified files.

-- 
Regards,
Pavel Roskin
