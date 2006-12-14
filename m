X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-reset [--mixed] <tree> [--] <paths>...
Date: Thu, 14 Dec 2006 12:41:39 -0800
Message-ID: <7v3b7i2osc.fsf@assigned-by-dhcp.cox.net>
References: <7vwt4u96e8.fsf@assigned-by-dhcp.cox.net>
	<slrneo2atm.nqa.Peter.B.Baumann@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 20:41:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <slrneo2atm.nqa.Peter.B.Baumann@xp.machine.xx> (Peter Baumann's
	message of "Thu, 14 Dec 2006 11:47:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34394>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuxOi-0004EA-Nl for gcvg-git@gmane.org; Thu, 14 Dec
 2006 21:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932902AbWLNUln (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 15:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932909AbWLNUlm
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 15:41:42 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:62516 "EHLO
 fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932905AbWLNUll (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 15:41:41 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214204140.HMOK2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Thu, 14
 Dec 2006 15:41:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ykhr1V00V1kojtg0000000; Thu, 14 Dec 2006
 15:41:51 -0500
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org

Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
writes:

> Why not make
>
> 	git-reset --hard <treeish> -- file
>
> aquivalent to
>
> 	git-checkout <treeish> -- file

Theoretically we could, but I'd rather keep "reset --hard"
something that people would think a bit about before actually
running (I am not enthused about giving "reset --mixed" this
feature for the same reason, but I think it is safe enough).

I'd want to avoid overloading different meanings to the --hard
form.  Mis-typing checkout (say, accidentally having <RETURN>
before "-- file" part while cut & paste) would not be so
dangeous; mis-typing "reset --hard" the same way could be
disastrous.

> PS:	Your patch didn't apply cleanly.

As I said there is one bug I've fixed in my tree but the
branches were not pushed out yet.
