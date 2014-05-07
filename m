From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [RFD] use approxidate for "git commit --date=xyz"?
Date: Wed, 7 May 2014 08:22:15 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1405070817580.15517@ds9.cixit.se>
References: <CA+55aFx=LizEyS6hq=av_qwRZuu_q3xPSXO-Jr4CAfXqaAuUtA@mail.gmail.com> <xmqq1tweec1o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 09:22:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhwBU-0001Z1-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 09:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbaEGHW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 03:22:28 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:36556 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750905AbaEGHW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 03:22:27 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s477MIsI024029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 7 May 2014 09:22:18 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s477MFd6024025;
	Wed, 7 May 2014 09:22:16 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <xmqq1tweec1o.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Wed, 07 May 2014 09:22:18 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248286>

Junio C Hamano:

> But why does the workflow need --date=now in the first place?

I tend to do this quite a lot, after fixing up a commit using rebase, 
I notice that the commit date is when I first started fixing the 
issue, even if that was a week or so ago. I then like to reset the 
commit date to reflect when I actually was done with it, and try 
"commit --amend --date=now".

I just haven't been annoyed enough to patch the code to fix it (so the 
git repository at my $dayjob does have a number of commits with the "wrong" 
commit time in it [1]), but I would welcome such an addition.

-- 
\\// Peter - http://www.softwolves.pp.se/

  [1] The last such is one that took me about a week to implement:
       AuthorDate: 2014-04-15 15:48:38 +0200
       CommitDate: 2014-04-22 09:23:25 +0100
      it'd look better to have the AuthorDate at the 22nd as well, imho.
