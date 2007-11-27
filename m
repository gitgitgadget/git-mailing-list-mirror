From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Replace misleading message during interactive rebasing
Date: Tue, 27 Nov 2007 10:49:03 +0100
Organization: At home
Message-ID: <figp6f$onj$1@ger.gmane.org>
References: <1196111891-18518-1-git-send-email-win@wincent.com> <474BD5CA.7050407@viscovery.net> <20071127094639.GC3571@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 10:55:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwxA7-0003vB-P4
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 10:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbXK0JzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 04:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbXK0JzJ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 04:55:09 -0500
Received: from main.gmane.org ([80.91.229.2]:58116 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478AbXK0JzH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 04:55:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iwx4h-0005Hp-Tj
	for git@vger.kernel.org; Tue, 27 Nov 2007 09:49:51 +0000
Received: from abvx183.neoplus.adsl.tpnet.pl ([83.8.221.183])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 09:49:51 +0000
Received: from jnareb by abvx183.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 09:49:51 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvx183.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66178>

Jeff King wrote:

> On Tue, Nov 27, 2007 at 09:31:06AM +0100, Johannes Sixt wrote:
> 
>> Isn't this a bashism? Should be:
>>
>>              _GIT_CHERRY_PICK_HELP="run 'git rebase --continue'"
>>              export _GIT_CHERRY_PICK_HELP
>>
>> (and the second instance of this as well, of course)
> 
> No, it's in POSIX:
> 
> http://www.opengroup.org/onlinepubs/009695399/utilities/export.html
> 
> However, I'm sure you will be shocked to learn that /bin/sh on Solaris
> doesn't understand it:
> 
> $ export foo=bar
> foo=bar: is not an identifier

If I remember correctly /bin/sh on Solaris cannot be used because
of other issues (like $(...) and such).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
