From: Andreas Ericsson <ae@op5.se>
Subject: Re: Migration from CVS to GIT - Multiple directories in CVS repo
 to a single Git repo
Date: Wed, 22 Jun 2011 11:22:20 +0200
Message-ID: <4E01B44C.7090003@op5.se>
References: <1308733591425-6503493.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: sandy2010 <sandeeptt@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 11:22:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZJdm-0000RP-8e
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 11:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447Ab1FVJWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 05:22:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42108 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484Ab1FVJWY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 05:22:24 -0400
Received: by fxm17 with SMTP id 17so494938fxm.19
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 02:22:22 -0700 (PDT)
Received: by 10.223.143.17 with SMTP id s17mr583503fau.34.1308734542716;
        Wed, 22 Jun 2011 02:22:22 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id r10sm195992fah.26.2011.06.22.02.22.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Jun 2011 02:22:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10 ThunderGit/0.1a
In-Reply-To: <1308733591425-6503493.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176229>

On 06/22/2011 11:06 AM, sandy2010 wrote:
> Hello,
> 
> I'm aware of cvs2git and git fast-import utilities to do this. My
> requirement is little different.
> My CVS Repo is:
> /cvs/BFARM
> 
> This consists of following directories:
> Misc/suite1
> Misc/suite2
> Misc/suite3
> 
> Now, I want to Migrate the suite1 and suite2 into a single Git repo
> "/git/Testsuites" and it should look like this:
> /git/Testsuites/suite1
> /git/Testsuites/suite2
> 
> How can I do this? I do not want to make suite1 and suite2 as separate git
> repos.
> 

Make a single repository out of them first, and then look at
git-filter-branch to create separate repositories for them.
You'll want to use the tree-filter option.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
