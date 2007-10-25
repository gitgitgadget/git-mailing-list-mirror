From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: recent change in git.git/master broke my repos
Date: Thu, 25 Oct 2007 08:55:14 -0700
Message-ID: <86fxzz6vfh.fsf@blue.stonehenge.com>
References: <86oden6z97.fsf@blue.stonehenge.com>
	<20071025155142.GB19655@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 17:55:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il53S-0005nw-Fw
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 17:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760632AbXJYPzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 11:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757052AbXJYPzQ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 11:55:16 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:36599 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758882AbXJYPzO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 11:55:14 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 83CE71DE538; Thu, 25 Oct 2007 08:55:14 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.13.16; tzolkin = 5 Cib; haab = 4 Zac
In-Reply-To: <20071025155142.GB19655@coredump.intra.peff.net> (Jeff King's message of "Thu, 25 Oct 2007 11:51:42 -0400")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62327>

>>>>> "Jeff" == Jeff King <peff@peff.net> writes:

Jeff> Why is git-fetch touching your upstream branch at all? Do you have
Jeff> something in your .git/config instructing it to do so? Or do you mean
Jeff> that the 'git-merge upstream' command is failing? Can you 'git-show
Jeff> upstream'? If not, can you 'git-show origin/master'?

It's probably due to this:

[remote "origin"]
        url = [obscured]
        fetch = +refs/heads/*:refs/remotes/origin/*

fetch wants to sync my heads with the origin heads.  But yes, it's
definitely the fetch that fails under today's version, and not
under yesterday's version.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
