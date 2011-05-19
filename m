From: Nir Friedman <nirfri@hotmail.com>
Subject: RE: FW: git over https and http 1.1
Date: Thu, 19 May 2011 08:02:19 +0300
Message-ID: <BLU0-SMTP113B2A384962D5B58D7FDC8C78E0@phx.gbl>
References: <BLU0-SMTP122315AAE364595FDA4A30AC78F0@phx.gbl> <alpine.DEB.2.00.1105181615180.26343@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Daniel Stenberg'" <daniel@haxx.se>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 19 07:02:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMvNT-0002qa-HU
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 07:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343Ab1ESFCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 01:02:23 -0400
Received: from blu0-omc3-s18.blu0.hotmail.com ([65.55.116.93]:19883 "EHLO
	blu0-omc3-s18.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751927Ab1ESFCW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 01:02:22 -0400
Received: from BLU0-SMTP113 ([65.55.116.74]) by blu0-omc3-s18.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 18 May 2011 22:02:21 -0700
X-Originating-IP: [212.179.48.132]
X-Originating-Email: [nirfri@hotmail.com]
Received: from nirftp ([212.179.48.132]) by BLU0-SMTP113.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 18 May 2011 22:02:20 -0700
In-Reply-To: <alpine.DEB.2.00.1105181615180.26343@tvnag.unkk.fr>
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AcwVaW/mIjIo9blURlWMUjnhIwYe4QAd03+Q
Content-Language: en-us
X-OriginalArrivalTime: 19 May 2011 05:02:20.0462 (UTC) FILETIME=[EEC514E0:01CC15E1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173929>

At https://rapidshare.com/files/947175880/git_ssl.cap

is a tcpdump of this problem see packet no. 518 where there seems to be a
hang


Thanks
Nir


-----Original Message-----
From: Daniel Stenberg [mailto:daniel@haxx.se] 
Sent: Wednesday, May 18, 2011 5:40 PM
To: Nir Friedman
Cc: git@vger.kernel.org
Subject: Re: FW: git over https and http 1.1

On Wed, 18 May 2011, Nir Friedman wrote:

> Fast is - 15 seconds, around  50% less

15 seconds is a really long time. I think it might be useful if you did some

network snooping/capturing to see what's really going on. Or set 
GIT_CURL_VERBOSE to get some verbose libcurl output and see if that explains

anything.

> This was checked on 	Ubuntu 	11.04  Libcurl 	7.21.3
> This problem didn't exist on windows clients.

libcurl works exactly the same on Windows so that effectively nullifies the 
theory it would have something to do with libcurl's HTTP 1.1 support...

-- 

  / daniel.haxx.se
