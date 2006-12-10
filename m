X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Make cvsexportcommit work with filenames with spaces and non-ascii characters.
Date: Mon, 11 Dec 2006 00:48:46 +0100
Message-ID: <200612110048.47435.robin.rosenberg@dewire.com>
References: <20061209232919.31863.58547.stgit@lathund.dewire.com> <200612101639.22397.robin.rosenberg@dewire.com> <7vlklf4f1s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 10 Dec 2006 23:46:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <7vlklf4f1s.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33965>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtYN7-0001Zu-Mr for gcvg-git@gmane.org; Mon, 11 Dec
 2006 00:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760473AbWLJXqO convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006 18:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760455AbWLJXqO
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 18:46:14 -0500
Received: from [83.140.172.130] ([83.140.172.130]:13220 "EHLO
 torino.dewire.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with
 ESMTP id S1759243AbWLJXqN convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 18:46:13 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 86FA18030B8; Mon, 11 Dec 2006 00:42:19 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 12563-07; Mon, 11 Dec
 2006 00:42:19 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3]) by torino.dewire.com (Postfix)
 with ESMTP id 37CF1802AB4; Mon, 11 Dec 2006 00:42:19 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

s=F6ndag 10 december 2006 22:27 skrev Junio C Hamano:
> Maybe I am missing something.  It tells you about added or
> removed files (either binary or non-binary).

no, I was missing --summary. I thought --numstat did that (man page=20
says "similar to stat".

> I'd prepare a pair of practice patch files.  "forward" has
> creation, "reverse" has addition.
t9200 serves that purpose.

