From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: do you recommend "git" (over svn) for a 1-person team???
Date: Wed, 28 Jan 2009 21:09:09 -0500
Message-ID: <49810FC5.2070902@tedpavlic.com>
References: <d30068860901281718x363348caya2dc94e798cc8091@mail.gmail.com> <d30068860901281725t14d19c1vc0557182bca3eb8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Greg Hauptmann <greg.hauptmann.ruby@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 03:10:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSMMe-0006d1-0Z
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 03:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbZA2CJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 21:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752829AbZA2CJS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 21:09:18 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:47095 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752824AbZA2CJR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jan 2009 21:09:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id E519980D804F;
	Wed, 28 Jan 2009 21:03:07 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SxA25oGOvE67; Wed, 28 Jan 2009 21:03:07 -0500 (EST)
Received: from TedBook.local (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 57F4A80D8025;
	Wed, 28 Jan 2009 21:03:07 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <d30068860901281725t14d19c1vc0557182bca3eb8d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107614>

> Do you recommend "git" (over svn) for a 1-person team???   (the
> ability to commit whilst offline on my laptop sounds potentially
> enough reason)

At this point, it is clear that you've bought into using *some* form of 
revision control locally. So you are really asking whether DVCS is 
appropriate for personal-only use. If all you care about is the ability 
to commit locally, then you might as well use vanilla RCS (i.e., the 
ultimate "plumbing" behind SVN).

How easy DVCS solutions make merging and rebasing is a secondary feature 
for me. Primarily, I like that while doing my work, I don't ever have to 
*think* about the revision control. I don't have to check out or lock 
files. I don't have to worry about checking in all of my changes. I just 
work, and, when I'm ready, the DVCS takes care of everything else. It's 
the *overall* ease of use that makes DVCS so valuable to me...  (and who 
knows... maybe later someone will want to clone my repo and we'll trade 
commits back and forth)

[ Keep in mind that git is not the only DVCS. For some of my personal 
projects, I use hg (Mercurial), and for others I use git. On none of 
them do I use SVN. Unfortunately, the proliferation of SVN on 
SourceForge has prevented me from contributed myriad local patches to 
projects that are otherwise very important to me. Perhaps another great 
reason to use DVCS locally is that you'll be putting implicit pressure 
on places like SF to modernize. ]

Best --
Ted

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
