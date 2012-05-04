From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH 1/6] http: try http_proxy env var when http.proxy config
 option is not set
Date: Fri, 4 May 2012 09:27:16 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1205040921090.12158@tvnag.unkk.fr>
References: <4FA2B4D3.90809@seap.minhap.es> <20120504070802.GA21895@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 04 09:38:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQD5l-00025T-9t
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 09:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323Ab2EDHiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 03:38:12 -0400
Received: from giant.haxx.se ([80.67.6.50]:51465 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538Ab2EDHiM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 03:38:12 -0400
X-Greylist: delayed 645 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 May 2012 03:38:11 EDT
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id q447RGuf007856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 4 May 2012 09:27:16 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id q447RGoA007850;
	Fri, 4 May 2012 09:27:16 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20120504070802.GA21895@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197005>

On Fri, 4 May 2012, Jeff King wrote:

> I don't see any way around it besides implementing curl's full tokenizing 
> and matching algorithm, which is about a page of code. I'd really prefer not 
> to re-implement bits of curl (especially because they may change later), but 
> AFAIK there is no way to ask curl "is there a proxy configured, and if so, 
> what is it?".

Sorry for being thick, but I lost track on this thread. Why does it need this 
info again?

Or perhaps put another way: if there was an ideal way to get this done or 
provide this to libcurl other than the current way, how would you suggest it 
would be done from a git internal point of view?

We're currently discussing new ways of providing authentication info in 
libcurl and I want to make sure I can get useful bits from this exercise into 
that talk to possibly offer something smoother in the future.

-- 

  / daniel.haxx.se
