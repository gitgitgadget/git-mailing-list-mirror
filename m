From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] gitk: Update Swedish translation (278t0f0u).
Date: Thu, 13 Aug 2009 13:47:42 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0908131344440.18241@ds9.cixit.se>
References: <alpine.DEB.2.00.0907100811180.17673@ds9.cixit.se> <19075.65114.64967.831062@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 14:47:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbZin-0001oc-1Z
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 14:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402AbZHMMrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 08:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754352AbZHMMrr
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 08:47:47 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:38909 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753806AbZHMMrq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 08:47:46 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n7DClhIp012193
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Aug 2009 14:47:43 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n7DClgk2012190;
	Thu, 13 Aug 2009 14:47:43 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <19075.65114.64967.831062@cargo.ozlabs.ibm.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 13 Aug 2009 14:47:43 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125820>

Paul Mackerras:

> Yes, but your mailer managed to munge the whitespace.  It came through
> as format=flowed and charset=ISO-8859-15 again.  Please resend.

It looked good in Alpine's postponed folder until I actually sent it... This 
time, I just basically piped the format-patch output to postfix. Hopefully 
that works better.

I get an error if I try to run msgfmt:

$ LC_ALL=C msgfmt -o /dev/null --check --statistics sv.po
sv.po:1090: 'msgstr' is not a valid Tcl format string, unlike 'msgid'. 
Reason: In the directive number 1, the character 'a' is not a valid 
conversion specifier.
msgfmt: found 1 fatal error
280 translated messages.

This is for the message "Maximum graph width (% of pane)" which 
(incorrectly?) is marked as tcl-format.

-- 
\\// Peter - http://www.softwolves.pp.se/
