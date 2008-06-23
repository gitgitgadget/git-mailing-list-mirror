From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: Incorrect default for git stash?
Date: Mon, 23 Jun 2008 19:14:50 +0200
Message-ID: <87tzfk9iph.fsf@lysator.liu.se>
References: <loom.20080617T220852-922@post.gmane.org> <911589C97062424796D53B625CEC0025E46170@USCOBRMFA-SE-70.northamerica.cexp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 19:16:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KApe5-0006JK-Hg
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 19:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660AbYFWRPE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jun 2008 13:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754824AbYFWRPD
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 13:15:03 -0400
Received: from main.gmane.org ([80.91.229.2]:59710 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752985AbYFWRPB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 13:15:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KApd7-0005Tf-03
	for git@vger.kernel.org; Mon, 23 Jun 2008 17:15:01 +0000
Received: from 80.251.192.3 ([80.251.192.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 17:15:00 +0000
Received: from davidk by 80.251.192.3 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 17:15:00 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 80.251.192.3
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:d06mVRPKzt5i+vEVLeHQEcDsA78=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85889>

<Patrick.Higgins@cexp.com> writes:

> Eric Raible wrote:
>
>> git branch -> list branches
>> git tag    -> list tags
>> git stash  -> create a stash
>
> git commit -> list commits?
> git checkout -> list checkouts?
> git prune -> list prunes?
> git pull -> list pullables?
>
> Why would you expect stash to behave like branch and tag?

Because is kindof does.

I would prefer to have two simple commands

  git stash
  git unstash

and not bother with named stashes etc (for that I use stgit or normal
branches). You'd need a way to clear the stash as well.

--=20
David K=C3=A5gedal
