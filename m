From: Duncan Ferguson <duncan_j_ferguson@yahoo.co.uk>
Subject: Re: git-svn and sharing a single subversion repo to multiple clients
Date: Thu, 18 Feb 2010 11:35:35 +0000
Message-ID: <57FF41CA-18CF-40B9-B443-7A5D589EFFEB@yahoo.co.uk>
References: <838B8633-E2B2-4833-BE09-5DCE9A13BBE1@yahoo.co.uk>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 12:35:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni4fY-0005an-T2
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 12:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757476Ab0BRLfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 06:35:39 -0500
Received: from smtp130.mail.ukl.yahoo.com ([77.238.184.61]:36425 "HELO
	smtp130.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753580Ab0BRLfi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 06:35:38 -0500
Received: (qmail 96628 invoked from network); 18 Feb 2010 11:35:36 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Received:X-Yahoo-SMTP:X-YMail-OSG:X-Yahoo-Newman-Property:References:In-Reply-To:Mime-Version:Content-Type:Message-Id:Content-Transfer-Encoding:From:Subject:Date:To:X-Mailer;
  b=paaJHw66Jy52hprgTcMfjxuES7IqQTLNGfEFQLwfQLjFi4BaHRpZxK96mzrngk+KDfbu1IRylMXMpHeGtXyJddJrI2/HM/f0Yk8ry9fkEMHUSW73DAv9zZg4/9k20kFacZDSu06Nl0nCbmQNYQoCUXTEyoS1dxcEZqmOX41SvVE=  ;
Received: from cpc2-dudl1-0-0-cust759.wolv.cable.virginmedia.com (duncan_j_ferguson@82.37.66.248 with plain)
        by smtp130.mail.ukl.yahoo.com with SMTP; 18 Feb 2010 11:35:36 +0000 GMT
X-Yahoo-SMTP: XvxsLIaswBDKFd9O7cZyiXj2RzudnBbDLrAPZzQs
X-YMail-OSG: CMF3KP8VM1ltNJV.oomhMLfQfxmkNJ_2b1IRco4..OirZpt3fDAaOjO1ANVuuU9HZQ0GuX4zrDl.cia2OVPZtAgdwBItUAlu7rc2MUMDrrA8FHdPnWziMZIQaTL9yEaX1IwyGE1nhbDRjxIGztUa5Bs_HLMgMK3YXHfu9LEZT2o7xauiKDoJ4xY5RKaHtrxEDpgJRhFtmIJQunWOWg9ReRa4BQdrwXiFpzMhH8AbHgkMbJJQMNerwIY_hYTyw_dxUx4mfhuWDF9sjG.4pGvLN37gP7RJDlX78Qo-
X-Yahoo-Newman-Property: ymail-3
In-Reply-To: <838B8633-E2B2-4833-BE09-5DCE9A13BBE1@yahoo.co.uk>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140319>


On 12 Feb 2010, at 08:13, Duncan Ferguson wrote:
> 
> The git-svn man page has a section on setting up a single git-svn repository and sharing it out so multiple clients can then clone it (in the section in 'BASIC EXAMPLES', starting at "The initial git-svn clone can be quite time-consuming ....").
> 
> I have tried following this but it does not work for me on 1.6.3.3
> 
> My situation is my company has a subversion repository that takes a significant amount of time to git-svn clone (many hours) due to the length of time its been used.  I work across a number of dev servers all using the same single subversion repo and dev servers are semi-regularly rebuilt.  I'd like to check out the subversion repo once on a 'stable' server and then git clone it to all the dev servers to speed up creating a new dev server (and reduce disk space), but also be able to pull any new subversion commits and also push new commits back.
> 
> What is the best/correct way of setting this up as I cannot find any other docs apart from the section in the git-svn man page that doesn't work?

For anyone else looking to do this I found some details on the wiki at: http://git.wiki.kernel.org/index.php/GitFaq#How_do_I_mirror_a_SVN_repository_to_git.3F - the wiki was being moved when i first asked so I didn't find it then - and it appears to be struggling now...

  Duncs