From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Do not trust PWD blindly
Date: Sun, 10 Jul 2011 18:52:36 -0700
Message-ID: <86k4bpporf.fsf@red.stonehenge.com>
References: <CABNJ2GKgzXGDq9FhKcVP380bs=rEKqYdrOaCb+A99_TBm7A4_A@mail.gmail.com>
	<alpine.DEB.1.00.1107091935210.1985@bonsai2>
	<4E1A0FCC.7080308@kdbg.org>
	<alpine.DEB.1.00.1107110057120.3379@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Pat Thoyts <patthoyts@gmail.com>,
	gitster@pobox.com, msysGit <msysgit@googlegroups.com>,
	Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 11 03:53:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qg5gU-0008Ge-2M
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 03:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176Ab1GKBxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jul 2011 21:53:11 -0400
Received: from lax-gw06.mailroute.net ([199.89.0.106]:40711 "EHLO
	mail.mroute.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755753Ab1GKBxK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2011 21:53:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by lax-gw06.mroute.net (Postfix) with ESMTP id E135EC5CC;
	Mon, 11 Jul 2011 01:52:52 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by lax-gw06.mroute.net (Postfix) with ESMTP id 91475C5CA;
	Mon, 11 Jul 2011 01:52:36 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 7329E3B30; Sun, 10 Jul 2011 18:52:36 -0700 (PDT)
x-mayan-date: Long count = 12.19.18.9.10; tzolkin = 7 Oc; haab = 18 Tzec
In-Reply-To: <alpine.DEB.1.00.1107110057120.3379@bonsai2> (Johannes
	Schindelin's message of "Mon, 11 Jul 2011 00:59:03 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176831>

>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

Johannes> You might be very surprised, but that is not true on the Linux system 
Johannes> where one of the 4msysgit.git test cases does _not_ break, while it does 
Johannes> on Windows.

If you ever depend on a userspace PWD to be your actual current
directory without at least stat()ing it, you've failed.

In my experience, it is *never* reliable.  It's just a hint.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
