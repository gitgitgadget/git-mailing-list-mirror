From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: I want "fast forward my workdir to upstream if it's safe"
Date: Thu, 07 May 2009 16:20:22 -0700
Message-ID: <86ljp8fqkp.fsf@blue.stonehenge.com>
References: <86prekfv7z.fsf@blue.stonehenge.com>
	<FC9BF880-D69F-4A56-B9FA-EF5BDBF73437@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri May 08 01:20:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2CtD-0001aW-8G
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 01:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbZEGXUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 19:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbZEGXUW
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 19:20:22 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:47309 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbZEGXUV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 19:20:21 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 3F8E81DE390; Thu,  7 May 2009 16:20:22 -0700 (PDT)
x-mayan-date: Long count = 12.19.16.5.16; tzolkin = 6 Cib; haab = 14 Uo
In-Reply-To: <FC9BF880-D69F-4A56-B9FA-EF5BDBF73437@wincent.com> (Wincent Colaiuta's message of "Fri, 8 May 2009 01:18:32 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118538>

>>>>> "Wincent" == Wincent Colaiuta <win@wincent.com> writes:

>> I want a *command* I can tell people in #git.

Wincent> "git status"?

Wincent> # On branch master
Wincent> # Your branch is ahead of 'origin/master' by 46 commits.
Wincent> #
Wincent> # Changed but not updated:
Wincent> #   (use "git add <file>..." to update what will be committed)
Wincent> #   (use "git checkout -- <file>..." to discard changes in working  directory)
Wincent> #
Wincent> #       modified:   foo
Wincent> #
Wincent> # Untracked files:
Wincent> #   (use "git add <file>..." to include in what will be committed)
Wincent> #
Wincent> #       bar

Now, you expect them to parse that in a script?  "git status" is porcelain,
not plumbing, and can change from version to version, and has.

I want a command I can put in a cron job that Does The Right Thing.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
