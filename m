X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH (take 3)] gitweb: Add some mod_perl specific support
Date: Sat, 16 Dec 2006 13:30:24 -0800
Message-ID: <7vwt4rcyvj.fsf@assigned-by-dhcp.cox.net>
References: <11662174851575-git-send-email-jnareb@gmail.com>
	<11662855752162-git-send-email-jnareb@gmail.com>
	<7virgbei6z.fsf@assigned-by-dhcp.cox.net>
	<200612162103.18695.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 21:30:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612162103.18695.jnareb@gmail.com> (Jakub Narebski's message
	of "Sat, 16 Dec 2006 21:03:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34643>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvh71-0007WS-Vk for gcvg-git@gmane.org; Sat, 16 Dec
 2006 22:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753795AbWLPVa0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 16:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753790AbWLPVa0
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 16:30:26 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:48325 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753795AbWLPVaZ (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 16:30:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216213024.COTV20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Sat, 16
 Dec 2006 16:30:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zZWc1V00c1kojtg0000000; Sat, 16 Dec 2006
 16:30:36 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>> I have your (take 2) merged already last night in my tree but
>> haven't pushed the result out.  Does this replace it?
>
> Yes, that replaces it. I'm very sorry for the confusion.
>
> I have noticed that I would need to add "use Apache2::RequestRec"
> or it's mod_perl 1.0 equivalent before I can use $r->path_info().

I noticed the difference by applying the patch to the parent of
(take 2) commit I made and diffing.  It would be nice to have
the above two line comment somewhere in the message, probably
immediately after the three-dash lines, but no biggie.

Thanks for the clarification.
