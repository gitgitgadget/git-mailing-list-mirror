From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [msysGit] Re: [PULL] Pull request from msysGit
Date: Sat, 09 Oct 2010 18:56:11 +0100
Message-ID: <4CB0ACBB.9040601@ramsay1.demon.co.uk>
References: <87ocb9zfbf.fsf@fox.patthoyts.tk>	<4CAE00C5.1050509@ramsay1.demon.co.uk>	<4CAE1FE6.9020306@opentext.com> <AANLkTinSjFDdwqTEU6XzOVHupph0G2ZKM+u3r7t_W3DD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Peter Harris <pharris@opentext.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, sschuberth@gmail.com
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 09 19:58:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4dgP-0001qt-3n
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 19:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760298Ab0JIR54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 13:57:56 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:59804 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755969Ab0JIR5z (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Oct 2010 13:57:55 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1P4dgA-0006O0-kH; Sat, 09 Oct 2010 17:57:54 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <AANLkTinSjFDdwqTEU6XzOVHupph0G2ZKM+u3r7t_W3DD@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158596>

Pat Thoyts wrote:
> The patch in question has been on the msysGit tree for about 10 months
> now. Its somewhat disappointing not to have had it spotted before we
> pushed it upstream. Are the msvc builders only working against junio's
> repository?

Well, I can't speak for anyone else, but for me the answer is yes. ;-)
I build git (from the git.kernel.org repository) on Linux, cygwin,
cygwin+msvc and msysGit. (For a short while I also built it on FreeBSD
hosted in a VM - but that was so slow, I soon stopped doing that!).

So, the git I *use* on MinGW/msysGit is built from junio's repository.
I only installed msysGit to enable me to check that my patches worked
on MinGW (I was tired of always saying "could somebody test this on
MinGW ..."). As you may have noticed, the mingw and msvc builds share
quite a bit of compatibility code...

[I don't follow 4msysgit or subscribe to the msysgit mailing list, so
I would not normally see any 4msysgit patches, unless they were also
discussed on the git mailing list.]

ATB,
Ramsay Jones
