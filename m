From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] RelNotes/1.8.5: direct script writers to "git status --porcelain"
Date: Thu, 26 Sep 2013 18:19:35 +0000 (UTC)
Message-ID: <loom.20130926T201754-563@post.gmane.org>
References: <1380201815-14140-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 20:20:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPGAT-0004po-BI
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 20:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673Ab3IZST5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 14:19:57 -0400
Received: from plane.gmane.org ([80.91.229.3]:36002 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753569Ab3IZST5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 14:19:57 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VPGAN-0004kC-Rp
	for git@vger.kernel.org; Thu, 26 Sep 2013 20:19:56 +0200
Received: from adhg130.neoplus.adsl.tpnet.pl ([79.184.162.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 20:19:55 +0200
Received: from jnareb by adhg130.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 20:19:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 79.184.162.130 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.4 (KHTML, like Gecko) Ubuntu/12.10 Chromium/22.0.1229.94 Chrome/22.0.1229.94 Safari/537.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235424>

Matthieu Moy <Matthieu.Moy <at> imag.fr> writes:


>   * "git status" now omits the prefix to make its output a comment in a
>     commit log editor, which is not necessary for human consumption.
> +   Scripts that parse the output of "git status" are advised to use
> +   "git status --porcelain", which is both easier to parse and stable,
> +   instead.

Good addition.

Perhaps "to use instead ..." would be easier to understand than
proposed "to use ..., instead." (with "..." being one line long).

-- 
Jakub Narebski.
