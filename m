From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Bug with rev-list --reverse?
Date: Thu, 18 Apr 2013 11:47:41 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1304181146090.30868@ds9.cixit.se>
References: <CAMP44s25mUA1M+K+YKaC=bz3Dr7kSDyXK5g2ot8i+1EPy8zRhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 12:57:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USmX3-0005jZ-Ku
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 12:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935515Ab3DRK5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 06:57:33 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:46866 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S935341Ab3DRK5c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 06:57:32 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Apr 2013 06:57:32 EDT
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id r3IAlg72011922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 Apr 2013 12:47:42 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id r3IAlf2m011919;
	Thu, 18 Apr 2013 12:47:41 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <CAMP44s25mUA1M+K+YKaC=bz3Dr7kSDyXK5g2ot8i+1EPy8zRhA@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Thu, 18 Apr 2013 12:47:42 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221647>

Felipe Contreras:

> % git log --oneline -1 v1.8.1.5^..v1.8.1.6
> % git log --oneline --reverse -1 v1.8.1.5^..v1.8.1.6
>
> I expect to get a different output, and not both showing v1.8.1.6.
> Wouldn't you agree?

  Quoting the manual page:

  Commit Limiting
    Besides specifying a range of commits that should be listed using the special notations explained in the description, additional commit limiting may be applied. Note that they are applied before commit ordering and formatting options, such as --reverse.

Given that, I would expect the output to be the same.

-- 
\\// Peter - http://www.softwolves.pp.se/
