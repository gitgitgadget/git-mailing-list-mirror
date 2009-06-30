From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Team Coherence to Git conversion
Date: Tue, 30 Jun 2009 07:41:28 -0700
Message-ID: <20090630144128.GR11191@spearce.org>
References: <h2cmv6$agp$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 17:01:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward2.uio.no ([129.240.10.71])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLemN-0002T1-3N
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 16:57:51 +0200
Received: from exim by mail-out2.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLeWh-00087l-6g
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 16:41:39 +0200
Received: from mail-mx6.uio.no ([129.240.10.47])
	by mail-out2.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLeWh-00087i-5g
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 16:41:39 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx6.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLeWf-0001So-Ez
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 16:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757959AbZF3Ol1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 10:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753614AbZF3Ol1
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 10:41:27 -0400
Received: from george.spearce.org ([209.20.77.23]:45780 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757959AbZF3Ol0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 10:41:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EDB77381FD; Tue, 30 Jun 2009 14:41:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <h2cmv6$agp$1@ger.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3, uiobl=NO, uiouri=_URIID_)
X-UiO-Scanned: FEFEDF4FE007B402AFDE74414D2FA504DAD9C2BB
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 154 total 2547832 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122518>

Graeme Geldenhuys <graemeg@gmail.com> wrote:
> We have a couple (actually around 20) projects sitting in Team
> Coherence repositories. Luckily they have very little history. Before
> I joined the company nobody used revision control software - just
> simple zip archives once a week (if that many).
>
> Does anybody know of a tool that can convert a TC repository to
> Git? TC seems to be dying a slow dead, and I don't want our code
> to get trapped in proprietary software we can't access, a few years
> down the line.

Huh.  TC reminds me of PVCS Version Manager.  Lots of hype on
the web page, but a tool from the early 1980s that still can't
do anything useful.  Hell, it might be a rebranded PVCS VM.

No, there aren't any existing import tools from TC, in fact probably
nobody here has even heard of TC before.  You are on your own to
write an import tool.

You might want to look at using git-fast-import to handle the git
side of the conversion, but you'll need to write your own script
to mine the data out of TC and format it for git-fast-import.
Look at contrib/fast-import for some examples, and the fast-import
man page is rather extensive.

-- 
Shawn.
