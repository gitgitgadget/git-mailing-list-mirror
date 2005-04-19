From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Tue, 19 Apr 2005 10:22:21 +0200
Message-ID: <7i7jizyy4i.fsf@lanthane.pps.jussieu.fr>
References: <7ivf6lm594.fsf@lanthane.pps.jussieu.fr>
	<20050418122011.GA13769@abridgegame.org>
	<7iy8bf7fh2.fsf@lanthane.pps.jussieu.fr>
	<1113874991.23938.113.camel@orca.madrabbit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: darcs-devel@darcs.net, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 10:19:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNnwE-0007mI-3m
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 10:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVDSIWc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 04:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVDSIWb
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 04:22:31 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:22247 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id S261405AbVDSIW1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 04:22:27 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr [134.157.168.1])
          by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j3J8MN1A093053
          ; Tue, 19 Apr 2005 10:22:23 +0200 (CEST)
X-Ids: 166
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr [134.157.168.57])
          by hydrogene.pps.jussieu.fr (8.13.3/jtpda-5.4) with ESMTP id j3J8MLY2010162
          ; Tue, 19 Apr 2005 10:22:21 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.34)
	id 1DNnzx-0001ju-HO; Tue, 19 Apr 2005 10:22:21 +0200
To: Ray Lee <ray@madrabbit.org>
In-Reply-To: <1113874991.23938.113.camel@orca.madrabbit.org> (Ray Lee's
 message of "Mon, 18 Apr 2005 18:43:11 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2 (shiva.jussieu.fr [134.157.0.166]); Tue, 19 Apr 2005 10:22:23 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 4264BFBF.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> > Aye, that will require some metadata on the git side (the hack,
> > suggested by Linus, of using git hashes to notice moves won't work).

> So, why won't it work?

Because two files can legitimately have identical contents without
being ``the same'' file from the VC system's point of view.

In other words, two files may happen to have the same contents but
have distinct histories.

                                        Juliusz


