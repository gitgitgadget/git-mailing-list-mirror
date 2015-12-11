From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [RFC] Case insensitive URL rewrite
Date: Fri, 11 Dec 2015 15:38:52 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1512111535040.9787@tvnag.unkk.fr>
References: <B207EFC1-48DF-4B8F-8373-28A0CB5660B0@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 15:52:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7P3T-0007D3-Cv
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 15:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbbLKOwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 09:52:12 -0500
Received: from giant.haxx.se ([80.67.6.50]:33664 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042AbbLKOwL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 09:52:11 -0500
X-Greylist: delayed 789 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Dec 2015 09:52:10 EST
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-7) with ESMTP id tBBEcr7i021943
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Dec 2015 15:38:53 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id tBBEcq8L021939;
	Fri, 11 Dec 2015 15:38:52 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <B207EFC1-48DF-4B8F-8373-28A0CB5660B0@gmail.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282259>

On Fri, 11 Dec 2015, Lars Schneider wrote:

> the "url.<someURL>.insteadOf" git config is case sensitive. I understand 
> that this makes sense on case sensitive file systems. However, URLs are 
> mostly case insensitive:

Minor detail here perhaps, but...

I would object to URLs being "mostly case insensitive", even if github 
apparently seems to work that way. The path part of URLs are rarely case 
insensitive since it tends to map to a *nix file system, while the host name 
part is insensitive as section 3.2.2 in RFC 3986 says.

-- 

  / daniel.haxx.se
