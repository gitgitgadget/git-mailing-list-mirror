From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 07/16] compat: add endinanness helpers
Date: Tue, 25 Jun 2013 14:08:39 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1306251404510.9929@ds9.cixit.se>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com> <1372116193-32762-8-git-send-email-tanoku@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 15:08:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrSzJ-0003wC-Sq
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 15:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401Ab3FYNIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 09:08:46 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:48985 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751082Ab3FYNIp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 09:08:45 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id r5PD8eJ2022978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 25 Jun 2013 15:08:40 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id r5PD8dsF022975;
	Tue, 25 Jun 2013 15:08:39 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1372116193-32762-8-git-send-email-tanoku@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Tue, 25 Jun 2013 15:08:40 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228959>

Vicent Marti:

> The POSIX standard doesn't currently define a `nothll`/`htonll` 
> function pair to perform network-to-host and host-to-network swaps 
> of 64-bit data. These 64-bit swaps are necessary for the on-disk 
> storage of EWAH bitmaps if they are not in native byte order.

endian(3) claims that glibc 2.9+ define be64toh() and htobe64() which 
should do what you are looking for. The manual page does mention them 
being named differently across OSes, though, so you may need to be 
careful with that.

-- 
\\// Peter - http://www.softwolves.pp.se/
