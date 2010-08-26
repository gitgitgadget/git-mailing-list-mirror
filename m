From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Remote corruption issue, linked to thin pack code?
Date: Thu, 26 Aug 2010 09:13:59 +0200
Message-ID: <201008260914.00741.trast@student.ethz.ch>
References: <201008252253.26521.trast@student.ethz.ch> <alpine.LFD.2.00.1008252107070.622@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, Jonas Thiem <contact@eloxoph.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Aug 26 09:14:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoWfT-0000F2-Nz
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 09:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026Ab0HZHO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 03:14:27 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:35847 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998Ab0HZHOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 03:14:25 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 26 Aug
 2010 09:14:24 +0200
Received: from thomas.site (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.0.702.0; Thu, 26 Aug
 2010 09:14:03 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <alpine.LFD.2.00.1008252107070.622@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154527>

Nicolas Pitre wrote:
> > The respective repos show no errors with git-fsck.
> 
> What about 'git fsck --full'?  Given git v1.5.4 on the remote, you 
> should try --full with 'git fsck' as this wasn't the default back then.

Well, I instructed him to try --full, as you can see in the
conversation:

  http://colabti.org/irclogger/irclogger_log/git?date=2010-08-25#l2196

Nothing interesting.

> >   http://eloxoph.com/localrepo.zip
> >   http://eloxoph.com/remoterepo.zip
> 
> 2010-08-25 21:24:52 ERROR 404: Not Found.

Hrm.  Apparently a mis-edit on my part, it should be

  http://eloxoph.com/remoteserverrepo.zip

> How do you know it is there while git (on the remote) is telling you it 
> is not?
> 
> What about 'git cat-file -t e28ae6b61c384732c506' ?

It's fine in my unpacked copy.  Jonas, what were the results on the
server?

> Maybe after I can reproduce this issue locally.

As a side note, I couldn't reproduce locally with the above repos but
then I didn't have the time to downgrade to 1.5.4.

Jonas also has to answer the rest of the questions for obvious
reasons.  (I'm away from the net for a few days anyway...)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
