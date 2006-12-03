X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 3 Dec 2006 13:22:54 +0100
Organization: Dewire
Message-ID: <200612031322.54748.robin.rosenberg.lists@dewire.com>
References: <20061120215116.GA20736@admingilde.org> <200612030224.50592.robin.rosenberg.lists@dewire.com> <200612030231.05900.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 3 Dec 2006 12:20:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <200612030231.05900.jnareb@gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33108>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqqKp-0002C8-3n for gcvg-git@gmane.org; Sun, 03 Dec
 2006 13:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759623AbWLCMUi convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006 07:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759627AbWLCMUi
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 07:20:38 -0500
Received: from [83.140.172.130] ([83.140.172.130]:48901 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1759623AbWLCMUh convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 07:20:37
 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 2069D802A94; Sun,  3 Dec 2006 13:16:48 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 13410-01; Sun,  3 Dec
 2006 13:16:47 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id 9A00080281C; Sun,  3 Dec 2006 13:16:47 +0100 (CET)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

s=F6ndag 03 december 2006 02:31 skrev Jakub Narebski:
> Actually, rm -rf * is not needed for "git reset --hard" or
> "git checkout -f" to succeed.

True, but git reset --hard isn't always enough and rm -rf * is the good=
 ol'=20
way of resetting things. Typically this comes from make being upset (or=
 too=20
content) with something.

