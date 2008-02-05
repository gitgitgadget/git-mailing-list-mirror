From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-rebase.sh: Change .dotest directory to .git-dotest
Date: Wed, 06 Feb 2008 00:51:38 +0200
Organization: Private
Message-ID: <ejbrxbid.fsf@blue.sea.net>
References: <ve53xwob.fsf@blue.sea.net>
	<alpine.LSU.1.00.0802051524580.8543@racer.site>
	<prvbxfhl.fsf@blue.sea.net>
	<alpine.LFD.1.00.0802051334070.3110@woody.linux-foundation.org>
	<alpine.LSU.1.00.0802052236220.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 23:53:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMWfB-0004ii-Tm
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 23:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbYBEWwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 17:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbYBEWwk
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 17:52:40 -0500
Received: from main.gmane.org ([80.91.229.2]:55666 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956AbYBEWwj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 17:52:39 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JMWeW-0000hH-Tq
	for git@vger.kernel.org; Tue, 05 Feb 2008 22:52:32 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 22:52:32 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 22:52:32 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:ZMKV66aeGEbP+Q2SSIduoh2ePQE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72716>

* Tue 2008-02-05 Johannes Schindelin <Johannes.Schindelin@gmx.de>
* Message-Id: alpine.LSU.1.00.0802052236220.8543@racer.site
> On at least one machine (not the current one, because I was too lazy), I 
> have a git alias to call when the patch does not apply, to call another 
> program in turn which made it easier for me to integrate a non-applying 
> patch into the current working directory.
>
> And guess what: this script accesses .dotest/.  Yes, I know, it was 
> _prone_ to move.

If somebody has written scripts to do something with the internals, he
already knows the internals. I'm confident those can easily track the
changes. They are experts already if they use .dotest.

All good shell scripts test the conditions before they proceed. Like
in this case. Something:

    dir=.dotest

    [ -d "$dir" ] || { echo "No directory $dir" >&2; exit 1; }

Sloppy scripts are best left to script writers headache.

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
