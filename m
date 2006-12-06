X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Diffs from CVS keyword expansion
Date: 06 Dec 2006 02:08:35 -0800
Message-ID: <86irgpl4kc.fsf@blue.stonehenge.com>
References: <9e4733910611301956l6f64b01ftee46971a18e3467b@mail.gmail.com>
	<20061205121443.GB2428@cepheus> <86k616m8i9.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0612052048230.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061206100514.GA7126@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 10:09:07 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.15.13; tzolkin = 7 Ben; haab = 6 Mac
In-Reply-To: <20061206100514.GA7126@informatik.uni-freiburg.de>
Original-Lines: 17
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33421>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grti3-0000T6-Tr for gcvg-git@gmane.org; Wed, 06 Dec
 2006 11:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760439AbWLFKIi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 05:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760442AbWLFKIi
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 05:08:38 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:14129 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1760447AbWLFKIh (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 05:08:37 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 83CBC8F606; Wed,  6 Dec 2006 02:08:36 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 17833-01-87; Wed,  6 Dec 2006 02:08:36 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 021B38F607;
 Wed,  6 Dec 2006 02:08:36 -0800 (PST)
To: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>
Sender: git-owner@vger.kernel.org

>>>>> "Uwe" == Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de> writes:
Uwe> One thing I don't like about both scripts is, that the timestamp of
Uwe> a file changes with that, even if there are no changes.  Anyone knows
Uwe> another predefined variable/trick that doesn't hurt performance (and
Uwe> readability) too much?

You have to do two passes, or a pass-and-a-half, and do the rename/rewrite
based on whether anything changed.

"Just a few more lines of code." :)  If it's really important, I can
be coaxed to dig it up.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
