From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 7/9] removing eclipse project files
Date: Fri, 25 Sep 2009 23:17:01 +0200
Message-ID: <200909252317.02296.robin.rosenberg.lists@dewire.com>
References: <212350.78171.qm@web27802.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: MatthiasSohn <matthias.sohn@sap.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"spearce@spearce.org" <spearce@spearce.org>
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Fri Sep 25 23:17:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrIAD-0001Uj-MZ
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 23:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbZIYVRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 17:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbZIYVRC
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 17:17:02 -0400
Received: from mail.dewire.com ([83.140.172.130]:15785 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534AbZIYVRB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 17:17:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E72FF147DB28;
	Fri, 25 Sep 2009 23:17:03 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YFp7CAzoby6s; Fri, 25 Sep 2009 23:17:03 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 41A91139D880;
	Fri, 25 Sep 2009 23:17:02 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <212350.78171.qm@web27802.mail.ukl.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129115>

torsdag 24 september 2009 13:50:11 skrev Mark Struberg <struberg@yahoo.de>:
> Hi Matthias!
> 
> the answer is a clear yes and no  - a 'jein' for german speaking people like you ;)
> 
> yes: we have the same settings for the compiler as used before: jdk 1.5 for source and target. This is exactly what has been taken in the ant build which was used prior to maven. 
>
> Please note that the settings in org.eclipse.jdt.core.prefs never had (and must not have) any impact on the created jar!

Not sure what ant files you are referring to here and which jars. The plugins downloadable from jgit.org has been built using PDE build. so some of the .settings should affect the compiler and thus the generated jars.

> and no: currently the very file you mentioned contains a lot more stuff. In fact most of this are only editor settings, preferred formattings etc which has nothing to do with the build per se. Eclipse has the ability to import/export all those settings in a XML file which is version independent. We should go this way and also supply similar setting-files for Idea and NetBeans. But forcing those settings via an internal Eclipse plugin config file is imho bad practice.

That way is awkward and people to import the settings and screw them up in their workspaces. I've made the projects I'm involved use .settings and make different settings mostly a non-issue because everyone gets new
settings automatically as they change. Prior to eclipse 3.3 sharing settings was a big problem, but It's not a big deal nowadays. The most annoying thing is that some settings are not available as project specific settings. 

We use 3.3 (well I think the last user dropped it recently), 3.4 and 3.5. I often have to fix up new projects but that is typically a one-time per eclipse project problem. (typically the JRE gets bound to a specific install location).

The .launch files is another story since they change format all the time.

-- robin
