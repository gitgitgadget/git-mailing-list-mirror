From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Making note, in the repository, of push/pull relationships
Date: Tue, 16 Aug 2005 22:45:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508162241150.19656@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <20050815162519.GB9719@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0508160044490.25894@wgmdd8.biozentrum.uni-wuerzburg.de>
 <20050816160327.GA20016@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 22:46:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E58Jj-00052T-0p
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 22:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703AbVHPUpj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 16:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbVHPUpj
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 16:45:39 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:35025 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932703AbVHPUpi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 16:45:38 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8FEA4E25BF; Tue, 16 Aug 2005 22:45:37 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4FF91AD3A9; Tue, 16 Aug 2005 22:45:37 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D98FFB092C; Tue, 16 Aug 2005 22:45:36 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D5AAFE24C8; Tue, 16 Aug 2005 22:45:35 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20050816160327.GA20016@hpsvcnb.fc.hp.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 16 Aug 2005, Carl Baldwin wrote:

> So, just a question.  What, exactly, is meant by 'cross-pulling'?

When I say "cross-pulling" I mean that a branch is pulled from a remote 
repository, where the named head is called "a", but that reference is 
pulled into the local branch whose head is "b".

Example:

--snip--
> git-ls-remote-script junio

abe0582207c72ec848e78707577c61a98f5c633d        refs/heads/master
c506e5687b9257c6182950f245d58cf839abfae4        refs/heads/pu
1f40c7c24d999675df818f9d7824937a964f9f40        refs/heads/rc
0918385dbd9656cab0d1d81ba7453d49bbc16250        refs/tags/junio-gpg-pub
d6602ec5194c87b0fc87103ca4d67251c76f233a        refs/tags/v0.99
f25a265a342aed6041ab0cc484224d9ca54b6f41        refs/tags/v0.99.1
c5db5456ae3b0873fc659c19fafdde22313cc441        refs/tags/v0.99.2
7ceca275d047c90c0c7d5afb13ab97efdf51bd6e        refs/tags/v0.99.3
b3e9704ecdf48869f635f0aa99ddfb513f885aff        refs/tags/v0.99.4

> git-pull-script junio pu:temporary-proposed-updates

[...]

> echo .git/refs/heads/temporary-proposed-updates

c506e5687b9257c6182950f245d58cf839abfae4
--snap--

So, the remote branch "pu" gets cross-pulled to the local branch 
"temporary-proposed-updates", i.e. to a local branch of a different name.

Ciao,
Dscho
