From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Confusing error message in rebase when commit becomes empty
Date: Wed, 11 Jun 2014 18:57:10 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1406111854180.21431@ds9.cixit.se>
References: <alpine.DEB.2.00.1406111321090.6307@ds9.cixit.se> <CABURp0rC3yktDiRVQwo9E+x5_wKLnLVRx87ej+m+TyUdBkMpOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 19:57:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wumm0-0003iS-LW
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 19:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbaFKR5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 13:57:16 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:48322 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753009AbaFKR5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 13:57:16 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s5BHvBrN021522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 11 Jun 2014 19:57:11 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s5BHvAkN021519;
	Wed, 11 Jun 2014 19:57:10 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <CABURp0rC3yktDiRVQwo9E+x5_wKLnLVRx87ej+m+TyUdBkMpOA@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Wed, 11 Jun 2014 19:57:11 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251374>

Phil Hord:

> What does it mean when you say it worked as expected?  Did it leave
> the empty commit, omit the empty commit, or leave some un-squashed
> commit?

Actually, it did not work as expected I noted afterward, it just 
dropped the reversion commit, and did not squash the next commit into 
it as I had asked, so from three commits, "change", "revert", 
"new-change" I had two, "change", "new-change" with the end result 
being the same (i.e., instead of squashing all three into one 
"new-change", I had "change" and "revert" + "new-change").

> It's not clear to me what --continue _should_ do in this 
> case, but it does seem like the two options here should be

I sort of expect a squashed commit of "change" + "revert" to be an 
empty commit, and of "change" + "revert" + "new-change" to be a commit 
of "new-change".

-- 
\\// Peter - http://www.softwolves.pp.se/
