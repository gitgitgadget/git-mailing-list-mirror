From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: thoughts on a possible "pre-upload" hook
Date: Tue, 22 Sep 2009 09:00:11 -0700
Message-ID: <867hvr2cms.fsf@blue.stonehenge.com>
References: <2e24e5b90909220320rbd5fd1l40c7898656445232@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 18:00:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq7nJ-0003cr-Nk
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 18:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756591AbZIVQAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 12:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756575AbZIVQAK
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 12:00:10 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:28933 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756471AbZIVQAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 12:00:08 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 833DB1DE343; Tue, 22 Sep 2009 09:00:11 -0700 (PDT)
x-mayan-date: Long count = 12.19.16.12.14; tzolkin = 1 Ix; haab = 12 Chen
In-Reply-To: <2e24e5b90909220320rbd5fd1l40c7898656445232@mail.gmail.com> (Sitaram Chamarty's message of "Tue, 22 Sep 2009 15:50:09 +0530")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128943>

>>>>> "Sitaram" == Sitaram Chamarty <sitaramc@gmail.com> writes:

Sitaram> Hello,
Sitaram> As git is used more and more in corporate-type environments, at some
Sitaram> point it becomes convenient to have *branches* (or more accurately,
Sitaram> refs) that are not readable.  The simplest way to do this (from git's
Sitaram> point of view) is to allow a "pre-upload" hook, rather like the
Sitaram> "pre-receive" hook or "update" hook.

It would seem that you would need to do this even before the commit.  So
you're looking for the pre-commit hook.  Otherwise, the commit is invalid,
because it doesn't accurately represent everything it references.  And the
commit is the unit of transfer between repos.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
