From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-rebase.sh: Change .dotest directory to .git-dotest
Date: Tue, 05 Feb 2008 23:25:42 +0200
Organization: Private
Message-ID: <prvbxfhl.fsf@blue.sea.net>
References: <ve53xwob.fsf@blue.sea.net>
	<alpine.LSU.1.00.0802051524580.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 22:27:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMVJw-00056O-4S
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 22:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758866AbYBEV0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 16:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758806AbYBEV0j
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 16:26:39 -0500
Received: from main.gmane.org ([80.91.229.2]:60723 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758088AbYBEV0i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 16:26:38 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JMVJF-00057F-Az
	for git@vger.kernel.org; Tue, 05 Feb 2008 21:26:29 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 21:26:29 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 21:26:29 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:JXjB7DHXFOANwCev6XdOlBDTCN4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72701>

* Tue 2008-02-05 Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> If at all, it should be in .git/rebase/

Much better.

> we have a different directory already for interactive rebase and rebase 
> -m, .git/.dotest-merge/ (which could have been a better name, too).

Yes, that should go to .git too.

> But the consensus was that there might be scripts relying on the name of 
> the directory

Who would use or rely on the internal workings of git-rebase? The will
not be any considerable amount of those. I'm confident that those people
have enough expertise to change their scripts.

The current situation is plain ugly and git shouldn't stomp on any other
dir than .git

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
