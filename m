From: Richard Ipsum <richard.ipsum@codethink.co.uk>
Subject: Working towards a common review format for git
Date: Fri, 8 Jan 2016 14:08:31 +0000
Message-ID: <20160108140831.GA10200@salo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Borowitz <dborowitz@google.com>,
	Stefan Beller <sbeller@google.com>,
	Edwin Kempin <ekempin@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 15:09:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHXjO-0000yY-Gq
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 15:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216AbcAHOJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 09:09:23 -0500
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:34404 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755434AbcAHOId (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 09:08:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 2BB5A4622BE;
	Fri,  8 Jan 2016 14:08:31 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GvvGIkw0A3oy; Fri,  8 Jan 2016 14:08:27 +0000 (GMT)
Received: from salo (salo.dyn.ducie.codethink.co.uk [10.24.2.138])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id D1608460A89;
	Fri,  8 Jan 2016 14:08:27 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283553>

Hi,

In a prior email I mentioned in passing a library I've been working
on to try to reach a common format for storing review content in git:
perl-notedb.[1]

I'm making reasonable progress with this but my work has uncovered
necessary (and trivial) modifications to Notedb, the first[2] is a
trivial modification to ensure the 'Status' trailer gets written
to the commit when a change's status changes. The second[3] is an RFC
where I suggest adding a 'Commit' trailer so that it is always
possible to reference the commit under review by its sha.

With these patches applied to gerrit it's possible for perl-notedb to parse
all meta content from notedb and map it to the actual git content
under review. However, my concern at present is that I'm already
operating under a fork of notedb which defeats the objective of
collaborating to produce a standard format, let's try to avoid[4]

If the gerrit folks could let me know what I need to do to get
these modifications merged, or else what we need to do to achieve
equivalent functionality I'd really appreciate it.

Thanks again,
Richard Ipsum

[1]: https://bitbucket.org/richardipsum/perl-notedb
[2]: https://gerrit-review.googlesource.com/#/c/73436/
[3]: https://gerrit-review.googlesource.com/#/c/73602/
[4]: https://xkcd.com/927/
