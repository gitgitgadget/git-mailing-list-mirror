From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Tue, 06 May 2008 14:17:27 +0200
Message-ID: <48204C57.5000909@viscovery.net>
References: <20080506115224.79802c7c@zebulon.innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Bryan Donlan <bdonlan@fushizen.net>
To: Brian FOSTER <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Tue May 06 14:18:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtM7h-0006yY-Lb
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 14:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbYEFMRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 08:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbYEFMRd
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 08:17:33 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:48359 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbYEFMRd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 08:17:33 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JtM6p-0005k0-UE; Tue, 06 May 2008 14:17:28 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B16D46B7; Tue,  6 May 2008 14:17:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080506115224.79802c7c@zebulon.innova-card.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 2.2 (++)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5, PLING_QUERY=0.514
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81356>

Brian FOSTER schrieb:
> Johannes Sixt kindly replied:
>> [ ... ]
>> For me, the unusable [ `gitk' ] scrollbar alone would be reason enough
>> to truncate the history.
>> [ ... ]  I have gitk running all the time.  So, yes, it is "important."
>> But I run it basically as 'gitk --all --not origin' and press F5 frequently.
>> With this set of arguments the scrollbar remains usable, and performance
>> is not an issue, even on Windows.
> 
> Hannes,
> 
>  May I ask why you are running `gitk' all the time?
>  Is this on some sort of a Linux kernel repository or something else?

Something else (~9000 commits, most of them imported from CVS).

I have gitk running all the time because I want a quick way to see "where
I am". That I get by pressing F5 (instead of typing in a longish command
to fire up gitk) and the mentioned argument list.

Also, quite a lot of the work I do is to polish a topic branch using 'git
rebase -i'. By browsing through the commits, I quickly get an overview
whether the branch is fine or needs more work.

>  Am I correct in interpreting `--all --not origin' as meaning "every
>  branch except those in origin/*" (i.e., all branches except the
>  remote-tracking ones)?

Not quite. It means the same as for 'git log': The commits from all
branches *but not* the commits from branch 'origin' (which is an alias for
origin/master, in my case, that's what is "published"). This is my way to
reduce the number of commits that are displayed and it amounts to ~300
commits.

-- Hannes
