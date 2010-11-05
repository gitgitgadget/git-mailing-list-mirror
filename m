From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 2/2] rebase: teach --autosquash to match on sha1 in
 addition to message
Date: Fri, 5 Nov 2010 14:04:26 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1011051401090.7611@ds9.cixit.se>
References: <1288838504-69114-1-git-send-email-kevin@sb.org> <1288838504-69114-2-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Nov 05 14:10:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEM40-00045y-9S
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 14:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226Ab0KENKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 09:10:34 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:57005 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752129Ab0KENKd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 09:10:33 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Nov 2010 09:10:32 EDT
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id oA5D4RtE022956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 5 Nov 2010 14:04:27 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id oA5D4Qll022952;
	Fri, 5 Nov 2010 14:04:27 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1288838504-69114-2-git-send-email-kevin@sb.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Fri, 05 Nov 2010 14:04:27 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160812>

Kevin Ballard:

> Support lines of the form "fixup! 7a235b" that specify an exact commit
> in addition to the normal "squash! Old commit message" form.

The patch I posted for this in June (Message-Id: 
<20100617125746.E86B42FC00@perkele>) also updated the manual page for 
git-rebase. You may want to re-use parts of that.

http://www.spinics.net/lists/git/msg133571.html has an archived version of it.

-- 
\\// Peter - http://www.softwolves.pp.se/
