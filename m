From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] import-tars: properly import git-archive tarballs
Date: Thu, 18 Feb 2010 10:40:13 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1002181037340.11095@ds9.cixit.se>
References: <1266434452-14532-1-git-send-email-g2p.code@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Gabriel <g2p.code@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 10:40:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni2ry-0003XN-R1
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 10:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376Ab0BRJkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 04:40:21 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:51417 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753656Ab0BRJkS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 04:40:18 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o1I9eDxT019344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 Feb 2010 10:40:13 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o1I9eD2J019340;
	Thu, 18 Feb 2010 10:40:13 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1266434452-14532-1-git-send-email-g2p.code@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 18 Feb 2010 10:40:13 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140307>

Gabriel:

> git-archive adds a special entry to the archives it creates, 
> pax_global_header, containing the SHA1 of the exported commit.

Interesting use-case.

> Now import-tars correctly ignores the comment.

In the case where you actually would care, perhaps it should be added as a 
comment to the default commit message? Something like "Imported from 
$tar_file, created from commit $commit.".

-- 
\\// Peter - http://www.softwolves.pp.se/
