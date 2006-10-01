From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: tree view: hash_base and hash are now context sensitive
Date: Mon, 02 Oct 2006 00:27:36 +0200
Organization: At home
Message-ID: <efpfc3$765$1@sea.gmane.org>
References: <200609292235.27478.jnareb@gmail.com> <20060929233037.42926.qmail@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Oct 02 00:27:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU9mj-0008H5-KD
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 00:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWJAW1e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 18:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWJAW1e
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 18:27:34 -0400
Received: from main.gmane.org ([80.91.229.2]:40109 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932428AbWJAW1d (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 18:27:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GU9mP-0008Ed-5b
	for git@vger.kernel.org; Mon, 02 Oct 2006 00:27:25 +0200
Received: from host-81-190-17-45.torun.mm.pl ([81.190.17.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 02 Oct 2006 00:27:25 +0200
Received: from jnareb by host-81-190-17-45.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 02 Oct 2006 00:27:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-45.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28208>

Luben Tuikov wrote:

> What this patch does is simply set "h" and/or "hb" to
> the string "HEAD" instead of the string "<SHA1 of HEAD>" when
> h/hb is not defined.

I guess there it is a good idea, but we should always think
over if we want "constant" link, always showing the same thing,
or a "variable" (or "news") link, showing current version.

Explicit sha1 hash as 'h'/'hb' gives persistent, cacheable link,
while e.g. "HEAD" gives "variable" link.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
