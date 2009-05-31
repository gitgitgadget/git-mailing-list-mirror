From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: Resetting working files
Date: Sun, 31 May 2009 17:00:42 +0200
Message-ID: <4A229B9A.6060807@dirk.my1.cc>
References: <DA26600008CE404B831978F6EBB31C6B@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Sun May 31 17:00:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAmWr-0004k0-Df
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 17:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265AbZEaPAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 11:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753028AbZEaPAn
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 11:00:43 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.27]:40017 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbZEaPAn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 11:00:43 -0400
Received: from [84.176.123.204] (helo=[192.168.2.100])
	by smtprelay04.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1MAmWQ-0001tM-Hc; Sun, 31 May 2009 17:00:26 +0200
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <DA26600008CE404B831978F6EBB31C6B@HPLAPTOP>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120402>

Am 31.05.2009 15:09 schrieb Aaron Gray:
> Hi,
> 
> How do I reset the working files back to HEAD ?
> 
> Many thanks,
> 
> Aaron
> 

$ git reset --hard

This will revert all changes you made in your working tree back to the 
HEAD. It will delete your changes made so far. To revert only a single 
file, use

$ git checkout -- path/to/file
