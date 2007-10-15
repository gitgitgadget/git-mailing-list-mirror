From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-svn and submodules
Date: Mon, 15 Oct 2007 12:00:32 +0200
Message-ID: <47133A40.20303@op5.se>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp> <Pine.LNX.4.64.0710141751530.25221@racer.site> <Pine.LNX.4.64.0710141901450.25221@racer.site> <20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma> <Pine.LNX.4.64.0710142309010.25221@racer.site> <20071014224959.GA17828@untitled> <Pine.LNX.4.64.0710142359020.25221@racer.site> <05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git list <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Oct 15 12:01:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhMkh-00079d-1J
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 12:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023AbXJOKAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 06:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754694AbXJOKAg
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 06:00:36 -0400
Received: from mail.op5.se ([193.201.96.20]:52344 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754564AbXJOKAg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 06:00:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E771717306DE;
	Mon, 15 Oct 2007 12:00:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dUX8tC6ZRPuV; Mon, 15 Oct 2007 12:00:34 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 012861730693;
	Mon, 15 Oct 2007 12:00:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60974>

Benoit SIGOURE wrote:
>   - git svn create-ignore (to create one .gitignore per directory from 
> the svn:ignore properties.  This has the disadvantage of committing the 
> .gitignore during the next dcommit, but when you import a repo with tons 
> of ignores (>1000), using git svn show-ignore to build .git/info/exclude 
> is *not* a good idea, because things like git-status will end up doing 
>  >1000 fnmatch *per file* in the repo, which leads to git-status taking 
> more than 4s on my Core2Duo 2Ghz 2G RAM)

How spoiled we are. I just ran cvs status on a checkout of a repo located
on a server in the local network. It took 6 seconds to complete :P

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
