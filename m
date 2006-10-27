X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Generating docu in 1.4.3.3.g01929
Date: Fri, 27 Oct 2006 14:34:55 -0700
Message-ID: <7vodrxe934.fsf@assigned-by-dhcp.cox.net>
References: <200610271726.k9RHQr0F024712@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 21:36:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610271726.k9RHQr0F024712@laptop13.inf.utfsm.cl> (Horst H. von
	Brand's message of "Fri, 27 Oct 2006 14:26:53 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30348>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdZLx-0002NV-9K for gcvg-git@gmane.org; Fri, 27 Oct
 2006 23:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752499AbWJ0Ve6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 17:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbWJ0Ve5
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 17:34:57 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:34797 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1752499AbWJ0Ve5
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 17:34:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061027213456.LVUR12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Fri, 27
 Oct 2006 17:34:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id fZae1V0021kojtg0000000 Fri, 27 Oct 2006
 17:34:38 -0400
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:

> I'm getting lots of these after today's pull:
>
> asciidoc -b docbook -d manpage -f asciidoc.conf git-daemon.txt
> xmlto -m callouts.xsl man git-daemon.xml
> error : unterminated entity reference                
> error : unterminated entity reference                
> error : unterminated entity reference             ...
> error : unterminated entity reference                
> error : unterminated entity reference                
> Writing git-daemon.1 for refentry

Is it only with git-daemon.txt (as opposed to other files like
git-cat-file.txt), is it only with generating git-daemon.1 (as
opposed to generating git-daemon.html), and is it only with
today's pull (as opposed to 1.4.3.3)?

The point I am getting at is if it is only for you and if so
we might want to pinpoint where the breakage is.

I do not see it with my xmlto and asciidoc combination, either
on FC6 nor on Debian testing.
