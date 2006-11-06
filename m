X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: how to show log for only one branch
Date: Mon, 06 Nov 2006 10:16:47 -0800
Message-ID: <7vslgwcueo.fsf@assigned-by-dhcp.cox.net>
References: <454EAEDB.8020909@gmail.com>
	<7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F1175.9080506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 6 Nov 2006 18:36:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31022>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh91p-0007Fr-P8 for gcvg-git@gmane.org; Mon, 06 Nov
 2006 19:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753752AbWKFSQt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 13:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753758AbWKFSQt
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 13:16:49 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:26812 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1753748AbWKFSQs
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 13:16:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061106181647.JUPF18816.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Mon, 6
 Nov 2006 13:16:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id jWGs1V0171kojtg0000000; Mon, 06 Nov 2006
 13:16:53 -0500
To: Liu Yubao <yubao.liu@gmail.com>
Sender: git-owner@vger.kernel.org

Liu Yubao <yubao.liu@gmail.com> writes:

> ... For example, I want to know what happened in your
> git's "next" branch, I hope to get logs like this:
>     Merge branch 'jc/pickaxe' into next
>     Merge branch 'master' into next
>     Merge branch 'js/modfix' into next
>     ...
>     some good work
>     ...
>     Merge branch ....
>
> I just want to *outline* what happened in "next" branch, if I am interested
> in what have been merged from 'jc/pickaxe' I can follow the merge point again
> or use something like "git log --follow-all-parents".

My "next" is a bad example of this, because it is an integration
branch and never gets its own development.  It is also a bad
example because I can answer that question with this command
line:

	git log --grep='^Merge .* into next$' next

and while it is a perfectly valid answer, I know it would leave
you feeling somewhat cheated.


