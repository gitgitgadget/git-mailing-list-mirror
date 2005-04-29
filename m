From: Tom Lord <lord@emf.net>
Subject: RE: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 13:26:31 -0700 (PDT)
Message-ID: <200504292026.NAA28131@emf.net>
References: <000e01c54cf7$f61ee4a0$9b11a8c0@allianceoneinc.com>
Cc: noel@zhtwn.com, seanlkml@sympatico.ca, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 22:26:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRc2n-0006w4-Mr
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbVD2U24 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbVD2U1B
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:27:01 -0400
Received: from emf.emf.net ([205.149.0.19]:62473 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S262962AbVD2U0g (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 16:26:36 -0400
Received: (from lord@localhost) by emf.net (K/K) id NAA28131; Fri, 29 Apr 2005 13:26:31 -0700 (PDT)
To: Andrew.Timberlake-Newell@AllianceOneInc.com
In-reply-to: <000e01c54cf7$f61ee4a0$9b11a8c0@allianceoneinc.com> (Andrew.Timberlake-Newell@AllianceOneInc.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



  > It looks to me like he did read carefully.

  > There were two different ideas:
  >   TL)  Passing tree & diff and trusting diff to create tree
  >   NM)  Passing tree and generating diff versus local tree for review

Well, I guess *you* didn't read carefully.  I also spoke about the
value of passing around triples: ancestry, diff, and tree.  The
question is about linking signatures to things that humans can
reasonably *intend* and be reasonably held accountable for, hence one
of the values of signed diffs.  (I cited other practical reasons to
value signed diffs and use them in specific ways, too.)

-t
