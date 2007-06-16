From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Add a local implementation of hstrerror for the system  which do not have it
Date: Sat, 16 Jun 2007 08:21:41 -0700
Message-ID: <86tzt7udq2.fsf@blue.stonehenge.com>
References: <86ejkh40cr.fsf@blue.stonehenge.com>
	<20070612205210.GC2459@steel.home> <20070612213129.GD2459@steel.home>
	<466F971F.C74761E2@eudaptics.com>
	<81b0412b0706130051l570e6ab7y48d6eea8c6b2d97e@mail.gmail.com>
	<20070613185432.GA3412@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <J.Sixt@eudaptics.com>,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 16 17:21:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hza5z-0000jd-Oh
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 17:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757354AbXFPPVn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 11:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757369AbXFPPVm
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 11:21:42 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:43070 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756373AbXFPPVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 11:21:42 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id CF6971DE396; Sat, 16 Jun 2007 08:21:41 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.7.5; tzolkin = 4 Chicchan; haab = 13 Zotz
In-Reply-To: <20070613185432.GA3412@steel.home> (Alex Riesen's message of "Wed, 13 Jun 2007 20:54:32 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50290>

>>>>> "Alex" == Alex Riesen <raa.lkml@gmail.com> writes:

Alex> The function converts the value of h_errno (last error of name
Alex> resolver library, see netdb.h).
Alex> One of systems which supposedly do not have the function is SunOS.
Alex> POSIX does not mandate its presence.

Thanks... 952c8c5 compiles and installs fine on sunos now.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
