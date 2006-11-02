X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: Re: Suggestion: drop 'g' in git-describe suffix
Date: Thu, 02 Nov 2006 15:48:24 +0100
Message-ID: <454A0538.9000104@iaglans.de>
References: <eibh94$t7n$1@sea.gmane.org> <45494E20.1000503@shadowen.org>	 <4549C083.9060805@xs4all.nl> <4549CA6B.4090909@shadowen.org>	 <4549CE2A.3010808@xs4all.nl> <8aa486160611020312v42047716t6a13e6fa16eeae8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 2 Nov 2006 14:49:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
In-Reply-To: <8aa486160611020312v42047716t6a13e6fa16eeae8@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30754>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfds5-0001ed-C1 for gcvg-git@gmane.org; Thu, 02 Nov
 2006 15:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751091AbWKBOsi convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006 09:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWKBOsi
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 09:48:38 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:38150 "EHLO
 vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP id
 S1751091AbWKBOsh (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006
 09:48:37 -0500
Received: from localhost (localhost [127.0.0.1]) by
 vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id F1BD93F7B for
 <git@vger.kernel.org>; Thu,  2 Nov 2006 15:48:35 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1]) by localhost
 (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1-3QzpYy9Xs9 for <git@vger.kernel.org>; Thu,  2 Nov 2006
 15:48:15 +0100 (CET)
Received: from [192.168.100.26] (hermes.lan.home.vilz.de [192.168.100.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with
 ESMTP id AC7BD3ED2 for <git@vger.kernel.org>; Thu,  2 Nov 2006 15:48:12 +0100
 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Santi B=E9jar wrote:
> On 11/2/06, Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:
>> Andy Whitcroft escreveu:
>> > Han-Wen Nienhuys wrote:
>> >>
>> >>   tag+sha1
>> >>
>> >> to separate the tag and the committish.
>> >
>> > Well there is a non-alphabet character in there, a minus (-).  The=
 g
>> > prefix on the sha1 _fragment_ it to indicate that it is in fact a
>> > truncated sha1, not a complete one.
>=20
> I think it is there to indicate it is a git commit sha1.
>=20
>>
>> is this policy documented somewhere?  None of the tools understand i=
t.
>>
>> [lilydev@haring git]$ git describe
>> v1.4.3.3-g1e1f76e
>> [lilydev@haring git]$ git show g1e1f76e
>> fatal: ambiguous argument 'g1e1f76e': unknown revision or path not i=
n
>> the working tree.
>> Use '--' to separate paths from revisions
>>
>=20
> Use the complete output of describe:
> $ git show v1.4.3.3-g1e1f76e

this one doesn't work for me in my repository.

$ git-describe
release_1_22_v0.7-g85eb121

$ git show release_1_22_v0.7-g85eb121
fatal: ambiguous argument 'release_1_22_v0.7-g85eb121': unknown revisio=
n=20
or path not in the working tree.
Use '--' to separate paths from revisions


> or the abbrev sha1:
> $ git show 1e1f76e
this one works with my repository

$ git show 85eb121

i use git version 1.4.2.rc2.g2686c

(that was next branch of git one or two days ago or so..)

it would be great to let the full output of git describe work as well.

Sincerly
