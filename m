From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: diff settings
Date: Sat, 31 Jan 2009 14:47:25 -0500
Message-ID: <4984AACD.20600@tedpavlic.com>
References: <alpine.GSO.2.00.0901240936080.23073@kiwi.cs.ucla.edu> <87ocxwv6qg.fsf@iki.fi> <alpine.GSO.2.00.0901241159050.23073@kiwi.cs.ucla.edu> <497CD352.2060402@tedpavlic.com> <alpine.GSO.2.00.0901251307030.12651@kiwi.cs.ucla.edu> <497D1AB7.7000208@tedpavlic.com> <alpine.GSO.2.00.0901310750470.5437@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Sat Jan 31 21:06:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTM5a-0002v9-DO
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 21:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbZAaUCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 15:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbZAaUCm
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 15:02:42 -0500
Received: from relay.wanderingwifi.com ([38.101.222.140]:56907 "EHLO
	relay.wanderingwifi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbZAaUCm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 15:02:42 -0500
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Jan 2009 15:02:42 EST
Received: from TedBook.local (ip-216-36-87-158.chi.megapath.net [216.36.87.158])
	by relay.wanderingwifi.com (Spam Firewall) with ESMTP
	id B31BC160DD6; Sat, 31 Jan 2009 14:47:31 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <alpine.GSO.2.00.0901310750470.5437@kiwi.cs.ucla.edu>
X-Virus-Scanned: by Barracuda Spam Firewall at wanderingwifi.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107934>

> Thank you for alerting us to the Hg design.  I can appreciate the elegance of
> it, and I'm always in favor of the most general possible implementation.  But
> there is a subtle difference between diff.primer and primer.diff.

As I already discussed, Mercurial has both "diff.primer" and 
"primer.diff" precisely because "diff" settings affects so many Hg commands.

In particular, in my .hgrc, I have:

[diff]
git = 1

which causes all Mercurial commands that need to generate a diff to use 
gitdiff rather than truediff. However, if I *wanted* to apply a set of 
flags to a particular command, I could (using the equivalent "git" 
commands)...

[defaults]
pull = --rebase
commit = -a
format-patch = -M

So I see a purpose for both *.defaults and defaults.*. Of course, 
aliases are also nice (IIRC, Mercurial doesn't have "aliases", but I 
could be wrong). Mercurial users are very happy with having both 
available. I imagine git people would be too.

--Ted


-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
