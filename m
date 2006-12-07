X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: cygwin, 44k files: how to commit only index?
Date: Thu, 07 Dec 2006 11:16:39 -0800
Message-ID: <7vd56vtt2g.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 19:17:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com>
	(Alex Riesen's message of "Thu, 7 Dec 2006 15:27:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33605>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsOjq-0004PN-IV for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163216AbWLGTQm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163218AbWLGTQm
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:16:42 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:62016 "EHLO
 fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163216AbWLGTQl (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 14:16:41 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207191640.FHPO2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Thu, 7
 Dec 2006 14:16:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vvGq1V00p1kojtg0000000; Thu, 07 Dec 2006
 14:16:51 -0500
To: "Alex Riesen" <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

"Alex Riesen" <raa.lkml@gmail.com> writes:

> I have a kind of awkward project to work with (~44k files, many binaries).
>
> The normal "git commit", which seem to be more than enough
> for anything and anyone else, is a really annoying procedure
> in my context. It spend too much time refreshing index and
> generating list of the files for the commit message.
>
> At first I stopped using git commit -a (doing only update-index),

I am not sure what you are trying.  Do you mean stat() is slow
on your filesystem?

> Is there any simple way to modify git commit for such a workflow?
> Failing that, any simple and _fast_ way to find out if the index
> is any different from HEAD? (so that I don't produce empty commits).

Maybe you want "assume unchanged"?
