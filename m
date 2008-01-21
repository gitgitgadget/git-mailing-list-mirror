From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: Importing merges when converting repos from SVN to Git
Date: Mon, 21 Jan 2008 19:36:07 +0100
Message-ID: <A35436D5-71EA-4185-BBC1-4ECCE4D63A0E@lrde.epita.fr>
References: <744EF0AD-4773-4A35-B772-94621E9ADA10@lrde.epita.fr> <47839311.2010606@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 19:37:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH1W5-0007cv-Cc
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 19:37:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258AbYAUSgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 13:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbYAUSgY
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 13:36:24 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:38831 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258AbYAUSgT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 13:36:19 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1JH1VK-0008Ff-35
	for git@vger.kernel.org; Mon, 21 Jan 2008 19:36:18 +0100
In-Reply-To: <47839311.2010606@viscovery.net>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71306>

Hi people,
I wrote a script (svn-merge2git [1]) that helps to convert SVN merges  
to Git merges.  The script basically detects the merges from their  
commit message and re-create them properly on the Git side.  It took  
me several iterations to get it right but it eventually successfully  
converted a SVN repo with ~2500 revisions in a dozen of branches with  
~100 merges in between them.  The script can be used when one wants  
to entirely convert a SVN repo to a Git one while preserving the  
merges (that is, showing the merges in the Git history).  I guess it  
can also be used to inject merges in the history of a git-svn repo to  
facilitate merging of SVN branches with Git, although I haven't had  
time to experiment this for now.

I hope this will be helpful to others.

[1] Code and explanations at: http://repo.or.cz/w/svn-merge2git.git

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory
