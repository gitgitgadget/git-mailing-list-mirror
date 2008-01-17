From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 21:44:45 -0800
Message-ID: <86myr5f1ki.fsf@blue.stonehenge.com>
References: <478D79BD.7060006@talkingspider.com> <m3bq7lncak.fsf@roke.D-201>
	<20080117005954.GM18022@lavos.net>
	<86sl0xfd4e.fsf@blue.stonehenge.com>
	<46a038f90801161859n2f7d8c33kb5d359fb25d07488@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brian Downing" <bdowning@lavos.net>,
	"Jakub Narebski" <jnareb@gmail.com>,
	Mike <fromlists@talkingspider.com>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 06:45:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFNYw-0001gE-WC
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 06:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbYAQFoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 00:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbYAQFoq
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 00:44:46 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:25732 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbYAQFoq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 00:44:46 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 75E2D1DE7B1; Wed, 16 Jan 2008 21:44:45 -0800 (PST)
x-mayan-date: Long count = 12.19.14.17.19; tzolkin = 10 Cauac; haab = 7 Muan
In-Reply-To: <46a038f90801161859n2f7d8c33kb5d359fb25d07488@mail.gmail.com> (Martin Langhoff's message of "Thu, 17 Jan 2008 15:59:05 +1300")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70831>

>>>>> "Martin" == Martin Langhoff <martin.langhoff@gmail.com> writes:

Martin> I find the discussion of git-archive as a deployment tool a bit
Martin> worrying - remember that untarring a newer version of the tarball on
Martin> top of the old version does not remove old files.

"rsync --exclude [dangerous things} --delete --delete-excluded" is your friend.

They added --delete--excluded at my request, by the way.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
