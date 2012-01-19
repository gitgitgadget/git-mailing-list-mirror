From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [BUG ?] completion of stash name with git stash
Date: Thu, 19 Jan 2012 19:14:16 +0100
Message-ID: <87obtzlfuv.fsf@thomas.inf.ethz.ch>
References: <loom.20120119T141601-606@post.gmane.org>
	<87lip3mzsz.fsf@thomas.inf.ethz.ch>
	<loom.20120119T172954-563@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Mathieu CLAVEL <math.clavel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 19:14:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnwVH-0006ma-Cs
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 19:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734Ab2ASSOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 13:14:23 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:31023 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932685Ab2ASSOV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 13:14:21 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 19 Jan
 2012 19:14:16 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (188.155.176.28) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 19 Jan
 2012 19:14:18 +0100
In-Reply-To: <loom.20120119T172954-563@post.gmane.org> (Mathieu CLAVEL's
	message of "Thu, 19 Jan 2012 16:34:05 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188822>

Mathieu CLAVEL <math.clavel@gmail.com> writes:

> Thomas Rast <trast <at> student.ethz.ch> writes:
>
>> This works for me using git completion as shipped with v1.7.9-rc2 and
>> bash 4.2.10.  Double-tabbing at 'git stash drop ' prints a list of
>> stashes as expected.  Which bash version are you using?
>
>
> $ bash --version
> GNU bash, version 3.1.0(1)-release (i686-pc-msys)
> Copyright (C) 2005 Free Software Foundation, Inc.
>
> It's the version ship with the last version of msysGit.
> I'm not sure I can update bash on Windows without any risk to break something.
> So, do you think it's coming from the bash version ?

Indeed, I compiled bash 3.1 and with that (and otherwise the same bashrc
etc.) I can reproduce.  Ditto for 4.0-rc1, which was the newest version
in the repository where I found the bash source[1], so I couldn't
bisect.  Perhaps if you can hunt down something newer you could try to
find the version where it starts working.



[1] git://gitorious.org/bash/bash.git

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
