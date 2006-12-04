X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: latest update to git-svn blows up for me
Date: 04 Dec 2006 03:41:43 -0800
Message-ID: <86hcwbnb0o.fsf@blue.stonehenge.com>
References: <863b7wnwcw.fsf@blue.stonehenge.com>
	<20061204070021.GG1369@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 11:41:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.15.11; tzolkin = 5 Chuen; haab = 4 Mac
In-Reply-To: <20061204070021.GG1369@localdomain>
Original-Lines: 20
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33193>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrCCi-0007GK-3K for gcvg-git@gmane.org; Mon, 04 Dec
 2006 12:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936111AbWLDLlp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 06:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936106AbWLDLlp
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 06:41:45 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:63809 "EHLO
 blue.stonehenge.com") by vger.kernel.org with ESMTP id S936111AbWLDLlo (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 06:41:44 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 3D1458FD97; Mon,  4 Dec 2006 03:41:44 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 10024-01-98; Mon,  4 Dec 2006 03:41:43 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 7E9268FD8C;
 Mon,  4 Dec 2006 03:41:43 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

>>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:

Eric> "Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
>> 
>> Does this ring a bell?

Eric> Nope.

Eric> This is on r15941 of  https://svn.perl.org/parrot/trunk ?  I can't seem
Eric> to reproduce this with git svn fetch -r15940:15941

No, and that worked for me as well.  Apparently, I might have corrupted my
metadata because I updated git-svn while I was using it.  Is there any way to
reset the metadata without having to re-fetch 15000 revisions?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
