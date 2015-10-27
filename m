From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Why are submodules not automatically handled by default or at
 least configurable to do so?
Date: Tue, 27 Oct 2015 15:16:37 +0300
Message-ID: <20151027151637.d3ed7f0dd8c72c78d373c520@domain007.com>
References: <D4E5E890658.000004DCjohsmi9933@inbox.com>
	<562F5704.5070405@letterboxes.org>
	<EC0D15E1-82B3-4A4C-96DE-8922AB870E2B@gmail.com>
	<562F629F.7040206@letterboxes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Davide Fiorentino <davide.fiorentino@gmail.com>,
	John Smith <johsmi9933@inbox.com>, git@vger.kernel.org
To: Nick <oinksocket@letterboxes.org>
X-From: git-owner@vger.kernel.org Tue Oct 27 13:16:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr3BO-0003I5-8j
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 13:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbbJ0MQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 08:16:50 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:60213 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbbJ0MQt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 08:16:49 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id t9RCGbPq017942;
	Tue, 27 Oct 2015 15:16:38 +0300
In-Reply-To: <562F629F.7040206@letterboxes.org>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280262>

On Tue, 27 Oct 2015 11:40:15 +0000
Nick <oinksocket@letterboxes.org> wrote:

> > Why not set alias(es) for that?
[...]
> But oh yes, there is another difficulty with aliases.  Eclipse users
> on Windows:
[...]

Not to counter your actual argument, but AFAIK EGit uses JGit which is
a Java implementation which does not call out to the "real" Git binary.
This basically means that if something gets implemented in the stock
Git, this won't affect JGit and EGit untill their respective
maintainers implement the same feature.

> they don't tend to love it if you tell them to install
> Cygwin, open a shell and type things into it.

On Windows, you typically want them to use Git for Windows, not
Cygwin.  Various GUI front-ends to Git working on Windows (such as Git
Extentions and TortoiseGit) rely on GfW to work as well.
