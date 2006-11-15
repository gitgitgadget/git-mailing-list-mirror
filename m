X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 19:28:41 +0100
Organization: At home
Message-ID: <ejfm6c$bu4$1@sea.gmane.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 15 Nov 2006 18:28:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 27
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31461>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkPUf-0005j0-KO for gcvg-git@gmane.org; Wed, 15 Nov
 2006 19:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030814AbWKOS1y convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006 13:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030816AbWKOS1y
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 13:27:54 -0500
Received: from main.gmane.org ([80.91.229.2]:46736 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1030814AbWKOS1x (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 13:27:53 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GkPTw-0005aL-5Z for git@vger.kernel.org; Wed, 15 Nov 2006 19:27:32 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 19:27:32 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 15 Nov 2006
 19:27:32 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:

> But the fact is, git isn't really that hard to work out, and the comm=
ands=20
> aren't that complicated. There's no reason to rename them. We do have=
=20
> other problems:
>=20
> =A0- default branch selection for merging is broken (it should defini=
tely=20
> =A0 =A0take the current branch into account). When I do "git pull" wi=
th no=20
> =A0 =A0branch specification, and I happen to be on a branch that is a=
ssociated=20
> =A0 =A0with something else than "master" in the remote, I shouldn't m=
erge with=20
> =A0 =A0master.

This problem is _slightly_ migitated by branch.<name>.merge config vari=
able.
Slightly because you have to specify branch to merge, instead of forbid=
ding
merge if you are not on specific branch (and you don't override it).

> =A0- I agree that having to create temporary branches to just look at=
 a tag=20
> =A0 =A0that you don't want to actually develop on is just unnecessari=
ly=20
> =A0 =A0bothersome.

Agreed.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

