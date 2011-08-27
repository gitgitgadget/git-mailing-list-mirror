From: Alexey Shumkin <zapped@mail.ru>
Subject: Re: [RFC/PATCH] attr: map builtin userdiff drivers to well-known extensions
Date: Sat, 27 Aug 2011 05:14:05 +0000 (UTC)
Message-ID: <loom.20110827T070650-93@post.gmane.org>
References: <20110825200001.GA6165@sigill.intra.peff.net> <20110825204047.GA9948@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 07:14:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxBE3-0004p0-9s
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 07:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106Ab1H0FOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 01:14:23 -0400
Received: from lo.gmane.org ([80.91.229.12]:55394 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926Ab1H0FOW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 01:14:22 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QxBDk-0004je-Vn
	for git@vger.kernel.org; Sat, 27 Aug 2011 07:14:16 +0200
Received: from ppp91-77-37-230.pppoe.mtu-net.ru ([91.77.37.230])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Aug 2011 07:14:16 +0200
Received: from zapped by ppp91-77-37-230.pppoe.mtu-net.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Aug 2011 07:14:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 91.77.37.230 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.112 Safari/535.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180222>

> Also, any other extensions that would go into such a list? I have no
> idea what the common extension is for something like pascal or csharp.

# [Object] Pascal unit files
*.pas diff=pascal

# + project files (they rarely contain procedures/functions
# but it is not forbidden in specification)

*.dpr diff=pascal

# for Lazarus - pp and .lpr respectivly
*.pp diff=pascal
*.lpr diff=pascal
