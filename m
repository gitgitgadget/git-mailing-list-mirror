X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 11:15:25 -0800
Message-ID: <7vmz6ky5ki.fsf@assigned-by-dhcp.cox.net>
References: <200611211341.48862.andyparkins@gmail.com>
	<8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com>
	<slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx>
	<Pine.LNX.4.64.0611210820100.3338@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 19:15:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org> (Linus
	Torvalds's message of "Tue, 21 Nov 2006 08:31:30 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32025>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmb5g-0002Sj-GU for gcvg-git@gmane.org; Tue, 21 Nov
 2006 20:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031326AbWKUTP1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 14:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031329AbWKUTP1
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 14:15:27 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:64696 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1031326AbWKUTP1
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 14:15:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061121191526.PLWP18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Tue, 21
 Nov 2006 14:15:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id pXFZ1V00u1kojtg0000000; Tue, 21 Nov 2006
 14:15:34 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 21 Nov 2006, Peter Baumann wrote:
>> 
>> Why not make --root the default? I also stumbled over this behaviour and
>> even asked on this list.
>
> I suspect we should make the thing a config option, and default it to 
> "on".
>
> I personally do _not_ want to see the root commit, because for the kernel, 
> it's a honking huge import that does not make sense as a "diff". It's not 
> really a diff against anything, after all - it's an import.
>
> That's really the reason why git defaults to not showing the root diff at 
> all: exactly because for the kernel, the initial commit was state that 
> "just came to be", and I found it both illogical and annoying to see it as 
> a diff, since that commit really was a "black hole" where previous history 
> just disappeared.
>
> But if you have the _full_ history with a new project, "--root" by default 
> probably makes tons of sense.

I agree fully with the above.  Let's make it happen.
