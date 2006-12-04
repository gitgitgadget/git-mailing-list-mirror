X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: On removing files and "git-rm is pointless"
Date: Mon, 04 Dec 2006 02:13:43 -0800
Message-ID: <7vd570q888.fsf@assigned-by-dhcp.cox.net>
References: <87odqm2ppv.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0612020919400.3476@woody.osdl.org>
	<4571DB40.6020800@vilain.net>
	<Pine.LNX.4.64.0612022246310.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 10:13:54 +0000 (UTC)
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Sam Vilain <sam@vilain.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612022246310.2630@xanadu.home> (Nicolas Pitre's
	message of "Sat, 02 Dec 2006 22:50:46 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33180>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrApX-0005yi-NP for gcvg-git@gmane.org; Mon, 04 Dec
 2006 11:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935336AbWLDKNp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 05:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935514AbWLDKNp
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 05:13:45 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:14847 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S935336AbWLDKNo
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 05:13:44 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061204101344.ZEWC4226.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Mon, 4
 Dec 2006 05:13:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id uaD81V00T1kojtg0000000; Mon, 04 Dec 2006
 05:13:09 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> I think what Linus is proposing makes tons of sense.
>
> If you do git rm by mistake then you can always do git checkout on that
> file to get it back.
>
> If you modified it so it doesn't match the index then git rm won't do
> anything by default so you have a chance to think a bit more.
>
> If you updated the index, didn't commit anything but then do git rm then
> you certainly wanted to really rm the file.

FWIW, I too am in favor of the proposed fix to "git rm" as Linus
outlined.
