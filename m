From: Steven Walter <stevenrwalter@gmail.com>
Subject: git-write-tree strangeness
Date: Wed, 8 Aug 2007 11:42:11 -0400
Message-ID: <20070808154211.GA25015@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 17:42:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIng2-0005yW-0z
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 17:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772AbXHHPmP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 11:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755140AbXHHPmP
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 11:42:15 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:48549 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345AbXHHPmO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 11:42:14 -0400
Received: by py-out-1112.google.com with SMTP id d32so328638pye
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 08:42:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=UXfh8iFwrdIec321w5rl3Kd5tHzNHa3KjzTS81qKxBXevnGuGZ/SJ4ceyXLM7idRfs7xyWztJC599PNREaaGwkLH0Qs2RmRIu6jmx2TPbK0+a8CMumVkHW8C14Rjez/pnPRWHE9PhgOGYlelt3jAUrG/2/mxRk/CTDwRPzBP6AE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=n27BfjL80OV/OeyzdKefKQIM4cKQIXJVCOKsXNv7ob9abvs/iPo9VmVWzncGUTsucK7oZVU59URJUJauSdRPYOQVyNFxGg7W7cZVXEpY/oqXxN1mz78z2iwPV5iBVMUnZ0sHNdwW8+wI5vfOTNqNFsMmlw1bgMqHA9msqXYq79Q=
Received: by 10.35.121.12 with SMTP id y12mr1709248pym.1186587733627;
        Wed, 08 Aug 2007 08:42:13 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [74.131.26.80])
        by mx.google.com with ESMTPS id v56sm1240880pyh.2007.08.08.08.42.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Aug 2007 08:42:13 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 779DECBE6CD; Wed,  8 Aug 2007 11:42:11 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55327>

I'm importing a large repository from svn into git with a custom tool,
and I noticed a strange issue with one of the commits.

Upon investigating further, I found that when I ran "git-write-tree"
followed immediately by "git-diff-index <tree>" I had differences.  Does
that mean that git-write-tree incorrectly recorded the index, or do I
misunderstand things?

I just wanted to verify that I have at least some clue what is going on
before I dig too much deeper into this issue.  I'm running
git-1.5.3-rc4; I'll see if it occurs with 1.5.2 and bisect if not.
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
   -Robert Heinlein
