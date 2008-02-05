From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-rebase.sh: Use POSIX/Susv command substitution instead of backticks
Date: Wed, 06 Feb 2008 00:53:00 +0200
Organization: Private
Message-ID: <abmfxbg3.fsf@blue.sea.net>
References: <lk5zxdix.fsf@blue.sea.net>
	<alpine.LSU.1.00.0802052226340.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 23:55:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMWhZ-0005Un-Mk
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 23:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbYBEWzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 17:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753119AbYBEWzH
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 17:55:07 -0500
Received: from main.gmane.org ([80.91.229.2]:56249 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752921AbYBEWzF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 17:55:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JMWgy-0000oQ-Bt
	for git@vger.kernel.org; Tue, 05 Feb 2008 22:55:04 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 22:55:04 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 22:55:04 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:hNXAqpas0fgXfiTgy1ymM7A+fcQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72718>

* Tue 2008-02-05 Johannes Schindelin <Johannes.Schindelin@gmx.de>
* Message-Id: alpine.LSU.1.00.0802052226340.8543@racer.site
> Hi,
>
> On Wed, 6 Feb 2008, Jari Aalto wrote:
>
>> Use redable $(<command>) syntax instead of backtics in code.  See The 
>> Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition
>
> Sorry, I am not quite sure if this patch is worth it: either you want to 
> clean this up in _all_ of our shell scripts, or you leave it.  

Yes, that's the plan. This is just a start.

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
