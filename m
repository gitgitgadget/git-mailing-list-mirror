From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [ANNOUNCE] git-svnconvert: YASI (Yet Another SVN importer)
Date: 09 Apr 2006 15:06:55 -0700
Message-ID: <86mzeuflog.fsf@blue.stonehenge.com>
References: <20060409163426.GA22103@nospam.com> <e1bdjq$qf6$1@sea.gmane.org>
	<20060409211505.GA30567@nospam.com>
	<Pine.LNX.4.63.0604092325590.29434@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@wingding.demon.nl, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 10 00:07:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSi42-0001Fy-QZ
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 00:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWDIWG7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 18:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWDIWG5
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 18:06:57 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:47980 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750942AbWDIWG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 18:06:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 940D38F2A6;
	Sun,  9 Apr 2006 15:06:56 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 12162-01-4; Sun,  9 Apr 2006 15:06:56 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 1CC978F2A9; Sun,  9 Apr 2006 15:06:56 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
x-mayan-date: Long count = 12.19.13.3.12; tzolkin = 13 Eb; haab = 5 Pop
In-Reply-To: <Pine.LNX.4.63.0604092325590.29434@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18568>

>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

Johannes> I have _never_ seen a setup where Ruby was installed by
Johannes> default. Perl always, Python often.

OSX includes ruby by default.

Johannes> Furthermore, my feeling is that we are in the beginning phase of
Johannes> migration from scripting languages (which are good for prototyping)
Johannes> towards plain C.  So adding yet another scripting language
Johannes> dependency is a little backwards.

You seem a bit prejudiced here.  Are there performance problems in
the Perl and python parts of git?  If so, concentrate first on optimizing
the code where it matters.  Then, creating bindings to the "git lib"
so that the heavy lifting can be done in C while still providing for
the basic algorithms to be written in a higher level language.

It would be a step *backwards* to recode all of git in C.

Now, the *shell* parts, on the other hand, are screaming for a rewrite into
Perl or Python.  fork-fork-fork and worrying about escaping special characters
needlessly burns a lot of cpu and programmer time.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
