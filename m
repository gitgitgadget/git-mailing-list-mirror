X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Move --pretty options into Documentation/pretty-formats.txt
Date: Fri, 17 Nov 2006 17:15:56 -0800
Message-ID: <7vlkm9ftbn.fsf@assigned-by-dhcp.cox.net>
References: <11638115311562-git-send-email-chris@syntacticsugar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 01:16:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <11638115311562-git-send-email-chris@syntacticsugar.org> (Chris
	Riddoch's message of "Fri, 17 Nov 2006 17:58:51 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31746>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlEoM-0002Fz-Al for gcvg-git@gmane.org; Sat, 18 Nov
 2006 02:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756117AbWKRBP6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 20:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756118AbWKRBP6
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 20:15:58 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:10897 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1756117AbWKRBP5
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 20:15:57 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061118011556.OTAD18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 20:15:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id o1G31V00R1kojtg0000000; Fri, 17 Nov 2006
 20:16:03 -0500
To: Chris Riddoch <chris@syntacticsugar.org>
Sender: git-owner@vger.kernel.org

Chris Riddoch <chris@syntacticsugar.org> writes:

> Asciidoc-include it into the manuals for programs that use the
> --pretty command-line option, for consistency among the docs.

Beautiful, although I doubt we would want to spell out the exact
output format in that documentation (if so you would need to
talk about Merge: entries that we conditionally give and how
commit object names are abbreviated and such).  On the other
hand, we might want to talk about Merge: entries anyway to say
the values can be affected by merge simplification.

Independent of the above concerns, I trust somebody else will
follow this up with a patch to describe missing pretty formats?
