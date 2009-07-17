From: Tommy Nordgren <tommy.nordgren@comhem.se>
Subject: Re: [ANNOUNCE] GIT 1.6.4.rc1
Date: Fri, 17 Jul 2009 17:16:02 +0200
Message-ID: <D205883B-CE07-4817-8F22-6071837945B5@comhem.se>
References: <7vmy75bg2f.fsf@alter.siamese.dyndns.org> <057D2A1F-0383-4AE4-A431-54D6C1F90D85@comhem.se> <e2b179460907160037t17e276fas8a713eff55bba7f3@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 17:40:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRpXY-0003Nt-9J
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 17:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbZGQPjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 11:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbZGQPjx
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 11:39:53 -0400
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:53933 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964800AbZGQPjx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2009 11:39:53 -0400
X-Greylist: delayed 1425 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jul 2009 11:39:52 EDT
Received: from c213-89-136-212.bredband.comhem.se ([213.89.136.212]:34116 helo=[192.168.0.4])
	by ch-smtp03.sth.basefarm.net with esmtp (Exim 4.69)
	(envelope-from <tommy.nordgren@comhem.se>)
	id 1MRpBq-0001GG-By; Fri, 17 Jul 2009 17:17:46 +0200
In-Reply-To: <e2b179460907160037t17e276fas8a713eff55bba7f3@mail.gmail.com>
X-Mailer: Apple Mail (2.935.3)
X-Originating-IP: 213.89.136.212
X-Scan-Result: No virus found in message 1MRpBq-0001GG-By.
X-Scan-Signature: ch-smtp03.sth.basefarm.net 1MRpBq-0001GG-By a75cff2b42d2f49131794b96cd96d6b9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123468>


On Jul 16, 2009, at 9:37 AM, Mike Ralphson wrote:

> 2009/7/16 Tommy Nordgren <tommy.nordgren@comhem.se>:
>> Testing a build of this version fails at a late stage, with an  
>> error that
>> aborts testing.
>> My system is Mac OS X 10.5.8
>> Fragment of output at failure:
>> *** t9200-git-cvsexportcommit.sh ***
>> ..snip
>> * FAIL 14: re-commit a removed filename which remains in CVS attic
>
> I posted a fix (well, a sticking plaster) for this yesterday. Could
> you confirm if this fixes it for you?
>
	The fix works 200 times out of 200
	The old version fails 58 times out of 200.
> http://article.gmane.org/gmane.comp.version-control.git/123317
>
> The issue is intermittent on AIX (and Junio has seen it as such on
> Linux too) so you may need to run the t9200... script a few times to
> verify all is ok.
>
> Thanks also for testing the rc, and the detailed report, very much
> appreciated by all I'm sure.
>
> If you can regularly build git.git snapshots, there are some scripts
> at http://repo.or.cz/w/git/gitbuild.git in the platform branch, and
> tags get pushed there describing the state of the build and tests on a
> few 'non-core' platforms.
>
> Cheers, Mike

----------------------------------
Skinheads are so tired of immigration, that they are going to move to  
a country that don't accept immigrants!
Tommy Nordgren
tommy.nordgren@comhem.se
