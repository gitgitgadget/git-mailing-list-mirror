From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: serving git with both "git:" and "http:" and submodules
Date: Thu, 15 Jul 2010 07:46:25 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1007150745340.13735@perkele.intern.softwolves.pp.se>
References: <4C3DD7EF.6010805@panasas.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 08:46:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZIDR-0002Ax-DQ
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 08:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884Ab0GOGqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 02:46:32 -0400
Received: from smtp.getmail.no ([84.208.15.66]:37951 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160Ab0GOGqc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 02:46:32 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5L00HGO6TEYE70@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 15 Jul 2010 08:46:26 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 40F101EA57FF_C3EAEC2B	for <git@vger.kernel.org>; Thu,
 15 Jul 2010 06:46:26 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id F2F301EA2876_C3EAEC1F	for <git@vger.kernel.org>; Thu,
 15 Jul 2010 06:46:25 +0000 (GMT)
Received: from perkele ([84.215.142.63]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5L0024H6TDEO20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 15 Jul 2010 08:46:25 +0200 (MEST)
Received: by perkele (Postfix, from userid 501)	id C88B92FBF1; Thu,
 15 Jul 2010 08:46:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id C40432FBEF; Thu, 15 Jul 2010 07:46:25 +0100 (CET)
In-reply-to: <4C3DD7EF.6010805@panasas.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151047>

Boaz Harrosh:

> [submodule "sub"]
>        url = git://my-domain.org/my-tree/sub/.git

> So my question is: Can I automate this so people with "http:" clones are 
> not forced to manually edit their config files?

You should be able to use a relative URL in .gitmodules, something like this 
should work:

[submodule "sub"]
        url = ../sub/.git

-- 
\\// Peter - http://www.softwolves.pp.se/
