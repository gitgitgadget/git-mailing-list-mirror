X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Suggestion: drop 'g' in git-describe suffix
Date: Thu, 02 Nov 2006 15:07:53 +0100
Organization: At home
Message-ID: <eicu37$qui$1@sea.gmane.org>
References: <eibh94$t7n$1@sea.gmane.org> <4549C083.9060805@xs4all.nl> <4549CE2A.3010808@xs4all.nl> <8aa486160611020312v42047716t6a13e6fa16eeae8@mail.gmail.com> <4549D519.4080104@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 2 Nov 2006 14:08:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 38
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30752>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfdEq-000288-Gi for gcvg-git@gmane.org; Thu, 02 Nov
 2006 15:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752848AbWKBOII convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006 09:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752891AbWKBOII
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 09:08:08 -0500
Received: from main.gmane.org ([80.91.229.2]:31181 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1752848AbWKBOIF (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 09:08:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GfdER-00021P-Mq for git@vger.kernel.org; Thu, 02 Nov 2006 15:07:47 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 15:07:47 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 02 Nov 2006
 15:07:47 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:

> Santi B=E9jar escreveu:
>> One problem I see with this scheme (either 'g', 'git' of '+') is tha=
t
>> it does not provide an increasing version number, even for
>> fast-forwarding commits. Then it is not useful as a package version
>> number (deb or rpm). I've already seen deb packages with
>> version+git20061010. One possibility could be to add the number of
>> commits between the tag and the commit as:
>>=20
>> v1.4.3.3-git12g1e1f76e
>>=20
>> to provide a weak ordering for fast-forwarding commits. What do you =
thing?
>=20
> Is that number well defined if you merge branches in between?
>=20
> I'd prefer
>=20
>    v1.4.3.3+git-12-1e1f76e
>=20
> or similar. Pasting together words without separator is bad for reada=
bility.

Or even IMVHO better:

    v1.4.3.3+12--1e1f76e

or something like that. v1.4.3.3+12 part meaning that v1.4.3.3 is 12 an=
cestor
in direct shortest direct line, or that v1.4.3.3+12 is 12 generations a=
way
from v1.4.3.3.

Of course that is _costly_ to confitm that, and v1.4.3.3+12 might mean =
more
than one revision in presence of branching points, especially that ther=
e is
no equivalent of "first parent" to distinguish like in case of v1.4.3.3=
~12
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

