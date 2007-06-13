From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Any way to ignore a change to a tracked file when committing/merging?
Date: Wed, 13 Jun 2007 20:30:55 +0200
Message-ID: <200706132030.55972.robin.rosenberg.lists@dewire.com>
References: <A30E217A-084E-4019-949F-5918EAA6368E@mimvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Watson <dwatson@mimvista.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 20:30:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyXbo-0008Tq-1L
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 20:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757783AbXFMSaS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 14:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758657AbXFMSaR
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 14:30:17 -0400
Received: from [83.140.172.130] ([83.140.172.130]:27583 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757783AbXFMSaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 14:30:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DAB81802650;
	Wed, 13 Jun 2007 20:23:36 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04868-01; Wed, 13 Jun 2007 20:23:36 +0200 (CEST)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 82E04800784;
	Wed, 13 Jun 2007 20:23:36 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <A30E217A-084E-4019-949F-5918EAA6368E@mimvista.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50110>

onsdag 13 juni 2007 skrev David Watson:
> I've got a problem, or maybe annoyance is more the proper term, that  
> I haven't seen solved by any SCM system (at least not to my  
> knowledge). Basically, I may make some changes, e.g. to a Makefile or  
> somesuch, that I want to ignore when looking at what's changed from  
> the repository. The only problem is, the file I've modified is  
> already under version control, so .gitignore doesn't do anything.
> 
> Now, I can commit it, so it will stop bugging me, but then when I  
> push out it will include that change, unless I back it out. This is a  
> change that I don't want propagated anywhere else, because it's  
> specific to my machine or development sandbox.
> 
> Is there any way to do this? I'd really love to use git-commit -a in  
> this situation, and I could hack up a script to undo my change, run  
> git-commit -a, and reapply the change, but makes me a bit squirmy. If  
> I could put something in a .git config file to say "commit 237ab  
> should not be propagated under any circumstances", that would be  
> fantastic.

git update-index --assume-unchanged <path>

Then commit -a like you are used to.

-- robin
