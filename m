From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [ANNOUNCE] qgit 1.1.1
Date: Mon, 20 Mar 2006 15:46:13 +0100
Message-ID: <20060320144613.GA25617@elte.hu>
References: <e5bfff550603190853m2db7bb38gecc94934c4dfb89e@mail.gmail.com> <20060319214907.GA7294@elte.hu> <e5bfff550603191401h2c206950w1a0e04cd50fc5370@mail.gmail.com> <e5bfff550603191404l7511e76awe980fad51ffde98d@mail.gmail.com> <20060320102022.GA21917@elte.hu> <e5bfff550603200413i22a37a43n4d5a9b0ba63e880d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, proski@gnu.org
X-From: git-owner@vger.kernel.org Mon Mar 20 15:48:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLLgN-00041B-W2
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 15:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWCTOsV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 09:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWCTOsV
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 09:48:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:50377 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932309AbWCTOsV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Mar 2006 09:48:21 -0500
Received: from chiara.elte.hu ([157.181.151.252])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1FLLg9-0000no-IO
	from <mingo@elte.hu>; Mon, 20 Mar 2006 15:48:19 +0100
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 1D8EA1FC2; Mon, 20 Mar 2006 15:48:17 +0100 (CET)
To: Marco Costalba <mcostalba@gmail.com>
Content-Disposition: inline
In-Reply-To: <e5bfff550603200413i22a37a43n4d5a9b0ba63e880d@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Received-SPF: softfail (mx2.mail.elte.hu: transitioning domain of elte.hu does not designate 157.181.151.252 as permitted sender) client-ip=157.181.151.252; envelope-from=mingo@elte.hu; helo=chiara.elte.hu;
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17754>


* Marco Costalba <mcostalba@gmail.com> wrote:

> The wrong command is git-diff-tree -r -c -p 46571...
> 
> I think it's about the quite new option -c of git-diff-tree.
> 
> Please upgrade your git to latest version, better upstream one, but 
> 1.2.4 should be enough.

ok, that did the trick.

there's a weird rendering artifact as well, see the white line in the 
screenshot [that i'll send you in a separate mail]. It goes away if i 
drag another window in front of the qgit window. It happens if i 
double-click a 'merge' branch, exit qgit and start it again [and the 
separator line needs to obscur the commit line just partially]. This is 
an uptodate FC4 installation.

	Ingo
