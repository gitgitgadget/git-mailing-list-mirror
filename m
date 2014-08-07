From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH v2 02/23] rebase -i: allow squashing empty commits without
 complaints
Date: Thu, 7 Aug 2014 08:16:23 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1408070814230.18704@ds9.cixit.se>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com> <16751a4402233b6c2925bf00d7ecebdccedd0eef.1407368621.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 09:16:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFHwN-0005NY-Q6
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 09:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbaHGHQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 03:16:43 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:44779 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753145AbaHGHQm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 03:16:42 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s777GPCx019082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 7 Aug 2014 09:16:25 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s777GNbR019070;
	Thu, 7 Aug 2014 09:16:24 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <16751a4402233b6c2925bf00d7ecebdccedd0eef.1407368621.git.bafain@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Thu, 07 Aug 2014 09:16:25 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254946>

Fabian Ruch:

>>   2. Notice ourselves that the end-result of the whole squash is an
>>      empty commit, and stop to let the user deal with it.
>
> This patch chooses the second alternative. Either way seems OK. The 
> crucial consensus of the discussion was to silently throw away empty 
> interim commits.

Yes, the important part is that giving good advice is better than 
giving bad advice. Thank you for taking your time to fix this.

I haven't reviewed the changes themselves, but I am happy with the 
underlying idea.

-- 
\\// Peter - http://www.softwolves.pp.se/
