From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] grep: remove tautological check
Date: Sat, 20 Oct 2012 20:23:43 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1210202022270.19498@ds9.cixit.se>
References: <1350753964-29346-1-git-send-email-dsp@php.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: David Soria Parra <dsp@php.net>
X-From: git-owner@vger.kernel.org Sat Oct 20 21:24:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPeeW-0003ko-K1
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 21:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756636Ab2JTTX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2012 15:23:56 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:49416 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754446Ab2JTTXz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2012 15:23:55 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id q9KJNitK019599
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 20 Oct 2012 21:23:44 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id q9KJNhqA019596;
	Sat, 20 Oct 2012 21:23:44 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1350753964-29346-1-git-send-email-dsp@php.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Sat, 20 Oct 2012 21:23:44 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208092>

David Soria Parra:

> The enum grep_header_field is unsigned.

Enumerations can be either unsigned or signed, it is up to the 
compiler to decide. Even if you assign only positive number to named 
enumeration values, there are compilers that make them signed. I've 
been bitten by that enough.

-- 
\\// Peter - http://www.softwolves.pp.se/
