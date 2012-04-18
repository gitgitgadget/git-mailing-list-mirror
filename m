From: Rob Hoelz <rob@hoelz.ro>
Subject: Adding a new option to git-push: --(no-)create-branch
Date: Thu, 19 Apr 2012 00:03:17 +0200
Message-ID: <4F8F3A25.1080407@hoelz.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 00:10:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKd5D-0003KA-LC
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 00:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050Ab2DRWKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 18:10:35 -0400
Received: from hoelz.ro ([66.228.44.67]:47364 "EHLO mail.hoelz.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982Ab2DRWKe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 18:10:34 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Apr 2012 18:10:34 EDT
Received: from Robs-MacBook-Pro.local (a190145.upc-a.chello.nl [62.163.190.145])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.hoelz.ro (Postfix) with ESMTPSA id 1C7153435D
	for <git@vger.kernel.org>; Wed, 18 Apr 2012 18:03:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195913>

Hello Git developers and users,

When I use Git, I tend to specify my branches explicitly.  For example:

git push origin master:master

However, I will often make a typo like this:

git push origin master:msater

I was thinking that it would be nice for git to support a new 
option/config value: --no-create-branch (push.createbranch).  This 
configuration variable
would forbid git from creating new remote branches, unless overriden 
with --create-branch.

Does anyone think this would be worth implementing?  I'd like to take 
the pulse of the community before I start making any modifications.

Thanks,
Rob Hoelz
