X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Wed, 29 Nov 2006 19:18:58 +0100
Organization: At home
Message-ID: <ekkir2$6fq$1@sea.gmane.org>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home> <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net> <87bqmswm1e.wl%cworth@cworth.org> <7vodqse90q.fsf@assigned-by-dhcp.cox.net> <87ac2cwha4.wl%cworth@cworth.org> <7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net> <878xhwwdyj.wl%cworth@cworth.org> <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net> <7vd5786opj.fsf@assigned-by-dhcp.cox.net> <871wnnwi3k.wl%cworth@cworth.org> <7virgzuf38.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611291234350.9647@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 29 Nov 2006 18:18:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 47
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32654>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpU0c-0003dx-Pr for gcvg-git@gmane.org; Wed, 29 Nov
 2006 19:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935979AbWK2SSL convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006 13:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935996AbWK2SSL
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 13:18:11 -0500
Received: from main.gmane.org ([80.91.229.2]:45261 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935979AbWK2SSK (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 13:18:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GpU0F-0003XJ-21 for git@vger.kernel.org; Wed, 29 Nov 2006 19:17:51 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 29 Nov 2006 19:17:51 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 29 Nov 2006
 19:17:51 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Nicolas Pitre wrote:

> But my point is: why not making a very little change to the default=20
> commit behavior. Really little change involving -a being the default.=
 =A0
> The impact on newbies will be significant as they won't have to grok=20
> everything at once to make sense of this -a we are telling them to us=
e=20
> blindly. And it will sort of match known expectations to commit=20
> everything dirty.
>=20
> And actually my point above is that in many cases, maybe the majoryty=
 of=20
> those case but this is arguable, what one is doing is not keeping dir=
ty=20
> and uncommited state around but rather committing every changes all t=
he=20
> time. =A0In _that_ case, which might not be all the time but often en=
ough,=20
> then using -a is annoying[1].
>=20
> So having -a the default makes GIT much more friendly to new users. =A0=
You=20
> "add" files, you "commit", you edit some files, you "commit" again, a=
nd=20
> everything works fine, and you are happy and starts feeling good abou=
t=20
> GIT.
>=20
> Now for those who've seen the light and want to use the index it is n=
ot=20
> much of a bother to add a -i to their commit invokation. =A0At this p=
oint=20
> if you understand the index you know what you're doing, and using -i=20
> won't bother you as much it bothered you to use -a without knowing=20
> why when you was a newbie.
>=20
> But still, if you are a GIT old fart and have difficulties switching=20
> habits, or if you simply are the kind with dirty not-to-commit state =
in=20
> your tree and adding -i all the time bothers you just like [1] above,=
=20
> then there is a way out! =A0You are a GIT expert at this point of cou=
rse=20
> and certainly know how to add an alias for the -i to be implicit with=
=20
> your "commit".
>=20
> Therefore I think this is much more logical to ask the experts to add=
 an=20
> alias for "commit -i" than asking such tricks from less experienced=20
> users. This is all my point is about.

But for different reasons this alias cannot be named "commit". So you c=
annot
with alias make "git commit" (with -a by default) work with index.=20

If "git commit -a" by default heresy ;-) was accepted, I'd rather it be=
 via
configuration option.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

