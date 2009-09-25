From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 7/9] removing eclipse project files
Date: Fri, 25 Sep 2009 23:40:07 +0200
Message-ID: <200909252340.07363.robin.rosenberg.lists@dewire.com>
References: <314006.37617.qm@web27808.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>, git@vger.kernel.org,
	spearce@spearce.org
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Fri Sep 25 23:40:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrIWZ-0007v3-Sq
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 23:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbZIYVkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 17:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbZIYVkG
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 17:40:06 -0400
Received: from mail.dewire.com ([83.140.172.130]:16096 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535AbZIYVkF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 17:40:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 92E4E147DB42;
	Fri, 25 Sep 2009 23:40:08 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fv7qxeYZee9V; Fri, 25 Sep 2009 23:40:08 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 133B1147DB30;
	Fri, 25 Sep 2009 23:40:08 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <314006.37617.qm@web27808.mail.ukl.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129122>

torsdag 24 september 2009 08:55:16 skrev Mark Struberg <struberg@yahoo.de>:
> Hi Ferry!
> 
> I work on a lot of projects and having eclipse (or any other IDEs) project files in the SCM is almost ever causing a problem. In praxis those files are always dirty. There are so many settings which may be different from user to user
> 
> * different versions of eclipse create different project settings
> * different JVM settings
> * changing profiler settings
> * using different version of various plugins
> etc, etc
> 
> And with maven in place we don't need to have them in our SCM anymore. Plus: it works for a lot of IDEs
> 
> You can easily create the project files for a few IDEs with maven e.g.:
> $> mvn eclipse:eclipse   for creating the eclipse project files
> $> mvn idea:idea         for creating the idea project files
> 
> Additionally, plugins are available for Eclipse [1], Intellij Idea (native, builtin) and NetBeans (native, builtin).
> 
> So most of the time it is enough to simply import the parent pom.xml and you get all things setup properly in your IDE.

I want compiler warnings/error and formatting settings to be enforced. Until recently we had roughly zero problems with non-confirming submissions

Is there some means for this, even if that would mean having access to only
a subset of possible settings. Maybe using checkstyle would do it for the
style checks. Not sure how we'd control formatting.

-- robin
