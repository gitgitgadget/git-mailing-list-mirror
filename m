From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: msysgit with git protocol to linux server
Date: Sat, 19 May 2012 10:14:45 +0200
Message-ID: <4FB75675.9070709@kdbg.org>
References: <jp69f2$gir$1@dough.gmane.org> <20120518235746.GA765@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 19 10:15:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVeom-0006FI-Hw
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 10:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634Ab2ESIOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 04:14:54 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:19474 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753532Ab2ESIOt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 04:14:49 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 8B1B9A7EB5;
	Sat, 19 May 2012 10:16:24 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D312219F5F6;
	Sat, 19 May 2012 10:14:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <20120518235746.GA765@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198026>

Am 19.05.2012 01:57, schrieb Jeff King:
>   2. You want to allow pushes over git:// instead of ssh. I wouldn't
>      recommend this, but you can do so by setting daemon.receivepack in
>      the config.

But push via git protocol does not work when the client is MinGW git
(msysgit). I've posted a work-around on the msysgit list, but it is
still on my agenda to re-submit a cleaned-up version of it.

http://thread.gmane.org/gmane.comp.version-control.msysgit/13409

-- Hannes
