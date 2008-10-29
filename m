From: Hannu Koivisto <azure@iki.fi>
Subject: Re: git bisect view's use of DISPLAY environment variable in Cygwin
Date: Wed, 29 Oct 2008 15:31:05 +0200
Organization: NOYB
Message-ID: <83abcncyue.fsf@kalahari.s2.org>
References: <83wsfs1y6v.fsf@kalahari.s2.org>
	<c07716ae0810281015s47741fdqec4c3bed3313bb6a@mail.gmail.com>
	<83skqg1uc9.fsf@kalahari.s2.org>
	<c07716ae0810281213k432d82d8i468f54ae03146b88@mail.gmail.com>
	<83iqrccpmk.fsf@kalahari.s2.org> <83ej20cndw.fsf@kalahari.s2.org>
	<alpine.DEB.1.00.0810290144450.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 14:32:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvBA3-0000TL-NP
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 14:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbYJ2NbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 09:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753879AbYJ2NbW
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 09:31:22 -0400
Received: from main.gmane.org ([80.91.229.2]:33063 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753816AbYJ2NbV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 09:31:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KvB8o-0008BN-5M
	for git@vger.kernel.org; Wed, 29 Oct 2008 13:31:18 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 13:31:18 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 13:31:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:KD9D0kVC7gmGmTVrrfgWBvwtcSs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99364>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I submitted a patch a while ago, saying
>
> 	bisect view: call gitk if Cygwin's SESSIONNAME variable is set
>
> See 
> http://repo.or.cz/w/git/dscho.git?a=commitdiff;h=a2637a3a003646c69ab5a6b85f0ee1bfac15e0b0

Unfortunately this approach doesn't seem to work if you run git
bisect view from, say, cmd (probably applies to other non-Cygwin
shells as well).  I'm puzzled as to why this happens; I wrote a
simple shell script that echoes $SESSIONNAME and no matter how I
run it from cmd it always echoes Console.

It's certainly better than nothing and I wouldn't mind it ending up
to the official git but...

-- 
Hannu
