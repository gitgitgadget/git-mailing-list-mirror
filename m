From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Cogito documentation updates
Date: 23 Nov 2005 06:33:10 -0800
Message-ID: <8664qjph7d.fsf@blue.stonehenge.com>
References: <20051120101112.GA2302@diku.dk>
	<86veyn49gc.fsf@blue.stonehenge.com> <20051123121651.GB19302@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 15:36:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eevh3-00060y-R0
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 15:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbVKWOdS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 09:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVKWOdS
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 09:33:18 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:22159 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750835AbVKWOdP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 09:33:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 04CC58F747;
	Wed, 23 Nov 2005 06:33:11 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 30893-01-65; Wed, 23 Nov 2005 06:33:10 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 9554A8F74A; Wed, 23 Nov 2005 06:33:10 -0800 (PST)
To: Jonas Fonseca <fonseca@diku.dk>
x-mayan-date: Long count = 12.19.12.14.15; tzolkin = 6 Men; haab = 13 Ceh
In-Reply-To: <20051123121651.GB19302@diku.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12627>

>>>>> "Jonas" == Jonas Fonseca <fonseca@diku.dk> writes:

Jonas> Ah, yes. I just recently tried local cloning on a FreeBSD box and it
Jonas> worked fine (apart from it spitting out a few errors, see the log below)
Jonas> and since the caveat section only mentioned the -u option I thought
Jonas> everything was fine. However, cloning a specific branch hits the error.
Jonas> So maybe the caveat section should just be updated to say that the -d
Jonas> option is required. 

But instead of targeting GNU tools, why not target POSIX tools where
possible?

I realize I'm being a rebel here.  I want to use git on non-Linux platforms.
I believe git is useful for far more than Linux Kernel development, and
you're this --> <-- close to making it work.

Delete the -d switch, or explain to me why it is there, and let's work
out a POSIX workaround.

I'm not asking for everyone to be cautious when contributing code.
I'll be happy to be "mr portability" and figure out how to make it
still work on OpenBSD and Darwin (my two platforms of choice).

However, as I said in another posting, maybe I just need to understand
the target market first.  (I realize that goal #1 is Linux Kernel
development.)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
