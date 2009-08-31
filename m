From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: clong an empty repo over ssh causes (harmless) fatal
Date: Mon, 31 Aug 2009 11:14:22 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnh9nc4e.6bn.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 31 13:14:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi4qY-0000c8-1E
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 13:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbZHaLOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 07:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbZHaLOj
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 07:14:39 -0400
Received: from lo.gmane.org ([80.91.229.12]:34182 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872AbZHaLOi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 07:14:38 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mi4qN-0000Zb-ME
	for git@vger.kernel.org; Mon, 31 Aug 2009 13:14:39 +0200
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 13:14:39 +0200
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 13:14:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127476>

Hello,

Cloning an empty repo seems to produce a spurious error.
The repo still seems fine though.

Any thoughts?

    $ git clone ssh://sitaram@localhost/home/sitaram/t/a b
    Initialized empty Git repository in /home/sitaram/t/b/.git/
    sitaram@localhost's password:
    warning: You appear to have cloned an empty repository.
    fatal: The remote end hung up unexpectedly

Thanks,

Sitaram
