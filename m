From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-cvsserver & push/commit atomically
Date: 12 Feb 2006 18:25:00 -0800
Message-ID: <86wtg0j8qr.fsf@blue.stonehenge.com>
References: <46a038f90602121550v4f487edfs788885a78c1b167@mail.gmail.com>
	<Pine.LNX.4.63.0602130110590.21465@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	martyn@catalyst.net.nz
X-From: git-owner@vger.kernel.org Mon Feb 13 03:25:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8TOo-0000q2-Sg
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 03:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWBMCZG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 21:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWBMCZG
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 21:25:06 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:32369 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750816AbWBMCZF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 21:25:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id B7E7A8F2E7;
	Sun, 12 Feb 2006 18:25:00 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 15532-01-2; Sun, 12 Feb 2006 18:25:00 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 310438F2EB; Sun, 12 Feb 2006 18:25:00 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
x-mayan-date: Long count = 12.19.13.0.16; tzolkin = 9 Cib; haab = 14 Pax
In-Reply-To: <Pine.LNX.4.63.0602130110590.21465@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16037>

>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

Johannes> Correct. The filesystem way to lock is to create a lock file and
Johannes> fail if it already exists.

Unless NFS has been fixed, that's not an atomic operation over NFS.  Might not
matter here, but important to note if this is your first time seeing this lock
strategy.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
