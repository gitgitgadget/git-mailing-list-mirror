From: Peter Krefting <peter@softwolves.pp.se>
Subject: How to achieve "git tag --merged"?
Date: Tue, 27 Apr 2010 08:59:20 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1004270846280.4769@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 27 09:59:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6fhZ-0002H6-O6
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 09:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570Ab0D0H7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 03:59:25 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:36063 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753302Ab0D0H7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 03:59:24 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o3R7xKlo006877
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 27 Apr 2010 09:59:20 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o3R7xKTH006873;
	Tue, 27 Apr 2010 09:59:20 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Tue, 27 Apr 2010 09:59:20 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145881>

Hi!

To look up which branches are contained by the current commit, "git branch 
--merged" is fine. Is there a way to do the same for tags?

I.e., I wish to list all tags that are set on commits that are ancestors of 
the current commit, basically the reverse of "git tag --contains", except I 
also want any tag that is exactly on the commit ID I enter.

-- 
\\// Peter - http://www.softwolves.pp.se/
