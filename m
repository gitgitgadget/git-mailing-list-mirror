From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: CTRL+Arrow keys don't work with Git Bash for Windows?
Date: Thu, 12 Feb 2015 08:27:03 +0000 (UTC)
Message-ID: <loom.20150212T092018-468@post.gmane.org>
References: <loom.20150129T161729-820@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 09:27:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLp7E-0002uV-N2
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 09:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbbBLI1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 03:27:12 -0500
Received: from plane.gmane.org ([80.91.229.3]:60505 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932154AbbBLI1L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 03:27:11 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YLp76-0002sD-Pa
	for git@vger.kernel.org; Thu, 12 Feb 2015 09:27:08 +0100
Received: from 131.228.216.128 ([131.228.216.128])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Feb 2015 09:27:08 +0100
Received: from sschuberth by 131.228.216.128 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Feb 2015 09:27:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 131.228.216.128 (Mozilla/5.0 (Windows NT 6.2; WOW64; rv:35.0) Gecko/20100101 Firefox/35.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263708>

Kevin <kevin071586 <at> yahoo.com> writes:

> that the CTRL+Arrow keys are not sending any unique sequences.  These
> sequences are distinct and can be bound as I am describing when using the
> "mintty.exe" xterm terminal emulator.  So why are they not working when I

Note that mintty does not work properly with (interactive) native Windows
applications (i.e. applications that do not link against msys-1.0.dll or
cygwin1.dll) like git.exe from Git for Windows, see [1].

> start up Git Bash (which I believe has no emulator, it just uses windows
> cmd.exe?).  I also see this problem when I use the "bash.exe --login -l"
> that was installed with MinGW/MSys.

There you have you answer: Git for Windows runs bash.exe (not cmd.exe) from
the MinGW/MSys package. So if you have this issue in vanilla MinGW/MSys,
you'll have it in Git for Windows, too. That said, it probably makes sense
for you to discuss this on the MinGW/MSys mailing list, or even file a bug
with them.

[1] https://code.google.com/p/mintty/issues/detail?id=56

Regards,
Sebastian
