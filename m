From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: recent change in git.git/master broke my repos
Date: Thu, 25 Oct 2007 11:29:35 -0700
Message-ID: <863avz6oa8.fsf@blue.stonehenge.com>
References: <86oden6z97.fsf@blue.stonehenge.com>
	<20071025150107.GB31196@diana.vm.bytemark.co.uk>
	<alpine.LFD.0.9999.0710251344220.22100@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 20:29:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il7Sp-0005t6-4H
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 20:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbXJYS3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 14:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbXJYS3g
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 14:29:36 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:29150 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbXJYS3f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 14:29:35 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 24C9C1DE624; Thu, 25 Oct 2007 11:29:35 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.13.16; tzolkin = 5 Cib; haab = 4 Zac
In-Reply-To: <alpine.LFD.0.9999.0710251344220.22100@xanadu.home> (Nicolas Pitre's message of "Thu, 25 Oct 2007 13:46:04 -0400 (EDT)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62354>

>>>>> "Nicolas" == Nicolas Pitre <nico@cam.org> writes:

Nicolas> Isn't that called a remote branch that gets updated with "git fetch' ?
Nicolas> You can even trick Git into not using the refs/remotes/ namespace for 
Nicolas> them if you wish.

No.  I have a local master, and I want to be able to blindly say
"git-merge" on that master when doing so is only a fast forward.


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
