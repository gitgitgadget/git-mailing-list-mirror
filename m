From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: git-core vs git package on ubuntu
Date: Fri, 25 Jan 2013 18:06:57 +0400
Message-ID: <20130125180657.648f2d985a43d4c80133c599@domain007.com>
References: <4A4C2896-042A-4BE3-9E74-012D881D5776@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mario Michael Krell <supermariton@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 15:07:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyjwL-00072w-WC
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 15:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099Ab3AYOHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 09:07:13 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:52518 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423Ab3AYOHL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 09:07:11 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r0PE6vWN006714;
	Fri, 25 Jan 2013 18:06:58 +0400
In-Reply-To: <4A4C2896-042A-4BE3-9E74-012D881D5776@googlemail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214553>

On Fri, 25 Jan 2013 14:50:24 +0100
Mario Michael Krell <supermariton@googlemail.com> wrote:

> In your documentation you say, that git should be installed on Unix
> using
> 
> apt-get install git-core

Note that Ubuntu is not Unix.

> Unfortunately it tells the user, that this package is obsolete and
> "git" should be used instead. Is this an error in the package manager
> or in the website documentation?

Neither of them.  Git was packaged for Debian (and hence appeared in
Ubuntu) when another package with the name "git" already existed in the
archive, and was unrelated to Git.  So the Git package maintainer
picked the name "git-core".  After that, the maintainers of both
packages discussed this issue and the maintainer of the original
package named "git" agreed to change the name of his package, and then,
subsequently, "git-core" has been renamed to "git", and the "git-core"
package has been turned into transitional dummy obsolete package.

Now, whenever you're trying to install the "git-core" package, the
package system tells you it's obsolete and suggests the "correct"
package to install.  After some time (the next OS release or later),
the "git-core" package will be removed completely from the archive.

This is the standard way to handle such situations in Debian and its
derivatives, so nothing special here.  The documentation on the
whatever site you were referring to should probably be updated as
git-core is obsolete even in the current stable release of Debian [1].
I'm not sure which LTS release of Ubuntu is currently supported, but
you might check the state of the git-core package in it yourself,
using [2].

1. http://packages.debian.org/squeeze/git-core
2. http://packages.ubuntu.com
