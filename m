From: "J.H." <warthog9@kernel.org>
Subject: [Gitweb-caching][RFC] Major updates - kernel.org updated
Date: Wed, 07 Oct 2009 21:51:57 -0700
Message-ID: <4ACD6FED.4080308@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 08 07:24:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvlUF-0006FQ-9x
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 07:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbZJHFU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 01:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbZJHFU3
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 01:20:29 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:40953 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbZJHFU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 01:20:28 -0400
X-Greylist: delayed 1675 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Oct 2009 01:20:28 EDT
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id n984pviV006730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 7 Oct 2009 21:51:57 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/9873/Wed Oct  7 14:05:47 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Wed, 07 Oct 2009 21:51:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129673>

Evening everyone,

Thought I'd give a heads up that I finally sat down and did some major 
updates to my version of the gitweb caching code (as opposed to Lea's, 
which I still have plans to integrate with mine in the near future).

That said this brings the base up to mainline, which is about a 2 or 3 
year jump in code, it updates a number of elements in the caching engine 
  itself and I went ahead and ripped out the file breakout that I had 
done initially.

New things known to work:
	- Snapshots are fully working, and passing through the caching
	  engine
	- Binary files now output correctly when your using blob_plain,
	  this is also passing correctly through the caching engine.

I'm sure there is a plethora of other things that have been fixed or broken.

So I'm going to re-open the can of worms over caching again, and see 
what it would take to get this merged into mainline.  Obviously a patch 
clean-up (my tree is a lot more organic than mainline) is needed, but I 
thought I'd try and get an idea of where I need to start steering all of 
this.

- John 'Warthog9' Hawley
