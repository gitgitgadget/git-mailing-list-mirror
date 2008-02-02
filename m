From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] --format=pretty: new modifiers cID, cIS, CIY
Date: Sat, 02 Feb 2008 03:15:38 +0200
Organization: Private
Message-ID: <7iho6tvp.fsf@blue.sea.net>
References: <odb072ca.fsf@blue.sea.net>
	<7vir188ej4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 02:21:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL742-0005Ef-OJ
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 02:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759655AbYBBBUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 20:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759558AbYBBBUK
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 20:20:10 -0500
Received: from main.gmane.org ([80.91.229.2]:53346 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755276AbYBBBUI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 20:20:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JL735-0007Ss-1K
	for git@vger.kernel.org; Sat, 02 Feb 2008 01:20:03 +0000
Received: from a91-155-183-103.elisa-laajakaista.fi ([91.155.183.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 01:20:03 +0000
Received: from jari.aalto by a91-155-183-103.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 01:20:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-183-103.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:8G4Tmbdi02QLe17IgqeMm4eFzME=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72201>

* Fri 2008-02-01 Junio C Hamano <gitster@pobox.com>
> But I do not like the idea of adding more short-hand format this
> way.

I'd welcome if this mimimum set of ISO date handling woudl be included,
because I feel they address the needs more versatily than the current
%ci, which is too long with down to TZ.

I find it that the YYY-MM-DD HH:MM meets the needs 99% of the case, like
in ls(1) listing when the LC_* is properly configured.

[extensible syntax]
> 	%c(name|initial) %c(time|local,HH:MM) %c(time|gmt,HH) <%c(email)>

This would be good. In the mean time, when we wait for this feature to
surface, the current patch would address immediate needs.

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
