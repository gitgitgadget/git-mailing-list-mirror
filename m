X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add branch.*.localmerge and documentation update
Date: Fri, 08 Dec 2006 22:48:17 +0100
Organization: At home
Message-ID: <elcmen$pm6$1@sea.gmane.org>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com> <8aa486160612071756s18f9530cr7ed26e4b7b47d1de@mail.gmail.com> <200612081823.45565.Josef.Weidendorfer@gmx.de> <200612082012.19167.Josef.Weidendorfer@gmx.de> <8aa486160612081252t1e245104x58c8a6654d887af5@mail.gmail.com> <7vr6vagja6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 8 Dec 2006 21:50:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 41
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33753>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsnbl-0002AH-5K for gcvg-git@gmane.org; Fri, 08 Dec
 2006 22:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947388AbWLHVuO convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006 16:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947392AbWLHVuN
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 16:50:13 -0500
Received: from main.gmane.org ([80.91.229.2]:56726 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1947388AbWLHVuM
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 16:50:12 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GsnbW-0002Z2-Bb for git@vger.kernel.org; Fri, 08 Dec 2006 22:50:02 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 22:50:02 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 08 Dec 2006
 22:50:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

<opublikowany i wys=B3any>

Junio C Hamano wrote:

> "Santi B=E9jar" <sbejar@gmail.com> writes:
>=20
>> On 12/8/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
>>> Clarify the meaning of branch.*.merge option and add a similar
>>> branch.*.localmerge option, which can be used to specify a local
>>> tracking branch to be merged by default.
>>>
>>> Previously, if branch.*.merge was specified but did not match any
>>> ref, the message "No changes." was not really helpful regarding
>>> the misconfiguration. This now gives a warning.
[...]
>>
>> Ack for the documentation part. But the localmerge part is almost
>> equivalent to my patch to allow the branch.<name>.remote equal to ".=
".
>=20
> I am not so sure about the "localmerge" stuff anymore.
>=20
> What convenience would it buy us (including but not limited to
> new people), and if there is any, would that outweigh the
> potential confusion factor to have two different configuration
> variables that do exactly the same thing whose sole difference
> is which side of the fetched branch namespace it uses to specify
> the merge source?

What about my proposal to allow for full refspec, or :<localbranch>
to be specified? I.e. allow all the following forms:
  branch.<name>.merge =3D refs/heads/<remotebranch>
  branch.<name>.merge =3D refs/heads/<remotebranch>:refs/remotes/<remot=
e>/<localbranch>
  branch.<name>.merge =3D :refs/remotes/<remote>/<localbranch>

By the way, if branch.*.remote is equal to ".", remote branch is
local branch.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

