From: Andreas Ericsson <ae@op5.se>
Subject: Re: managing git submodules with git-svn
Date: Wed, 20 Aug 2008 14:49:04 +0200
Message-ID: <48AC12C0.1090303@op5.se>
References: <48ABE568.80106@calicojack.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rick Moynihan <rick@calicojack.co.uk>
X-From: git-owner@vger.kernel.org Wed Aug 20 14:50:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVn8i-0006Ct-Qv
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 14:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbYHTMtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 08:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753842AbYHTMtJ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 08:49:09 -0400
Received: from mail.op5.se ([193.201.96.20]:43381 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752931AbYHTMtI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 08:49:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 684D21B80409;
	Wed, 20 Aug 2008 14:53:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9UAWbcUApzI2; Wed, 20 Aug 2008 14:53:05 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.184])
	by mail.op5.se (Postfix) with ESMTP id C762C1B8037E;
	Wed, 20 Aug 2008 14:53:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <48ABE568.80106@calicojack.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92985>

Rick Moynihan wrote:
> Hi all,
> 
> We are currently using a mixture of git and svn to manage a project with 
> an array of subprojects.  We use git primarily for its excellent 
> branching and merging support, and as a means of more effectively 
> managing commits etc...  We're not yet ready to make the leap entirely 
> to git and find subversion still has a role, primarily due to some 3rd 
> party upstream (e.g. Apache) projects using svn.  SVN is also better 
> supported by some of our tools/systems.
> 
> Our project is made up of a number of subprojects, and I'd like to use 
> git submodules to easily track and lock changes in component versions. 
> git submodules appear to do exactly this, versioning the meta-repo with 
> each subproject locked at a specific commit/SHA-1.
> 
> My question is; is there anyway to easily do this but have git use 
> git-svn manage the submodule?  I think this makes sense and suspect it 
> would be possible to do, though it looks like it's currently not a 
> feature.  Is this a feature anyone else would find useful?
> 

Off the top of my head, just point your submodule to the incremental
git-svn import of the upstream repository and you're good to go.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
