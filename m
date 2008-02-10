From: Joachim B Haga <cjhaga@fys.uio.no>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sun, 10 Feb 2008 10:34:23 +0100
Message-ID: <854pch5f4w.fsf@lupus.strangled.net>
References: <200802081828.43849.kendy@suse.cz> <m3ejbngtnn.fsf@localhost.localdomain> <200802091627.25913.kendy@suse.cz> <alpine.LFD.1.00.0802092200350.2732@xanadu.home> <BAYC1-PASMTP10AF630E8A5B3D6C255317AE290@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Holesovsky <kendy@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 10:35:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO8af-0001Yy-46
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 10:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758028AbYBJJei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 04:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757659AbYBJJei
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 04:34:38 -0500
Received: from main.gmane.org ([80.91.229.2]:50517 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756744AbYBJJeg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 04:34:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JO8Zx-0001iX-30
	for git@vger.kernel.org; Sun, 10 Feb 2008 09:34:29 +0000
Received: from 22.80-203-45.nextgentel.com ([80.203.45.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 09:34:29 +0000
Received: from cjhaga by 22.80-203-45.nextgentel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 09:34:29 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 22.80-203-45.nextgentel.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:70ELXlIuuipeRsBNcAxYdZfizXM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73326>

Sean <seanlkml@sympatico.ca> writes:

>> 	git config pack.deltaCacheLimit 1
>> 	git config pack.deltaCacheSize 1
>> 	git config pack.windowMemory 1g
>
> Tried that earlier today and got a 1.6G pack (on a 2G machine).  There are
> some big objects in that repo.. over 100 are 30 to 62M in size, 400 more
> over 10M, and ~40,000 over 100K.  Would you expect a larger memory window
> (on a better machine) to help shrink the repo down any more?

I tried without these, 1.47GiB packfile. Peak RSS ~14G.

-j.
