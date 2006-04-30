From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
Date: Sun, 30 Apr 2006 17:21:37 +0200
Organization: At home
Message-ID: <e32kkf$amc$1@sea.gmane.org>
References: <20060429165151.2570.qmail@science.horizon.com> <e30b48$ovk$1@sea.gmane.org> <7viros1585.fsf@assigned-by-dhcp.cox.net> <e30k0n$ij5$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Apr 30 17:21:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaDjY-0003Fr-0d
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 17:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWD3PVI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 30 Apr 2006 11:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWD3PVI
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 11:21:08 -0400
Received: from main.gmane.org ([80.91.229.2]:62120 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751151AbWD3PVG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Apr 2006 11:21:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FaDjI-0003DJ-Od
	for git@vger.kernel.org; Sun, 30 Apr 2006 17:21:00 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Apr 2006 17:21:00 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Apr 2006 17:21:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19341>

Jakub Narebski wrote:

> Junio C Hamano wrote:
>=20
>> Jakub Narebski <jnareb@gmail.com> writes:
>>=20
>>>  * "prior" - heads=A0that=A0represent=A0topic=A0branch=A0merges
>>=20
>> This is not any different from usual "parent" at all (but you
>> have to think about it a bit to realize it).
> [cut]
> Thanks for an explanation.
>=20
> I would say that "prior" is not THAT different from usual "parent",
> rather than it is not ANY different.
>=20
> My doubts about recording previous head of a "union" (pu-like) branch
> is that for merge (e.g. 'pu' to 'next', cherrypick to/from 'pu', 'pu'
> rebase) is that for merge algorithm all parents are equivalent, with
> eventual exception of first which can be treated special ('ours').

Additionally with "prior" (or at least some convention on which of pare=
nts
is to prior head of "union (pu-like) branch) I think we could fast-forw=
ard
such branches...

--=20
Jakub Narebski
Warsaw, Poland
