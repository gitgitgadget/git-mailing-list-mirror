From: Sam Vilain <sam@vilain.net>
Subject: Re: linearising TopGit forests into patch series (was: [ANNOUNCE]
	TopGit - A different patch queue manager)
Date: Sat, 09 Aug 2008 14:09:33 +1200
Message-ID: <1218247773.17053.32.camel@maia.lan>
References: <20080803031424.GV32184@machine.or.cz>
	 <20080807175623.GA16833@lapse.rw.madduck.net>
	 <36ca99e90808071258h62b65981s20a5b053d9bc5754@mail.gmail.com>
	 <20080808170658.GA16055@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	vcs distro packaging discussion list 
	<vcs-pkg-discuss@lists.alioth.debian.org>
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Sat Aug 09 04:10:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRdun-00060Y-4z
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 04:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764AbYHICJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 22:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbYHICJm
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 22:09:42 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:34361 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbYHICJm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 22:09:42 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 3785821C95A; Sat,  9 Aug 2008 14:09:40 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,RDNS_DYNAMIC
	autolearn=no version=3.2.3
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 718CB21C8E0;
	Sat,  9 Aug 2008 14:09:33 +1200 (NZST)
In-Reply-To: <20080808170658.GA16055@lapse.rw.madduck.net>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91741>

On Fri, 2008-08-08 at 14:06 -0300, martin f krafft wrote:
> Hm, I am not entirely following. I understand that I can get
> a topological list of branches, but why don't I need the diff from
> branch-base to branch-head?

Well, if the patches can be assembled into it, why would you?

> Also, what happens if branches cross-merge?

Not really a problem, just need to provide a diff against one (or even
both) of the merge bases to the merge commit, and have it labeled as
being a relatively disinteresting patch that merges X with Y.

Sam.
