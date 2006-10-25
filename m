X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Combined diff format documentation
Date: Thu, 26 Oct 2006 00:58:39 +0200
Organization: At home
Message-ID: <ehoq5r$8h5$1@sea.gmane.org>
References: <ehoo2k$1g6$1@sea.gmane.org> <7vejswkoi4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 25 Oct 2006 22:58:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 32
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30122>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcrhc-0004Zy-K3 for gcvg-git@gmane.org; Thu, 26 Oct
 2006 00:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422640AbWJYW6Z convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006 18:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbWJYW6Z
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 18:58:25 -0400
Received: from main.gmane.org ([80.91.229.2]:233 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1161067AbWJYW6Y (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 18:58:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GcrhU-0004YB-0M for git@vger.kernel.org; Thu, 26 Oct 2006 00:58:20 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 00:58:20 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 00:58:20 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>> 6. Documentation/diff-format.txt explains combined and condensed com=
bined
>> =A0 =A0format quite well, although it doesn't tell us if we can have=
 plusses and
>> =A0 =A0minuses together in one line...
>=20
> But you already know the answer to that question, since you
> asked me a few days ago ;-).

Yes, in "[RFC] Syntax highlighting for combined diff" thread
http://permalink.gmane.org/gmane.comp.version-control.git/29566

Well, the _documentation_ doesn't tell. I haven't fully grokked the cod=
e
for generating and coloring combined diff output besides the fact that
I think it uses last indicator ('+' or '-') to chose color for the rest
of line. You said that even if the possibility exist, it is extreme
unlikely.

> Patches to documentation would be easier to comment on and more
> productive, I guess.

I was not sure about output. All conclusions about combined diff output
are from examples; I've planned to send patch to documentation when I'l=
l
be sure that at least _most_ of what I've added is correct.

Will do.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

