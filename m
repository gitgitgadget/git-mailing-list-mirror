From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH v2] http.c: use CURLOPT_RANGE for range requests
Date: Mon, 2 Nov 2015 00:00:42 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1511012359150.24283@tvnag.unkk.fr>
References: <1446245682-18087-1-git-send-email-dturner@twopensource.com> <20151031000837.GA25849@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 02 00:08:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zt1jU-00036y-PS
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 00:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311AbbKAXIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 18:08:12 -0500
Received: from giant.haxx.se ([80.67.6.50]:51005 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087AbbKAXIM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 18:08:12 -0500
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Nov 2015 18:08:11 EST
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-7) with ESMTP id tA1N0gAQ013853
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 2 Nov 2015 00:00:42 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id tA1N0ghn013845;
	Mon, 2 Nov 2015 00:00:42 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20151031000837.GA25849@sigill.intra.peff.net>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280676>

On Fri, 30 Oct 2015, Jeff King wrote:

> The goal makes sense. Why weren't we using CURLOPT_RANGE before? Did it not 
> exist (or otherwise have limitations) in 2005, and if so, when did it become 
> usable? Do we need to protect this with an #ifdef for the curl version?

CURLOPT_RANGE existed already in the first libcurl release: version 7.1, 
relased in August 2000.

-- 

  / daniel.haxx.se
