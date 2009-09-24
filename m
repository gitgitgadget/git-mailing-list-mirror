From: "Ferry Huberts" <ferry.huberts@pelagic.nl>
Subject: Re: [JGIT PATCH 7/9] removing eclipse project files
Date: Thu, 24 Sep 2009 09:57:21 +0200 (CEST)
Message-ID: <34819.77.61.241.211.1253779041.squirrel@hupie.xs4all.nl>
References: <314006.37617.qm@web27808.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Ferry Huberts" <ferry.huberts@pelagic.nl>, git@vger.kernel.org,
	spearce@spearce.org
To: "Mark Struberg" <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Thu Sep 24 09:57:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqjCk-0004Ic-1A
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 09:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbZIXH5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 03:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbZIXH5U
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 03:57:20 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:51834 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751387AbZIXH5T (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Sep 2009 03:57:19 -0400
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id 041FA58CFF4; Thu, 24 Sep 2009 09:57:21 +0200 (CEST)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Thu, 24 Sep 2009 09:57:21 +0200 (CEST)
In-Reply-To: <314006.37617.qm@web27808.mail.ukl.yahoo.com>
User-Agent: SquirrelMail/1.4.8-5.el5.centos.7
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129029>


> I work on a lot of projects and having eclipse (or any other IDEs) project files in the SCM is
> almost ever causing a problem. In praxis those files are always dirty. There are so many settings
> which may be different from user to user

true. however, those problems can easily be avoided by the
policy of not ever checking in those eclipse files unless
coordinated within the project.

we have many big java projects here internally and _do_ have
the eclipse settings in git. it makes life so much easier for
everyone to start work and we have many more settings in
there that we actually want enforced.

for example: we enforce a coding standard through eclipse
by automatically formatting the source code and organising
imports on file save. also, we want everybody to use the same
settings when cleaning up the code. we want them to use the
same findbugs settings, the same settings for xxx/yyy/....

> * different JVM settings

if specified correctly this is actually an advantage: you can
standardise your projects on a (minimum) JVM platform, like 1.5

> * using different version of various plugins

we see that as an advantage so that we can standardise the
development setup, or at least define some sort of minimum
setup


> You can easily create the project files for a few IDEs with maven e.g.:
> $> mvn eclipse:eclipse   for creating the eclipse project files
> $> mvn idea:idea         for creating the idea project files

I know, quite handy :-)

Think I have more questions now than before by discussing it :-)
