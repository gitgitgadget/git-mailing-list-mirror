From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: segfault in git-remote-http
Date: Tue, 9 Apr 2013 19:25:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1304091924210.20932@tvnag.unkk.fr>
References: <20130407093812.cae0e19123f7b6d2061800aa@lavabit.com> <20130409084718.587e99aa7a935296867a84a1@lavabit.com> <20130409171623.GE21972@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 09 19:26:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPcJ8-0003IL-1h
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 19:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763142Ab3DIR0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 13:26:04 -0400
Received: from giant.haxx.se ([80.67.6.50]:55939 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758702Ab3DIR0D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 13:26:03 -0400
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id r39HPr8E002741
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 9 Apr 2013 19:25:53 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id r39HPrxn002733;
	Tue, 9 Apr 2013 19:25:53 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20130409171623.GE21972@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220591>

On Tue, 9 Apr 2013, Jeff King wrote:

> git-remote-http does not touch the openssl code itself at all. We only talk 
> to curl, which handles all of the ssl (and may even be built on gnutls). So 
> if that is the problem, then I think it may be a libcurl bug, not a git one.

... and if/when you do make it a libcurl bug, please include more details that 
includes how to repeat the problem and what versions of libcurl and OpenSSL 
you're using.

-- 

  / daniel.haxx.se
