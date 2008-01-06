From: David Soria Parra <sn_@gmx.net>
Subject: Re: how to use git merge -s subtree?
Date: Sun, 06 Jan 2008 03:28:06 +0100
Message-ID: <47803CB6.4050102@gmx.net>
References: <20080105230004.GY29972@genesis.frugalware.org>	<BAYC1-PASMTP12374B54BA370A1E1C6E78AE4E0@CEZ.ICE>	<flpah7$beg$2@ger.gmane.org> <BAYC1-PASMTP01FC193EA959D148F19374AE4E0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sun Jan 06 03:28:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBLFi-0003QF-Um
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 03:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbYAFC2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 21:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbYAFC2Q
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 21:28:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:45688 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751628AbYAFC2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 21:28:16 -0500
Received: (qmail invoked by alias); 06 Jan 2008 02:28:14 -0000
Received: from p57AEE59D.dip.t-dialin.net (EHLO [192.168.120.101]) [87.174.229.157]
  by mail.gmx.net (mp042) with SMTP; 06 Jan 2008 03:28:14 +0100
X-Authenticated: #4427663
X-Provags-ID: V01U2FsdGVkX18Q7vBQNaIQCuRv3RNKK0MJ2aMhVhjVucdl43XROh
	qPkqivu/ASLw9M
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <BAYC1-PASMTP01FC193EA959D148F19374AE4E0@CEZ.ICE>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69703>

Sean wrote:
>
> David,
>
> Yes, the reason to start with the "--no-commit" merge is so that the history
> is properly connected once you do the final commit step.  However, I should
> have noted in my original message that none of the steps actually use the
> subtree merge.  Instead they simply prepare a repository such that
> future merging can be done with:
>
>    $ git merge -s subtree B/master.
>
> Cheers,
> Sean

Well yes the history is preserved, but it's not connected to the
subdirectory. So you cannot do git-log B/foo.c as git doesnot know where
to search it as it thinks
it is in /foo.c not in B/foo.c

Cheers
