From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Reduced privileges install
Date: Mon, 20 Sep 2010 07:52:27 -0700
Message-ID: <8639t4fowk.fsf@red.stonehenge.com>
References: <325786BC-5F54-47B5-AEF5-7FDAD9BEA4BA@kellerfarm.com>
	<86k4mhfcj1.fsf@red.stonehenge.com>
	<6BE502C9-5507-452D-A5D5-D0C69C05F126@kellerfarm.com>
	<677DFF75-2DBB-4772-802B-4402E4024307@sb.org>
	<vpqzkvcwka0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>,
	Andrew Keller <andrew@kellerfarm.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 20 16:52:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxhjO-0001u9-M6
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 16:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756437Ab0ITOw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 10:52:29 -0400
Received: from red.stonehenge.com ([208.79.95.2]:61050 "EHLO
	red.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755447Ab0ITOw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 10:52:28 -0400
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id E8F032077; Mon, 20 Sep 2010 07:52:27 -0700 (PDT)
x-mayan-date: Long count = 12.19.17.12.17; tzolkin = 13 Caban; haab = 10 Chen
In-Reply-To: <vpqzkvcwka0.fsf@bauges.imag.fr> (Matthieu Moy's message of "Mon,
	20 Sep 2010 16:40:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156628>

>>>>> "Matthieu" == Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

Matthieu> In my case, it was GNU/Linux machines, so something may go wrong
Matthieu> because of a non-gnu system. Did you try compiling with gmake instead
Matthieu> of make?

Works fine for me on OSX.  Here's my build script:

get.git:

    cd ~/MIRROR/git-GIT && git fetch && git diff --stat live origin/master

make.git:

    cd ~/MIRROR/git-GIT &&
    git reset --hard origin/master &&
    make prefix=/opt/git all install quick-install-man &&
    git tag -f live HEAD

And everything (including the Perl bits) ends up under /opt/git.

I don't even run configure.  Not sure why I would. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
