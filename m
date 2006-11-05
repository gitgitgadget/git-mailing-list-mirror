X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Sun, 05 Nov 2006 20:29:15 +0100
Organization: At home
Message-ID: <eile19$p7r$1@sea.gmane.org>
References: <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com> <20061102113631.GA30507@diana.vm.bytemark.co.uk> <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com> <20061103095859.GC16721@diana.vm.bytemark.co.uk> <20061103100142.GD16721@diana.vm.bytemark.co.uk> <454B30E4.8000909@shadowen.org> <454B4C43.2040607@shadowen.org> <Pine.LNX.4.64.0611031034520.25218@g5.osdl.org> <20061105114353.GB19707@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0611050831250.25218@g5.osdl.org> <20061105190400.GC25259@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 5 Nov 2006 19:29:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 32
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30981>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgngF-0005wj-Ep for gcvg-git@gmane.org; Sun, 05 Nov
 2006 20:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161532AbWKET3G convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006 14:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161669AbWKET3G
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 14:29:06 -0500
Received: from main.gmane.org ([80.91.229.2]:31911 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1161532AbWKET3F (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 14:29:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Ggnfo-0005qN-Sv for git@vger.kernel.org; Sun, 05 Nov 2006 20:28:53 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 05 Nov 2006 20:28:52 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 05 Nov 2006
 20:28:52 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Karl Hasselstr=F6m wrote:

> These are the headers that StGIT uses without my patch -- that is, th=
e
> headers used to get that error message:
>=20
>   Content-Type: text/plain; charset=3Dutf-8; format=3Dfixed
>   Content-Transfer-Encoding: 8bit
>=20
> Which is obviously not good enough for some picky part of the SMTP
> chain.

I think you are missing MIME-Version: header.

[...]

> Well, it added these headers:
>=20
>   MIME-Version: 1.0
>   Content-Transfer-Encoding: QUOTED-PRINTABLE
>   Content-Type: TEXT/PLAIN; charset=3DISO-8859-1
>=20
> Maybe MIME-Version was the only thing missing? I'll have to try.

MIME-Version _is_ important. I remember that Outlook Express sent news
messages without this header, and those posts were either mangled by ne=
ws
server, or news readers didn't parse MIME headers without MIME-Version:

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

