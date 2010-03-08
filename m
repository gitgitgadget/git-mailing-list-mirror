From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: sub module branches
Date: Mon, 8 Mar 2010 14:05:31 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1003081403110.30270@ds9.cixit.se>
References: <b42431c81003080314j694114b5o433988470f13328a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 14:05:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoceV-000899-Lv
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 14:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab0CHNFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 08:05:39 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:41082 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752121Ab0CHNFh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 08:05:37 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o28D5VjF014384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 8 Mar 2010 14:05:31 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o28D5V9K014380;
	Mon, 8 Mar 2010 14:05:31 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <b42431c81003080314j694114b5o433988470f13328a@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Mon, 08 Mar 2010 14:05:31 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141765>

Mahesh Vaidya:

> If I create branch in source, will it propogate to remaining submodules ?

No, the branch is only created in the top-level module.

> or in other words can I have "global branch" and "global tag"

The branch is "global" in the way that it does contain a reference to the 
current commit of the submodule. You do not *need* to have a local branch 
in the submodule to change where it pointed to from the top-level module. It 
does help to have it, though, as you eventually probably will want to push 
your changes somewhere, and then you need to have a symbolic reference in 
the submodule(s) you have branched as well.

-- 
\\// Peter - http://www.softwolves.pp.se/
