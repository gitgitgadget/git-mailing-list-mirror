From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 3/5] Warn if the Windows console font doesn't support
 Unicode
Date: Fri, 6 Jun 2014 22:18:43 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1406062211360.17391@ds9.cixit.se>
References: <1402062173-9602-1-git-send-email-kasal@ucw.cz> <1402062173-9602-4-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Jun 06 23:20:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt1XP-00077Q-7w
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 23:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbaFFVSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 17:18:55 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:39686 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752307AbaFFVSy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 17:18:54 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s56LIihg018977
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 6 Jun 2014 23:18:44 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s56LIhN5018973;
	Fri, 6 Jun 2014 23:18:43 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1402062173-9602-4-git-send-email-kasal@ucw.cz>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Fri, 06 Jun 2014 23:18:45 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250970>

Stepan Kasal:

> +	warning("Your console font probably doesn\'t support Unicode. If "
> +		"you experience strange characters in the output, consider "
> +		"switching to a TrueType font such as Lucida Console!");

As you mention this is an old patch series, but I would recommend 
modernizing the suggestion here to recomment "Consolas". It is 
available in all current versions of Windows (Vista and later), and 
seem to have better Unicode support according to 
<http://www.fileformat.info/info/unicode/font/consolas/list.htm> vs 
<http://www.fileformat.info/info/unicode/font/lucida_console/list.htm>

-- 
\\// Peter - http://www.softwolves.pp.se/
