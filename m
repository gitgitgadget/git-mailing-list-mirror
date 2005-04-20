From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Wed, 20 Apr 2005 09:52:21 +0200
Message-ID: <7i3btlubpm.fsf@lanthane.pps.jussieu.fr>
References: <20050418210436.23935.qmail@science.horizon.com>
	<1113869248.23938.94.camel@orca.madrabbit.org>
	<42645969.2090609@qualitycode.com>
	<1113874931.23938.111.camel@orca.madrabbit.org>
	<4264677A.9090003@qualitycode.com>
	<1113950442.29444.31.camel@orca.madrabbit.org>
	<42658E38.1020406@qualitycode.com>
	<1113951972.29444.42.camel@orca.madrabbit.org>
	<426594F9.4090002@tupshin.com>
	<1113959503.29444.91.camel@orca.madrabbit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 20 09:48:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO9wi-0000Dn-BP
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 09:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVDTHwi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 03:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVDTHwi
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 03:52:38 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:38348 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id S261428AbVDTHw0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 03:52:26 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr [134.157.168.1])
          by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j3K7qNXk070132
          ; Wed, 20 Apr 2005 09:52:23 +0200 (CEST)
X-Ids: 164
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr [134.157.168.57])
          by hydrogene.pps.jussieu.fr (8.13.3/jtpda-5.4) with ESMTP id j3K7qL6E024014
          ; Wed, 20 Apr 2005 09:52:22 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.34)
	id 1DOA0T-000219-Gy; Wed, 20 Apr 2005 09:52:21 +0200
To: git@vger.kernel.org, darcs-devel@darcs.net
In-Reply-To: <1113959503.29444.91.camel@orca.madrabbit.org> (Ray Lee's
 message of "Tue, 19 Apr 2005 18:11:43 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2 (shiva.jussieu.fr [134.157.0.164]); Wed, 20 Apr 2005 09:52:23 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 42660A37.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> However, I'm claiming a token is defined by the file's language, and
> that a replace patch on anything but a token as per those language
> standards is a silly thing.

Please recall the context of this discussion: getting Darcs to grok
git repositories.

You are arguing that it should be possible to design a set of
heuristics that Do The Right Thing often enough.  And you are probably
right.

But the point is immaterial as nobody has stepped up to implement in
Darcs the sort of heuristics you have in mind.  Partly because nobody
has time, but mostly because we don't like heuristics, we prefer Darcs
to remain deterministic.

So while yes, it might be possible to get about using heuristics, it
seems rather unlikely that that's what we'll do.

                                        Juliusz

