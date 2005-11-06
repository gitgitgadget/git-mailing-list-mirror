From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes  through  the history
Date: 06 Nov 2005 14:43:17 -0800
Message-ID: <867jblpfcq.fsf@blue.stonehenge.com>
References: <436E85DA.1080904@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 23:44:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYtER-0001wU-Ki
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 23:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVKFWnU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 17:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVKFWnU
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 17:43:20 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:8864 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751264AbVKFWnT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 17:43:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id C16C28F9EE;
	Sun,  6 Nov 2005 14:43:18 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 00558-01; Sun,  6 Nov 2005 14:43:18 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 0570F8FA12; Sun,  6 Nov 2005 14:43:18 -0800 (PST)
To: Ryan Anderson <ryan@michonline.com>
x-mayan-date: Long count = 12.19.12.13.18; tzolkin = 2 Etznab; haab = 16 Zac
In-Reply-To: <436E85DA.1080904@michonline.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11235>

>>>>> "Ryan" == Ryan Anderson <ryan@michonline.com> writes:

Ryan> chdir($ARGV[0]);

That's dangerous without an "or-die".  Being in the wrong directory
before you do a lot of edits is a good way to bust your disk. :)

Ryan> 	my ($commit,@parents) = split /\s+/;

split with no args splits $_ on whitespace, tossing leading whitespace,
just in case they ever put whitespace indentation ahead.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
