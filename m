From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
Date: Sat, 29 Apr 2006 22:58:45 +0200
Organization: At home
Message-ID: <e30k0n$ij5$1@sea.gmane.org>
References: <20060429165151.2570.qmail@science.horizon.com> <e30b48$ovk$1@sea.gmane.org> <7viros1585.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Apr 29 22:58:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZwWo-0004cx-Ja
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 22:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWD2U6N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 29 Apr 2006 16:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWD2U6N
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 16:58:13 -0400
Received: from main.gmane.org ([80.91.229.2]:21225 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750717AbWD2U6N (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Apr 2006 16:58:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FZwVz-0004Uj-Cr
	for git@vger.kernel.org; Sat, 29 Apr 2006 22:58:07 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Apr 2006 22:58:07 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Apr 2006 22:58:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19317>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>>  * "prior" - heads=A0that=A0represent=A0topic=A0branch=A0merges
>=20
> This is not any different from usual "parent" at all (but you
> have to think about it a bit to realize it).
[cut]
Thanks for an explanation.

I would say that "prior" is not THAT different from usual "parent",
rather than it is not ANY different.

My doubts about recording previous head of a "union" (pu-like) branch=20
is that for merge (e.g. 'pu' to 'next', cherrypick to/from 'pu', 'pu'
rebase) is that for merge algorithm all parents are equivalent, with
eventual exception of first which can be treated special ('ours').

--=20
Jakub Narebski
Warsaw, Poland
