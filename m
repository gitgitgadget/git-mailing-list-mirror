From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Why git tags are there in git?
Date: Fri, 28 Jan 2011 19:06:28 +0300
Message-ID: <20110128190628.f507599e.kostix@domain007.com>
References: <1296214676536-5969544.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: vikram2rhyme <vikram2rhyme@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 17:06:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiqqO-0005Ck-Qy
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 17:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755040Ab1A1QGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 11:06:34 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:41429 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab1A1QGd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 11:06:33 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id p0SG6SpZ004537;
	Fri, 28 Jan 2011 19:06:29 +0300
In-Reply-To: <1296214676536-5969544.post@n2.nabble.com>
X-Mailer: Sylpheed 3.0.0 (GTK+ 2.10.14; i686-pc-mingw32)
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165622>

On Fri, 28 Jan 2011 03:37:56 -0800 (PST)
vikram2rhyme <vikram2rhyme@gmail.com> wrote:

> I am wondering why the tags are there in git. As they are just
> pointer to the commit
> we can refer those commit by SHA sum only then why tagging? Moreover a
> commit can
> be tagged more than once that result in multiple tags pointing to the
> same point in the history.
> Is this a design flaw?

Amending what other commenters said, I should note that beyond regular
tags which just provide human-readable names to objects, there exist
so-called "annotated tags" which are tags with descriptive messages
contained in them, which can be used as a side-channel to provide
additional information for commits, and also to digitally sign a line
of history to which such a tag is attached.

Also note that a tag can be attached to any object in a Git database,
not necessarily to a commit. This can be occasionally useful.
