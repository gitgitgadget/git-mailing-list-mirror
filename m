From: Stephan Hennig <mailing_list@arcor.de>
Subject: Re: git pull is slow
Date: Fri, 11 Jul 2008 14:55:25 +0200
Message-ID: <g57mu1$q3v$1@ger.gmane.org>
References: <g5570s$d5m$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 15:26:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHId4-0000KQ-7r
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 15:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbYGKNYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 09:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbYGKNYo
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 09:24:44 -0400
Received: from main.gmane.org ([80.91.229.2]:55320 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbYGKNYn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 09:24:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KHIc2-0004Yi-0J
	for git@vger.kernel.org; Fri, 11 Jul 2008 13:24:38 +0000
Received: from dialin-145-254-069-091.pools.arcor-ip.net ([145.254.69.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 13:24:37 +0000
Received: from mailing_list by dialin-145-254-069-091.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 13:24:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dialin-145-254-069-091.pools.arcor-ip.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12
In-Reply-To: <g5570s$d5m$1@ger.gmane.org> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88117>

Stephan Hennig schrieb:

> Does it matter that the original clone has been performed with plain git
> protocol?  I have only later changed the url in .git/config to use git+ssh.

To be precise, the original pull has been done via

	url = git://repo.or.cz/wortliste.git

which is a read-only URL.  I changed .git/config manually to point to

	url = git+ssh://xxx@repo.or.cz/srv/git/wortliste.git

later, which is the push URL.

Best regards,
Stephan Hennig
