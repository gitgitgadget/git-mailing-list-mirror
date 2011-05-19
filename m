From: Daniel Stenberg <daniel@haxx.se>
Subject: RE: FW: git over https and http 1.1
Date: Thu, 19 May 2011 09:31:27 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1105190928560.3084@tvnag.unkk.fr>
References: <BLU0-SMTP122315AAE364595FDA4A30AC78F0@phx.gbl> <alpine.DEB.2.00.1105181615180.26343@tvnag.unkk.fr> <BLU0-SMTP207861424D1FA595A51BBBEC78E0@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Nir Friedman <nirfri@hotmail.com>
X-From: git-owner@vger.kernel.org Thu May 19 09:31:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMxhr-0001aV-5G
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 09:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557Ab1ESHbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 03:31:33 -0400
Received: from giant.haxx.se ([80.67.6.50]:51582 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932449Ab1ESHbd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 03:31:33 -0400
Received: from giant.haxx.se (giant.haxx.se [80.67.6.50])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id p4J7VRcD008657;
	Thu, 19 May 2011 09:31:27 +0200
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <BLU0-SMTP207861424D1FA595A51BBBEC78E0@phx.gbl>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
X-Greylist: Default is to whitelist mail, not delayed by milter-greylist-4.3.8 (giant.haxx.se [80.67.6.50]); Thu, 19 May 2011 09:31:27 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173945>

On Thu, 19 May 2011, Nir Friedman wrote:

> See below the output of GIT_CURL_VERBOSE, I marked the position (POINT 1) 
> where there seems to be a hang (~20 seconds)

Can you detect any difference in the HTTP request when done from the working 
Windows setup?

> < Date: Thu, 19 May 2011 04:37:40 GMT
> < Server: Apache/2.2.17 (Ubuntu)
> < Expires: Fri, 01 Jan 1980 00:00:00 GMT
> < Pragma: no-cache
> < Cache-Control: no-cache, max-age=0, must-revalidate
> < Transfer-Encoding: chunked
> < Content-Type: application/x-git-upload-pack-advertisement
> <
> *********************************************///////////POINT
> 1///////////**************************************

At this point I'll have to defer this subject to the fine hackers who actually 
know the inside of git and the git server and what it should and shouldn't do 
at that point.

-- 

  / daniel.haxx.se
