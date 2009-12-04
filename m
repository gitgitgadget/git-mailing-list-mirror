From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Endianness bug in git-svn or called component?
Date: Fri, 04 Dec 2009 21:16:40 +0100
Message-ID: <m23a3qa40n.fsf@igel.home>
References: <20091204174458.GV17192@gradx.cs.jhu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nathaniel W Filardo <nwf@cs.jhu.edu>
X-From: git-owner@vger.kernel.org Fri Dec 04 21:16:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGea9-0008EG-PG
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 21:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757237AbZLDUQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 15:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757229AbZLDUQh
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 15:16:37 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:33579 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757140AbZLDUQh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 15:16:37 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id C87571C159B5;
	Fri,  4 Dec 2009 21:16:42 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 2408D90573;
	Fri,  4 Dec 2009 21:16:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id 42MLmf-DjfCO; Fri,  4 Dec 2009 21:16:40 +0100 (CET)
Received: from igel.home (DSL01.83.171.145.25.ip-pool.NEFkom.net [83.171.145.25])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Fri,  4 Dec 2009 21:16:40 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 5554ACA28C; Fri,  4 Dec 2009 21:16:40 +0100 (CET)
X-Yow: I can see you GUYS an' GALS need a LOT of HELP...You're all very
 STUPID!!  I used to be STUPID, too..before I started watching UHF-TV!!
In-Reply-To: <20091204174458.GV17192@gradx.cs.jhu.edu> (Nathaniel W. Filardo's
	message of "Fri, 4 Dec 2009 12:44:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134569>

Nathaniel W Filardo <nwf@cs.jhu.edu> writes:

> On this machine,
>
> mirrors hydra:/tank0/mirrors/misc% uname -a
> FreeBSD hydra.priv.oc.ietfng.org 9.0-CURRENT FreeBSD 9.0-CURRENT #13: Sat Nov 14 19:40:25 EST 2009 root@hydra.priv.oc.ietfng.org:/systank/obj/systank/src/sys/NWFKERN  sparc64
>
> attempting to fetch from an svn source yields the following error:
>
> rs hydra:/tank0/mirrors/misc% git svn init -s https://joshua.svn.sourceforge.net/svnroot/joshua test-joshua
> Initialized empty Git repository in /tank0/mirrors/misc/test-joshua/.git/                                       
> mirrors hydra:/tank0/mirrors/misc% cd test-joshua                                                               
> mirrors hydra:/tank0/mirrors/misc/test-joshua% git svn fetch
>         A       scripts/distributedLM/config.template       
> [...]
>         A       build.xml
> r1 = fe84a7d821ec6d92da75133ac7ad1deb476b6484 (refs/remotes/trunk)
> error: index uses  extension, which we do not understand
> fatal: index file corrupt
> write-tree: command returned error: 128

I could not reproduce that on powerpc (both 32bit and 64bit).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
