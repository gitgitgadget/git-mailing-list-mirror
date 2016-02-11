From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] Implement https public key pinning
Date: Fri, 12 Feb 2016 00:30:57 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602120030120.5268@tvnag.unkk.fr>
References: <20160211225437.GA33955@mitoraj.siccegge.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Christoph Egger <christoph@christoph-egger.org>
X-From: git-owner@vger.kernel.org Fri Feb 12 00:31:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU0hc-0006xU-4P
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 00:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbcBKXbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 18:31:07 -0500
Received: from giant.haxx.se ([80.67.6.50]:56428 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbcBKXbG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 18:31:06 -0500
Received: from giant.haxx.se (dast@localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.15.2/8.15.2/Debian-3) with ESMTPS id u1BNUwZl005810
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Feb 2016 00:30:58 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id u1BNUv8M005807;
	Fri, 12 Feb 2016 00:30:57 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20160211225437.GA33955@mitoraj.siccegge.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286018>

On Thu, 11 Feb 2016, Christoph Egger wrote:

> +#if LIBCURL_VERSION_NUM >= 0x074400

That should probably be 0x072c00 ...

-- 

  / daniel.haxx.se
