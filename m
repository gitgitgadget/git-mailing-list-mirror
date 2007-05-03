From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [git-svn PATCH] Add --no-rebase option to git-svn dcommit
Date: Thu, 03 May 2007 08:48:21 +0200
Message-ID: <87647aqu6i.fsf@morpheus.local>
References: <20070503054749.20115.53805.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 10:53:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjX4B-0003i4-EO
	for gcvg-git@gmane.org; Thu, 03 May 2007 10:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbXECIxc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 3 May 2007 04:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbXECIxb
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 04:53:31 -0400
Received: from main.gmane.org ([80.91.229.2]:33733 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030455AbXECIxa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 04:53:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HjX3h-0004D3-KV
	for git@vger.kernel.org; Thu, 03 May 2007 10:53:05 +0200
Received: from oden.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 May 2007 10:53:05 +0200
Received: from davidk by oden.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 May 2007 10:53:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: oden.vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:cPPn4FJuvBmf8lfb7bkWF16yyks=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46075>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> git-svn dcommit exports commits to Subversion, then imports them back
> to git again, and last but not least rebases or resets HEAD to the
> last of the new commits. I guess this rebasing is convenient when
> using just git, but when the commits to be exported are managed by
> StGIT, it's really annoying. So add an option to disable this
> behavior. And document it, too!
>
> Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
> ---
>
> Arguably, the switch should be --rebase instead, and default to not
> rebase. But that would change the existing behavior, and possibly mak=
e
> dcommit less convenient to use for at least the person who implemente=
d
> the existing behavior. Opinions?

I don't agree.  The rebase behaviour makes perfect sense in the normal
case, and I've been using it without problems.  The special case is
when you start using stgit, so that's when you need to tell dcommit to
do something out of the ordinary.

Other than that, I like your patch.  But you knew that already :-)

--=20
David K=C3=A5gedal
