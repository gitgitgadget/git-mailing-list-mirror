X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Mon, 20 Nov 2006 11:32:19 -0800
Message-ID: <7v7ixp3oe4.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com>
	<7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net>
	<20061118184345.GO7201@pasky.or.cz>
	<e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com>
	<7vac2oefuz.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
	<Pine.LNX.4.64.0611181706250.3692@woody.osdl.org>
	<e5bfff550611190140n3277ee26v95feba26dd3348fa@mail.gmail.com>
	<Pine.LNX.4.64.0611190945500.3692@woody.osdl.org>
	<e5bfff550611191107o63d89d8bp5ff4080803a0d784@mail.gmail.com>
	<e5bfff550611191209s63982818vd3999b543e68e8df@mail.gmail.com>
	<Pine.LNX.4.64.0611191219350.3692@woody.osdl.org>
	<7vbqn38831.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611191310430.3692@woody.osdl.org>
	<ejqhvi$9kc$1@sea.gmane.org>
	<Pine.LNX.4.64.0611191527270.3692@woody.osdl.org>
	<7vr6vy7smi.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611200817330.3692@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 19:33:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611200817330.3692@woody.osdl.org> (Linus
	Torvalds's message of "Mon, 20 Nov 2006 08:29:38 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31928>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmEtB-0004GR-UI for gcvg-git@gmane.org; Mon, 20 Nov
 2006 20:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966503AbWKTTcX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 14:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966523AbWKTTcX
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 14:32:23 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:21435 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S966506AbWKTTcV
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 14:32:21 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061120193220.NXVQ18207.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Mon, 20
 Nov 2006 14:32:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id p7Xr1V00K1kojtg0000000; Mon, 20 Nov 2006
 14:31:51 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

>> For this particular one, there is no need for version 2.
>
> I don't think you understand.

That is true.  I was not thinking about optimizing the
lightweight tag case -- we would want to be able to tell that
they are not tag objects and skip peel_ref altogether, and in
order to do that we do need a way to tell us that we can trust
the absense of peeled representation in the packed-refs file.

It is my day job day so I do not expect I can continue til later
today, though...
