X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix regression tests on Cygwin
Date: Tue, 24 Oct 2006 21:50:13 -0700
Message-ID: <7vods1dmnu.fsf@assigned-by-dhcp.cox.net>
References: <11616320733093-git-send-email-hjemli@gmail.com>
	<Pine.LNX.4.63.0610241653020.2106@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vwt6pdn46.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 04:50:22 +0000 (UTC)
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vwt6pdn46.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 24 Oct 2006 21:40:25 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30032>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcaiZ-0002SJ-FS for gcvg-git@gmane.org; Wed, 25 Oct
 2006 06:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422974AbWJYEuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 00:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161337AbWJYEuQ
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 00:50:16 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:11464 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1161326AbWJYEuO
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 00:50:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025045014.MPQA6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 00:50:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id eUpw1V01P1kojtg0000000 Wed, 25 Oct 2006
 00:49:57 -0400
To: Lars Hjemli <hjemli@gmail.com>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Mon, 23 Oct 2006, Lars Hjemli wrote:
>>
>>> On Cygwin, "make test" failes due to missing ".exe" a couple of places.
>>
>> Last time I made "test" on cygwin, it did not complain.
>
> Same here (W2k, fairly up-to-date git, installed on local NTFS
> disk).

... and more importantly, with fairly up-to-date Cygwin.
