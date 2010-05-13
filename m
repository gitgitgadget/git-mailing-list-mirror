From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: regarding "git status"
Date: Thu, 13 May 2010 07:17:20 -0700
Message-ID: <86pr0zdgy7.fsf@red.stonehenge.com>
References: <loom.20100513T155553-871@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Terrence Brannon <schemelab@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 16:17:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCZE8-00027Y-0M
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 16:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758225Ab0EMORW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 10:17:22 -0400
Received: from red.stonehenge.com ([208.79.95.2]:35107 "EHLO
	red.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756913Ab0EMORV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 10:17:21 -0400
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id C537615EE1; Thu, 13 May 2010 07:17:20 -0700 (PDT)
x-mayan-date: Long count = 12.19.17.6.7; tzolkin = 13 Manik; haab = 0 Zip
In-Reply-To: <loom.20100513T155553-871@post.gmane.org> (Terrence Brannon's
	message of "Thu, 13 May 2010 13:56:06 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147007>

>>>>> "Terrence" == Terrence Brannon <schemelab@gmail.com> writes:

Terrence> In the manpage for git-status
Terrence> (http://www.kernel.org/pub/software/scm/git/docs/git-status.html) it says:

Terrence> "Displays paths that have differences between the index file
Terrence> and the current HEAD commit"

Terrence> but how could something be added to the index and not be
Terrence> different from the current HEAD commit? shouldnt this sentence
Terrence> say: "displays paths that have been added to the index"

The HEAD commit might have changed without changing the index via
something like "git reset --soft $sha1".  So yes, either the index or
the head might have changed, and this is reporting the differences
between them.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
