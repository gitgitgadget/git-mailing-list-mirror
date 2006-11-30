X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Make git-commit cleverer - have it figure out whether it needs -a automatically
Date: Thu, 30 Nov 2006 17:28:15 +0100
Organization: At home
Message-ID: <ekn0ne$nuk$1@sea.gmane.org>
References: <fcaeb9bf0611300532x77c7fc8aq2ba77ff57b81cc05@mail.gmail.com> <200611301501.43436.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 30 Nov 2006 16:27:28 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 26
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32769>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpokg-0001hM-7Q for gcvg-git@gmane.org; Thu, 30 Nov
 2006 17:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030715AbWK3Q1G convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006 11:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759257AbWK3Q1G
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 11:27:06 -0500
Received: from main.gmane.org ([80.91.229.2]:55480 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1758520AbWK3Q1E (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 11:27:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GpokP-0001cy-H7 for git@vger.kernel.org; Thu, 30 Nov 2006 17:26:55 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 17:26:53 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 30 Nov 2006
 17:26:53 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

> Raimund Bauer offered this suggestion (paraphrased):
>=20
> "Maybe we could do git-commit -a =A0_only_ if the index matches HEAD,=
 and
> otherwise keep current behavior? =A0So people who don't care about th=
e
> index won't get tripped up, and when you do have a dirty index, you g=
et
> told about it?"
>=20
> Johannes Schindelin pointed out that this isn't the right thing to do=
 for
> an --amend, so that is checked for. Additionally, it's probably not t=
he
> right thing to do if any files are specified with "--only" or
> "--include", so they turn this behaviour off as well.
>=20
> Nguyen Thai Ngoc Duy asked that git-commit let you know it's done thi=
s
> by adding an extra comment to the commit message.

Insount on #git pointed out fragility of this solution with respect
to adding/removing/moving files, which dirties index (which might not b=
e
understood by newbie user: "git commit" used to work, but doesn't work =
the
same when I added some files).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

