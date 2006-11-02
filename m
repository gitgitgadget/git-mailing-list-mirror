X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Suggestion: drop 'g' in git-describe suffix
Date: Thu, 02 Nov 2006 12:23:05 +0100
Message-ID: <4549D519.4080104@xs4all.nl>
References: <eibh94$t7n$1@sea.gmane.org> <45494E20.1000503@shadowen.org>	 <4549C083.9060805@xs4all.nl> <4549CA6B.4090909@shadowen.org>	 <4549CE2A.3010808@xs4all.nl> <8aa486160611020312v42047716t6a13e6fa16eeae8@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 2 Nov 2006 11:22:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <8aa486160611020312v42047716t6a13e6fa16eeae8@mail.gmail.com>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30734>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfaer-0006II-Lv for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751482AbWKBLWu convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006 06:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbWKBLWu
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:22:50 -0500
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:50700 "EHLO
 smtp-vbr15.xs4all.nl") by vger.kernel.org with ESMTP id S1751482AbWKBLWt
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:22:49 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr15.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kA2BMlpM037197; Thu, 2 Nov 2006 12:22:47 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
Sender: git-owner@vger.kernel.org

Santi B=E9jar escreveu:
> One problem I see with this scheme (either 'g', 'git' of '+') is that
> it does not provide an increasing version number, even for
> fast-forwarding commits. Then it is not useful as a package version
> number (deb or rpm). I've already seen deb packages with
> version+git20061010. One possibility could be to add the number of
> commits between the tag and the commit as:
>=20
> v1.4.3.3-git12g1e1f76e
>=20
> to provide a weak ordering for fast-forwarding commits. What do you t=
hing?

Is that number well defined if you merge branches in between?

I'd prefer

   v1.4.3.3+git-12-1e1f76e

or similar. Pasting together words without separator is bad for readabi=
lity.

--=20
