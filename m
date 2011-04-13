From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Gitbox
Date: Wed, 13 Apr 2011 12:41:41 -0700
Message-ID: <86vcyigcqy.fsf@red.stonehenge.com>
References: <A2315DA1-780C-4024-B774-9AD5F9AA0DB6@medialab.com>
	<1302721187.21900.4.camel@drew-northup.unet.maine.edu>
	<1E5D7DCE-B3B3-4CC7-8F40-4ED48E76907D@gmail.com>
	<1302722214.22161.5.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Juran <jjuran@gmail.com>,
	Daniel Searles <dsearles@medialab.com>, git@vger.kernel.org,
	oleganza@gmail.com
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Apr 13 21:42:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA5xF-00052J-LW
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 21:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357Ab1DMTmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 15:42:16 -0400
Received: from lax-gw06.mailroute.net ([199.89.0.106]:42779 "EHLO
	mail.mroute.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932159Ab1DMTmP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 15:42:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by lax-gw06.mroute.net (Postfix) with ESMTP id 4AF27C598;
	Wed, 13 Apr 2011 19:41:57 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by lax-gw06.mroute.net (Postfix) with ESMTP id 8E612C592;
	Wed, 13 Apr 2011 19:41:41 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 7E0701BE0; Wed, 13 Apr 2011 12:41:41 -0700 (PDT)
x-mayan-date: Long count = 12.19.18.5.2; tzolkin = 10 Ik; haab = 10 Pop
In-Reply-To: <1302722214.22161.5.camel@drew-northup.unet.maine.edu> (Drew
	Northup's message of "Wed, 13 Apr 2011 15:16:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171480>

>>>>> "Drew" == Drew Northup <drew.northup@maine.edu> writes:

Drew> He also clearly stated that he's not calling git command-line tools...

Drew> "Gitbox neither links (statically or dynamically) against Git nor uses
Drew> custom interfaces to interact with it. Git binaries are provided for
Drew> your convenience only."

Huh?  How do you get "not using git CLI" there?  He's not using *custom*
interfaces, but the *standard* interfaces are more than enough.

He's made new porcelein, and using the plumbing directly.  That's
exactly why we have plumbing in git, right?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
