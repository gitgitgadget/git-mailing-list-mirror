From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Re: git, porcelain, darcs, and version 1.0
Date: Mon, 18 Jul 2005 21:49:01 +0200
Message-ID: <7id5pfx5ci.fsf@lanthane.pps.jussieu.fr>
References: <7islyev5s4.fsf@lanthane.pps.jussieu.fr>
	<42DB341D.6050506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	darcs-devel@darcs.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 21:50:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dubcw-0001Cn-TP
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 21:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVGRTtc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 15:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVGRTtc
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 15:49:32 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:12488 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id S261584AbVGRTt3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2005 15:49:29 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr [134.157.168.1])
          by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j6IJnPbk015735
          ; Mon, 18 Jul 2005 21:49:26 +0200 (CEST)
X-Ids: 168
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr [134.157.168.57])
          by hydrogene.pps.jussieu.fr (8.13.4/jtpda-5.4) with ESMTP id j6IJnHV5008387
          ; Mon, 18 Jul 2005 21:49:19 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.50)
	id 1Dubbz-0002He-HJ; Mon, 18 Jul 2005 21:49:11 +0200
To: Bryan Larsen <bryan.larsen@gmail.com>
In-Reply-To: <42DB341D.6050506@gmail.com> (Bryan Larsen's message of "Mon, 18 Jul 2005 00:46:21 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2 (shiva.jussieu.fr [134.157.0.168]); Mon, 18 Jul 2005 21:49:26 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 42DC07C5.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> I certainly don't think the lib interface is anywhere near stable:
> Linus accepted my change to index_fd far too easily.

Noted, thanks for the info.

(This makes a lot of sense, Git is evolving very fast.  I haven't
looked at Git since mid-April, and I'm very much impressed at the
difference between 0.6 and 0.99.)

> Ugh.  That's what they do in the commercial world.  We have it so much
> better here in Linux & BSD land: you just add a "depends libgit1" line
> to your package, and the right thing happens: minor updates happen
> automatically and changes that break the interface don't.

This is, of course, only possible when there are stable interfaces,
which in turn make change problematic.  (Which, as far as I
understand, is the very reason why the Linux kernel tree contains
everyone's and his brother's driver rather than having a stable module
ABI, but that's besides the point.)

> Darcs and git work together to determine the minimal amount
> that needs to go into libgit1.so.

Hold on...  Nobody is speaking about *binary* compatibility, it's
source-level compatibility that we need.  There is absolutely no
reason to introduce the complexities of shared libraries into the
picture.

                                        Juliusz
