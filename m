From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Interactive rebase with pre-built script?
Date: Thu, 13 Sep 2012 14:33:46 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1209131431580.20765@ds9.cixit.se>
References: <alpine.DEB.2.00.1209110725130.8398@ds9.cixit.se> <5050BA90.2010105@sohovfx.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Andrew Wong <andrew.w-lists@sohovfx.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 15:34:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TC9YP-0005SV-5m
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 15:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190Ab2IMNdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 09:33:53 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:46292 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752593Ab2IMNdw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 09:33:52 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id q8DDXl6Z022858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Sep 2012 15:33:47 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id q8DDXkhK022853;
	Thu, 13 Sep 2012 15:33:47 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <5050BA90.2010105@sohovfx.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Thu, 13 Sep 2012 15:33:47 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205372>

Andrew Wong:

> Instead of rebasing to "HEAD~", you should be able to do:
>    git rebase -i HEAD

Would you look at that, that actually works. So much for not testing 
that. Thanks, that makes it a lot easier.

> Instead of appending your own recipe, you could also abuse the EDITOR 
> environment variable.
> Say your recipe is stored in a file called "my_recipe". Then, you could do 
> this:
>    env EDITOR="cp my_recipe" git rebase -i HEAD
>
> But this could potentially be dangerous because if "rebase" fires up a editor 
> for any other reason (e.g. having a "reword" or "squash" in your recipe), 
> then the commit message will be messed up. So you need to make sure your 
> recipe won't trigger any editor except for the recipe.

Indeed, that's why I don't want to do that.

Perhaps I should add some switch that would append the contents of a 
specific file to the prebuild recipe, I guess that should be fairly 
easy. The question is what to call the switch.

-- 
\\// Peter - http://www.softwolves.pp.se/
