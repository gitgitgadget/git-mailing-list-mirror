From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] import-tars: Make it possible to include the original
 commit ID
Date: Fri, 19 Feb 2010 09:12:29 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1002190911140.5644@ds9.cixit.se>
References: <20100218132709.8CEBA2FC07@perkele> <1266505333-20286-1-git-send-email-g2p.code@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Gabriel <g2p.code@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 09:12:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiNyZ-00031s-2b
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 09:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795Ab0BSIMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 03:12:34 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:37447 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754789Ab0BSIMd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 03:12:33 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o1J8CTvx014102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 19 Feb 2010 09:12:29 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o1J8CT6G014098;
	Fri, 19 Feb 2010 09:12:29 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1266505333-20286-1-git-send-email-g2p.code@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Fri, 19 Feb 2010 09:12:30 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140431>

Gabriel:

> A small correction; when both --readpax and --metainfo=msg are passed, 
> incorporate both message and original sha1. I amended your commit.

My initial thought was to let have the --metainfo message override the 
auto-generated message in its entirety, but I have no strong feelings either 
way, so i am OK with this change.

-- 
\\// Peter - http://www.softwolves.pp.se/
