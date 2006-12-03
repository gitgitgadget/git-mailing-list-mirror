X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: jgit performance update
Date: Sun, 03 Dec 2006 15:19:36 +0100
Organization: At home
Message-ID: <ekumdo$imo$1@sea.gmane.org>
References: <20061203045953.GE26668@spearce.org> <200612031455.48032.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 3 Dec 2006 14:19:57 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 30
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33113>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqsC5-0002n2-4u for gcvg-git@gmane.org; Sun, 03 Dec
 2006 15:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935199AbWLCOTq convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006 09:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935203AbWLCOTq
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 09:19:46 -0500
Received: from main.gmane.org ([80.91.229.2]:30903 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935199AbWLCOTp (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 09:19:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GqsC0-0001aj-Ha for git@vger.kernel.org; Sun, 03 Dec 2006 15:19:44 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 03 Dec 2006 15:19:44 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 03 Dec 2006
 15:19:44 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Robin Rosenberg wrote:

> s=F6ndag 03 december 2006 05:59 skrev Shawn Pearce:
>
>> With the help of Robin Rosenberg I've been able to make jgit's log
>> operation run (on average) within a few milliseconds of core Git.
>>
>> Walking the 50,000 most recent commits from the Mozilla trunk[1]:
>>
>>   $ time git rev-list --max-count=3D50000 HEAD >/dev/null
>>
>>   core Git:  1.882s (average)
>>   jgit:      1.932s (average)
>>
>>   (times are with hot cache and from repeated executions)
> Nice indeed. That was a ten-fold improvement for getting my full hist=
ory.=20
>=20
> So, just go on to the next case. I added filtering on filenames (yes,=
=20
> CVS-induced brain damage, I should track the content. next version. f=
ilenames=20
> are so much handier to work with).

Git uses <path> as _revision limiter_, not as output filter. Shouldn't
jgit do the same?

P.S. What is the status of --follow option?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

