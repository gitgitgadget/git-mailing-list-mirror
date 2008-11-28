From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: timestamps not git-cloned
Date: Fri, 28 Nov 2008 15:59:56 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0811281554560.14606@ds9.cixit.se>
References: <87ej0wwptn.fsf@jidanni.org> <e3f230850811271908g1be6b3f9t3e678081088de06b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jidanni@jidanni.org, Git Mailing List <git@vger.kernel.org>
To: dhruva <dhruvakm@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 16:01:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L64qj-0004Sf-T1
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 16:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbYK1PAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 10:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbYK1PAK
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 10:00:10 -0500
Received: from ds9.cixit.se ([193.15.169.228]:48264 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbYK1PAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 10:00:09 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id mASExwY1028140
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 28 Nov 2008 15:59:58 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id mASExu19028131;
	Fri, 28 Nov 2008 15:59:57 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <e3f230850811271908g1be6b3f9t3e678081088de06b@mail.gmail.com>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 28 Nov 2008 15:59:58 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101877>

Hi!

dhruva:

> I do not think there is an VCS that records timestamps. Only file
> contents are tracked.

CVS sort of does. The initial checkout sets the time stamp of files to
their last *check-in* time (and you can import a file with -D to set
its commit time to the current timestamp). Updates do, however, set to
current time (to not break make and friends).

I miss this behaviour in Git, but I have learnt to live with it. I
guess it is like a difference in philosophy on what time-stamps are
supposed to record, like how UNIX "cp" sets the time of the new-born
copy to now, while DOS "copy" sets it to the old time-stamp. Coming
to Unix and Linux from DOS (via OS/2), I find "cp" behaviour weird. But
have learnt to live with it (and use "cp -a" a lot).

-- 
\\// Peter - http://www.softwolves.pp.se/
