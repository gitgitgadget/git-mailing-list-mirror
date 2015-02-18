From: David Kastrup <dak@gnu.org>
Subject: Possible GSoC project?
Date: Wed, 18 Feb 2015 20:27:03 +0100
Message-ID: <87h9ujja0o.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 20:27:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOAHA-0006Zi-2t
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 20:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348AbbBRT1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 14:27:07 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:54710 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbbBRT1F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 14:27:05 -0500
Received: from localhost ([127.0.0.1]:53753 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1YOAH2-0007MI-9n
	for git@vger.kernel.org; Wed, 18 Feb 2015 14:27:04 -0500
Received: by lola (Postfix, from userid 1000)
	id D59D1E0E86; Wed, 18 Feb 2015 20:27:03 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264054>


Maybe it would be worthwhile to explore GUB
<URL:http://www.lilypond.org/gub> for rolling the Windows (and possibly
Cygwin as well, but then they tend to do their own) release/installer
for Git?

LilyPond has a similar mixture of scripting engines and target-dependent
bits-of-GNU that it packages into its installers (for GNU/Linux,
FreeBSD, MacOSX on PowerPC as well as x86, Windows) using GUB, and as
far as developers are concerned, the synchronized releases happen
without any extra work and involvement just by letting the standard
release scripts roll.

Looking at <URL:http://lilypond.org/gub/applications>, there appears to
be a Git recipe already, but it will likely not be an installed bundle
including the necessary scripting engines (what's it?  Tk, Perl,
Bash/Dash, and similar?).

So it might be worth figuring out what is needed for setting this up in
order to have a run-and-forget kind of release for a number of
platforms.

-- 
David Kastrup
