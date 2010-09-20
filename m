From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Reduced privileges install
Date: Sun, 19 Sep 2010 18:07:30 -0700
Message-ID: <86k4mhfcj1.fsf@red.stonehenge.com>
References: <325786BC-5F54-47B5-AEF5-7FDAD9BEA4BA@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 03:17:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxV0b-0006eu-0x
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 03:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914Ab0ITBRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 21:17:10 -0400
Received: from red.stonehenge.com ([208.79.95.2]:35015 "EHLO
	red.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792Ab0ITBRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 21:17:09 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Sep 2010 21:17:09 EDT
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 185EA1522; Sun, 19 Sep 2010 18:07:30 -0700 (PDT)
x-mayan-date: Long count = 12.19.17.12.16; tzolkin = 12 Cib; haab = 9 Chen
In-Reply-To: <325786BC-5F54-47B5-AEF5-7FDAD9BEA4BA@kellerfarm.com> (Andrew
	Keller's message of "Sun, 19 Sep 2010 19:50:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156542>

>>>>> "Andrew" == Andrew Keller <andrew@kellerfarm.com> writes:

Andrew> Because I do not own the server and my account has restricted
Andrew> privileges, I attempted to augment my PATH to include a
Andrew> directory in my home folder, and then install git in there by
Andrew> specifying a prefix at the configure stage.  The configure and
Andrew> the make work, but the make install fails.  Here's the last
Andrew> section of the log:

What's your PREFIX set to?  If you set your prefix, the Perl modules are
installed below the prefix, not in the system dirs.

Andrew> $ make install

Yeah, I don't see a prefix here, unless you set it in your Makefile.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
