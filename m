From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Init on push
Date: Sat, 08 Nov 2008 21:06:01 +0100
Organization: At home
Message-ID: <gf4rf6$v52$1@ger.gmane.org>
References: <200811081708.45672.robin.rosenberg.lists@dewire.com> <7viqqyc93w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 21:07:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyu5c-0000aK-8u
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 21:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbYKHUGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 15:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbYKHUGI
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 15:06:08 -0500
Received: from main.gmane.org ([80.91.229.2]:43859 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677AbYKHUGI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 15:06:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kyu4M-0004RP-6M
	for git@vger.kernel.org; Sat, 08 Nov 2008 20:06:06 +0000
Received: from abva119.neoplus.adsl.tpnet.pl ([83.8.198.119])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Nov 2008 20:06:06 +0000
Received: from jnareb by abva119.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Nov 2008 20:06:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abva119.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100419>

Junio C Hamano wrote:

>  - Teach "-D $there" option to "git init", which does an "mkdir -p $it &&
>    chdird $it" before it does its work.

Shouldn't it be "-C $there" (like make and tar)?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
