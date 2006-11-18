X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Document git-runstatus
Date: Sat, 18 Nov 2006 16:04:43 +0100
Message-ID: <455F210B.8000107@lsrfire.ath.cx>
References: <455F1595.9020009@lsrfire.ath.cx> <20061118092644.a9f15669.seanlkml@sympatico.ca> <20061118143511.GM7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 18 Nov 2006 15:04:52 +0000 (UTC)
Cc: Sean <seanlkml@sympatico.ca>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <20061118143511.GM7201@pasky.or.cz>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31775>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlRkG-0000xd-CY for gcvg-git@gmane.org; Sat, 18 Nov
 2006 16:04:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756353AbWKRPEZ convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006 10:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756352AbWKRPEZ
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 10:04:25 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de
 ([217.172.187.230]:42132 "EHLO neapel230.server4you.de") by vger.kernel.org
 with ESMTP id S1756350AbWKRPEY (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18
 Nov 2006 10:04:24 -0500
Received: from [10.0.1.3] (p508E406F.dip.t-dialin.net [80.142.64.111]) by
 neapel230.server4you.de (Postfix) with ESMTP id 5631C3C005; Sat, 18 Nov 2006
 16:04:23 +0100 (CET)
To: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Petr Baudis schrieb:
> On Sat, Nov 18, 2006 at 03:26:44PM CET, Sean wrote:
>> On Sat, 18 Nov 2006 15:15:49 +0100
>> Rene Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
>>
>>> I copied most of the text from git-status.txt.
>> [...]=09
>>> +git-runstatus - Show working tree status
>=20
> Don't forget to add it to the list of commands.

Good catch, thanks.  An incremental patch follows below.

>> How is git-runstatus different from "git status"?
>=20
> I have the same question.

git-status is a wrapper around git-runstatus that takes the same
options as git-commit.  It could have been named 'git-commit --dry-run'=
=2E

>> Should this command be viewed simply as plumbing, and if so does it
>> deserve a man page or just textual documentation in the source?
>=20
> All commands deserve a man page.

Exactly.  Even plumbers read manuals ;-).  Well, me at least.

Ren=E9


diff --git a/Documentation/git.txt b/Documentation/git.txt
index 52bc05a..63b1746 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -424,6 +424,9 @@ gitlink:git-pack-redundant[1]::
 gitlink:git-rev-list[1]::
 	Lists commit objects in reverse chronological order.
=20
+gitlink:git-runstatus[1]::
+	Show working tree status.
+
 gitlink:git-show-index[1]::
 	Displays contents of a pack idx file.
