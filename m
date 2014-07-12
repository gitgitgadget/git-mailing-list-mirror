From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH v3] http: Add Accept-Language header if possible
Date: Sat, 12 Jul 2014 11:16:02 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1407121115110.18850@ds9.cixit.se>
References: <1405097573-19239-1-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 12:16:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5uLv-0004XW-MW
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 12:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbaGLKQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 06:16:20 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:38724 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752339AbaGLKQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 06:16:16 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s6CAG3F6019216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 12 Jul 2014 12:16:03 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s6CAG2NV019212;
	Sat, 12 Jul 2014 12:16:02 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1405097573-19239-1-git-send-email-eungjun.yi@navercorp.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Sat, 12 Jul 2014 12:16:03 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253388>

Yi EungJun:

> Add an Accept-Language header which indicates the user's preferred
> languages defined by $LANGUAGE, $LC_ALL, $LC_MESSAGES and $LANG.

This one seems to fix all the issues I had with the first patch, 
thanks!

-- 
\\// Peter - http://www.softwolves.pp.se/
