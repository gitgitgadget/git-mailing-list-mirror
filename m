From: Jeff King <peff@peff.net>
Subject: Re: git commit -a reports untracked files after a clone
Date: Mon, 16 May 2011 06:38:29 -0400
Message-ID: <20110516103829.GA23889@sigill.intra.peff.net>
References: <7B399C74-8048-42BA-8672-9D7964F24888@goli.at>
 <7v39kgr5ln.fsf@alter.siamese.dyndns.org>
 <4501A58F-46F8-410C-BCEF-DD2FC10BC3A5@goli.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Philipp Metzler <phil@goli.at>
X-From: git-owner@vger.kernel.org Mon May 16 12:38:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLvCB-0005KM-CE
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 12:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769Ab1EPKid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 06:38:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36490
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754663Ab1EPKic (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 06:38:32 -0400
Received: (qmail 13092 invoked by uid 107); 16 May 2011 10:40:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 May 2011 06:40:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 May 2011 06:38:29 -0400
Content-Disposition: inline
In-Reply-To: <4501A58F-46F8-410C-BCEF-DD2FC10BC3A5@goli.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173723>

On Sun, May 15, 2011 at 10:26:01AM +0200, Philipp Metzler wrote:

> [phil@Silberpfeil tmp]$ git --version
> git version 1.7.5.1
> [phil@Silberpfeil tmp]$ git clone git://git.kernel.org/pub/scm/git/git.git
> Cloning into git...
> remote: Counting objects: 140383, done.
> remote: Compressing objects: 100% (33498/33498), done.
> remote: Total 140383 (delta 105777), reused 139383 (delta 104980)
> Receiving objects: 100% (140383/140383), 27.61 MiB | 642 KiB/s, done.
> Resolving deltas: 100% (105777/105777), done.
> [phil@Silberpfeil tmp]$ cd git
> [phil@Silberpfeil git]$ git commit -a
> # On branch master
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #	vcs-svn/
> #	xdiff/

Can you try this again with "git commit -uall" so we can see which
specific files in those directories are causing the issue?

-Peff
