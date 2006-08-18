From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: something broken just now on git-pull from openbsd to OSX
Date: 18 Aug 2006 09:19:52 -0700
Message-ID: <86lkpmkod3.fsf@blue.stonehenge.com>
References: <86pseykogj.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 18 18:20:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE74y-0000GH-LT
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 18:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWHRQT6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 12:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWHRQT6
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 12:19:58 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:55616 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751402AbWHRQT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 12:19:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id DC9F48FBFA
	for <git@vger.kernel.org>; Fri, 18 Aug 2006 09:19:56 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 10398-01-50 for <git@vger.kernel.org>;
 Fri, 18 Aug 2006 09:19:56 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 6DF868FBFF; Fri, 18 Aug 2006 09:19:52 -0700 (PDT)
To: git <git@vger.kernel.org>
x-mayan-date: Long count = 12.19.13.10.3; tzolkin = 1 Akbal; haab = 16 Yaxkin
In-Reply-To: <86pseykogj.fsf@blue.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25673>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal> I just updated my openbsd's GIT to 1.4.2.g55c3, and now my
Randal> git-fetch from there to my OSX fails with a fatal error almost immediately.

Randal> What just changed?  What can I check?

Randal> git-fetch from other repositories to OSX seems to work fine.

Ahh, it might even be a corrupt repository... here's what
a local git-clone shows:

git-clone ~/Git/stonehenge.git
remote: Generating pack...
remote: Done counting 2610 objects.
remote: Deltifying 2610 objects.
 100% (2610/2610) done
remote: Total 2610, written 2610 (delta 1244), reused 2610 (delta 1244)
error: git-fetch-pack: unable to read from git-index-pack
error: git-index-pack died of signal 11
fetch-pack from '/home/merlyn/Git/stonehenge.git/.git' failed.

What do you want me to try to help diagnose this?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
