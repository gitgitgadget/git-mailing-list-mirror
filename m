From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: git tag --no-merged?
Date: Thu, 5 Feb 2015 10:09:23 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1502051001090.10655@ds9.cixit.se>
References: <alpine.DEB.2.00.1502041615110.30476@ds9.cixit.se> <6A0F0356-2AF1-487D-A20E-FB6051D9E689@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 10:09:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJIRN-000718-8n
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 10:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756203AbbBEJJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 04:09:31 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:52503 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752911AbbBEJJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 04:09:29 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id t1599Opc011984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 5 Feb 2015 10:09:24 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id t1599Nu6011979;
	Thu, 5 Feb 2015 10:09:23 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <6A0F0356-2AF1-487D-A20E-FB6051D9E689@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Thu, 05 Feb 2015 10:09:24 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263368>

Kyle J. McKay:

> I think something like this might do what you want:
>
> git for-each-ref --format='%(refname)' refs/tags | \
> while read t; do
> if ! git merge-base --is-ancestor $t HEAD; then
>   echo ${t#refs/tags/}
> fi
> done

That works like a charm, thank you!

-- 
\\// Peter - http://www.softwolves.pp.se/
