X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Sun, 26 Nov 2006 10:43:41 +0100
Organization: At home
Message-ID: <ekbnhe$naq$1@sea.gmane.org>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net> <ekafpm$fs7$1@sea.gmane.org> <20061126033433.GD29394@spearce.org> <7vvel2yi2u.fsf@assigned-by-dhcp.cox.net> <20061126042311.GB30001@spearce.org> <7vk61iyeq4.fsf@assigned-by-dhcp.cox.net> <20061126073942.GA30518@spearce.org> <7v1wnqwoxz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 26 Nov 2006 09:42:40 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32339>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoGWw-00027l-5H for gcvg-git@gmane.org; Sun, 26 Nov
 2006 10:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935292AbWKZJm1 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006 04:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935297AbWKZJm1
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 04:42:27 -0500
Received: from main.gmane.org ([80.91.229.2]:51159 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935292AbWKZJm0 (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 04:42:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GoGWc-00024S-Nc for git@vger.kernel.org; Sun, 26 Nov 2006 10:42:14 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 26 Nov 2006 10:42:14 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 26 Nov 2006
 10:42:14 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> =A0* Subsequent fetch, when the glob is not '+' variant, would
> =A0 =A0download the config from the remote in order to see which are
> =A0 =A0marked as "rewinds", and ignores the branches that are marked
> =A0 =A0as such.
>=20
> I am a bit unhappy that subsequent fetches have to re-read the
> remote config every time. =A0I can sort-of-see we can cram the
> "this is expected to be rewound" information as part of
> peek-remote exchange to avoid the overhead, but I do not think
> it is easily doable for dumb transports without breaking the
> backward compatibility.

Perhaps below the "Pull: refs/heads/*:refs/remotes/origin/*" (or config
equivalent) we should list (in some format) branches which are not to b=
e
fetched becaus they don't fast forward. One option, namely
  Pull:-refs/heads/pu:refs/remotes/origin/pu
(or config equivalent)comes to mind. It has the advantage that when we
decide to fetch this branch, it would be as easy as changing '-' to '+'=
=2E
Or we can use '!' instead of '-' if you think it is more readable (prob=
ably
is).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

