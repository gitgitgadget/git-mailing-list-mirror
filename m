From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [curl PATCH 2/2] ignore SIGPIPE during curl_multi_cleanup
Date: Wed, 27 Nov 2013 22:39:00 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1311272237400.17037@tvnag.unkk.fr>
References: <20131125143213.GA22642@sigill.intra.peff.net> <20131125144321.GA23779@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 27 22:39:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlmpN-0003Wy-AX
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 22:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757912Ab3K0VjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 16:39:15 -0500
Received: from giant.haxx.se ([80.67.6.50]:46914 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757227Ab3K0VjM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 16:39:12 -0500
Received: from giant.haxx.se (dast@localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-4.1) with ESMTP id rARLd0Y0024624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2013 22:39:00 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id rARLd05C024618;
	Wed, 27 Nov 2013 22:39:00 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20131125144321.GA23779@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238466>

On Mon, 25 Nov 2013, Jeff King wrote:

> This is an extension to the fix in 7d80ed64e43515. We may call 
> Curl_disconnect() while cleaning up the multi handle, which could lead to 
> openssl sending packets, which could get a SIGPIPE.

Thanks a lot. I'll merge these ones in a second and they will be included in 
the coming 7.34.0 release (due to ship in mid December).

-- 

  / daniel.haxx.se
