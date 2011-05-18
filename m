From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: FW: git over https and http 1.1
Date: Wed, 18 May 2011 16:39:43 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1105181615180.26343@tvnag.unkk.fr>
References: <BLU0-SMTP122315AAE364595FDA4A30AC78F0@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Nir Friedman <nirfri@hotmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 16:39:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMhun-0001xV-Gz
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 16:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933225Ab1EROjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 10:39:51 -0400
Received: from giant.haxx.se ([80.67.6.50]:47944 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933044Ab1EROju (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 10:39:50 -0400
Received: from giant.haxx.se (giant.haxx.se [80.67.6.50])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id p4IEdh6V010684;
	Wed, 18 May 2011 16:39:43 +0200
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <BLU0-SMTP122315AAE364595FDA4A30AC78F0@phx.gbl>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
X-Greylist: Default is to whitelist mail, not delayed by milter-greylist-4.3.8 (giant.haxx.se [80.67.6.50]); Wed, 18 May 2011 16:39:43 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173882>

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
