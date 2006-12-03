X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 3 Dec 2006 02:24:50 +0100
Organization: Dewire
Message-ID: <200612030224.50592.robin.rosenberg.lists@dewire.com>
References: <20061120215116.GA20736@admingilde.org> <eksmrf$c33$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 3 Dec 2006 01:22:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <eksmrf$c33$1@sea.gmane.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33076>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqg3z-0002AV-09 for gcvg-git@gmane.org; Sun, 03 Dec
 2006 02:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936611AbWLCBWg convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006 20:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935005AbWLCBWg
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 20:22:36 -0500
Received: from [83.140.172.130] ([83.140.172.130]:8558 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S936611AbWLCBWf convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 20:22:35
 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 0669280281C; Sun,  3 Dec 2006 02:18:48 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 08647-06; Sun,  3 Dec
 2006 02:18:47 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id 9F4D08003E1; Sun,  3 Dec 2006 02:18:45 +0100 (CET)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

l=F6rdag 02 december 2006 21:16 skrev Jakub Narebski:
> The problem with submodule as separate git repository is that if you
> move submodule (subproject) somewhere else in the repository (or just
> rename it), you have to update alternates file... and this happens no=
t
> only on move itself, but also on checkout and reset. But that can be
> managed by having in alternates all possible places the submodule end=
s
> into. I don't know if it is truly a problem.

A nasty problem with separate repositories for submodules is that when =
you=20
screw up and git complains about everything you try do do, you previous=
ly=20
could do rm -rf *; git reset --hard and retry whatever you were trying =
to do.=20
With separate repositories your submodules will be resting in /dev/null=
,=20
unless you're very, very careful.=20

