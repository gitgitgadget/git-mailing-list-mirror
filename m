From: Pete/Piet Delaney <pete@bluelane.com>
Subject: Re: Qgit performance and maintain CVS environment with GIT repository
Date: Thu, 18 Oct 2007 17:22:39 -0700
Organization: Bluelane
Message-ID: <4717F8CF.9060103@bluelane.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>  <47159779.6010502@bluelane.com>  <e5bfff550710170030y7778e96ax146acea7a0e57a67@mail.gmail.com>  <200710171800.37345.robin.rosenberg.lists@dewire.com> <e5bfff550710171626h733228aw7a251746d2b43c63@mail.gmail.com> <4717EF40.6000509@bluelane.com> <Pine.LNX.4.64.0710190054570.25221@racer.site>
Reply-To: pete@bluelane.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	piet.delaney@gmail.piet.net,
	Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org,
	piet.delaney@gmail.com, Piet Delaney <pdelaney@bluelane.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 19 02:23:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iifdg-0006zS-HB
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 02:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbXJSAWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 20:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbXJSAWq
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 20:22:46 -0400
Received: from outbound.mse2.exchange.ms ([69.25.50.247]:1188 "EHLO
	mse2fe1.mse2.exchange.ms" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753339AbXJSAWp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 20:22:45 -0400
Received: from piet2.bluelane.com ([64.95.123.130]) by mse2fe1.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 18 Oct 2007 20:22:44 -0400
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <Pine.LNX.4.64.0710190054570.25221@racer.site>
X-Enigmail-Version: 0.95.3
X-OriginalArrivalTime: 19 Oct 2007 00:22:44.0400 (UTC) FILETIME=[2B242B00:01C811E6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61581>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 18 Oct 2007, Pete/Piet Delaney wrote:
> 
>> Johannes:
>>   I read somewhere in the past week that it was possible to maintain
>>   our existing CVS environment with git. I though it was a separate
>>   package to export git back to cvs but I just noticed a git-cvsserver
>>   and as a std part of git and was wondering about using that.
> 
> Where did you read that?
Don't recall exactly, I thought it was a page like the one showing
git Related tools but didn't find it today when looking for it.



>                           AFAIK git-cvsserver is one option.  The other is 
> cvsexportcommit.  The former is more appropriate if you want to switch the 
> developers over to git, and want to provide a smooth path for the devs (or 
> cannot convert a few hardcore CVS "fans").
> 
> The latter is appropriate if you cannot control the server side, or are 
> not allowed to switch to CVS.

I've got root access on the CVS server and want to switch to git without
disturbing the environment more than is necessary to make the switch.
I think developers will want to us git and git-cvsserver looks like
the more likely desirable path.

> 
>> We have a number of build machines with flamebox perl scripts pulling 
>> out CVS branches for builds. I was wondering what is the best way to use 
>> git and it's nicer pull/push model and merge facility and possibly 
>> maintain CVS exports for scripts doing builds if possible the cvsweb and 
>> bonsai (CVS Query Form) that a number of engineers are currently using. 
> 
> I don't know how cvsweb copes with git-cvsserver, but I guess that there 
> will be no problem.
great.

> 
>> I started looking over out flamebox scripts with the intent up 
>> converting them over to git but I mentioned the git to cvs coexistence 
>> and we are wondering if that's a better route than upgrading the 
>> flamebox scripts. Having our existing cvsweb, bonsai, and gitweb along 
>> with the git utilities seems at least desirable. Any thoughts or 
>> suggestions?
> 
> My suggestion: if you're fine with CVS, stick with it.  Really.  I am not 
> here to teach the whole world about the advantages of git, so by all 
> means, if you yourself do not find any advantage to using git, don't use 
> it.  Stick with what works for you.

We are definitely not fine with CVS, the branch merging isn't
comfortable. I'm just wondering about maintaining the existing
CVS browsers and the build scripts if it's not a big deal. I'll
try the git-cvsserver path. If anyone has any war stories to share
on the path this would be an ideal time to share them.

- -piet


> 
> Ciao,
> Dscho
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHF/jPJICwm/rv3hoRAkXgAJ9pa/DHxka926i3FHqYTsxCb5kzcQCeKiSk
j/Paxc6tJemOPK0TV8MhFGs=
=ut2Q
-----END PGP SIGNATURE-----
