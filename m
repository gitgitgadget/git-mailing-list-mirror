From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: Re: help needed: Splitting a git repository after subversion migration
Date: Wed, 10 Dec 2008 17:33:28 +0100
Organization: Intra2net AG
Message-ID: <200812101733.36221.thomas.jarosch@intra2net.com>
References: <493C0AAD.1040208@intra2net.com> <20081208142447.GA20186@atjola.homenet> <200812081834.26688.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 10 17:59:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LASP9-00025x-0F
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 17:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580AbYLJQ6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 11:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755576AbYLJQ6A
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 11:58:00 -0500
Received: from rs02.intra2net.com ([81.169.173.116]:60125 "EHLO
	rs02.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755575AbYLJQ6A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 11:58:00 -0500
X-Greylist: delayed 1457 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Dec 2008 11:57:59 EST
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rs02.intra2net.com (Postfix) with ESMTP id E16D84C6F;
	Wed, 10 Dec 2008 17:33:40 +0100 (CET)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id 6820D2AC52;
	Wed, 10 Dec 2008 17:33:40 +0100 (CET)
Received: from storm.localnet (storm.m.i2n [172.16.1.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id 67CCA2AC51;
	Wed, 10 Dec 2008 17:33:39 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27.5-41.fc9.i686; KDE/4.1.3; i686; ; )
In-Reply-To: <200812081834.26688.thomas.jarosch@intra2net.com>
Content-Disposition: inline
X-Virus-Scanned: by Intranator (www.intranator.com) with AMaViS and F-Secure AntiVirus (fsavdb 2008-12-10_06)
X-Spam-Status: hits=-4.1 tests=[ALL_TRUSTED=-1.8,BAYES_00=-2.312]
X-Spam-Level: 959
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102698>

On Monday, 8. December 2008 18:34:20 Thomas Jarosch wrote:
> 1. When I run "git rev-list --all --objects", I can see file names that
> look like "SVN-branchname/directory/filename". Is it normal that "git svn"
> creates a directory with the name of the branch and puts files below it?

Ok, this seems to be a PEBKAC: In the history of the subversion repository, 
f.e. I once copied the "branches" root folder to tags/xyz. One revision later 
I noticed this and retagged the correct branch. git-svn imports all branches
from the first tag, which is the correct thing to do :o)

Now I'll manually check the history of the tags/ and branches/ folder
for more funny tags and write down the revision. If I understood
the git-svn man page correctly, I should be able to specifiy
revision ranges it's going to import. I'll try to skip the broken tags.

Cheers,
Thomas
