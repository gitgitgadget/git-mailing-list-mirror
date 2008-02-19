From: Jon Loeliger <jdl@freescale.com>
Subject: Re: cant get git to work over http
Date: Tue, 19 Feb 2008 12:24:00 -0600
Message-ID: <47BB1EC0.601@freescale.com>
References: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com>	 <20080219063937.GB3819@glandium.org>	 <e26d18e40802182309l693b2099wb42573aca7348091@mail.gmail.com>	 <alpine.LSU.1.00.0802191115440.30505@racer.site> <e26d18e40802191019j48a1ceadk4887ffc35100ab0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Anatoly Yakovenko <aeyakovenko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 19:25:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRX9U-0005V7-Mp
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 19:25:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbYBSSYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 13:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbYBSSYf
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 13:24:35 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:59435 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbYBSSYe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 13:24:34 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m1JIO1Lc026217;
	Tue, 19 Feb 2008 11:24:01 -0700 (MST)
Received: from [10.214.72.212] (mvp-10-214-72-212.am.freescale.net [10.214.72.212])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m1JIO0cX013940;
	Tue, 19 Feb 2008 12:24:00 -0600 (CST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <e26d18e40802191019j48a1ceadk4887ffc35100ab0a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74442>

Anatoly Yakovenko wrote:
>>> $ git-pull
>>> fatal: 'origin': unable to chdir or not a git archive
>>> fatal: The remote end hung up unexpectedly
>> Since you did not clone from anywhere, the remote "origin" is not set.
>> You will have to do that yourself:
>>
>>         git remote add -f origin http://aeyakovenko@myserver.com/git/repo/
> 
> Thanks, that worked.  but push still gives me an error:
> 
> $ git pull
> You asked me to pull without telling me which branch you
> want to merge with, and 'branch.master.merge' in
> your configuration file does not tell me either.  Please
> name which branch you want to merge on the command line and
> try again (e.g. 'git pull <repository> <refspec>').
> See git-pull(1) for details on the refspec.
> 
> If you often merge with the same branch, you may want to
> configure the following variables in your configuration
> file:
> 
>     branch.master.remote = <nickname>
>     branch.master.merge = <remote-ref>
>     remote.<nickname>.url = <url>
>     remote.<nickname>.fetch = <refspec>
> 
> See git-config(1) for details

Did you follow this advice?  You've set up the
origin's URL now, and so it knows from where the
fetch step will happen, but have you set up the
merge step yet?  Does it know what branches to
merge on that pull request?

jdl
