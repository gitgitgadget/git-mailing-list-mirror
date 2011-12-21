From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Rewriting history and public-private-ish branches
Date: Wed, 21 Dec 2011 13:58:26 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1112211356480.17957@ds9.cixit.se>
References: <4EF08086.6080606@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jay Levitt <jay.levitt@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 14:05:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdLrC-0007rL-8Y
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 14:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab1LUNFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 08:05:08 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:46744 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752613Ab1LUNFF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 08:05:05 -0500
X-Greylist: delayed 627 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Dec 2011 08:05:04 EST
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id pBLCwQ0I031483
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 21 Dec 2011 13:58:26 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id pBLCwQXB031480;
	Wed, 21 Dec 2011 13:58:26 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <4EF08086.6080606@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 21 Dec 2011 13:58:26 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187562>

Jay Levitt:

> As long as I'm the only one who's seen this "published" history, am I doing 
> anything bad?

I do things like that too, and as long as you know what you are doing, it 
usually works fine.

> Do I leave any residue behind in the repo?

As long as you run "git gc" on the repos regularly, it shouldn't really 
matter much. Your abandoned changes will be available through the reflog 
until that expires, and when that has happened "git gc" should remove them 
from the repositories altogether.

-- 
\\// Peter - http://www.softwolves.pp.se/
