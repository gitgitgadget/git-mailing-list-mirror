From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 17:42:53 -0700
Message-ID: <7v8xkrqlma.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	<20060908184215.31789.qmail@science.horizon.com>
	<9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
	<Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
	<9e4733910609081628w2a59551foc28c689d0538a984@mail.gmail.com>
	<17668.2019.732961.855446@cargo.ozlabs.ibm.com>
	<9e4733910609100756r1ece1e22m38054536a2909dd4@mail.gmail.com>
	<7v1wqjsgfx.fsf@assigned-by-dhcp.cox.net>
	<20060911000403.GB28927@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 02:42:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMZsM-00071U-U2
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 02:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWIKAmK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 20:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWIKAmK
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 20:42:10 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:942 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964855AbWIKAmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 20:42:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060911004208.SAER2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sun, 10 Sep 2006 20:42:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Lohz1V00D1kojtg0000000
	Sun, 10 Sep 2006 20:41:59 -0400
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26825>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> We could benefit from the suggested organization of one base
>> archive pack plus a current active pack.  The core side code to
>> help doing so was posted here which followed a discussion on how
>> to have repack make use of it last week.
>> 
>>     http://thread.gmane.org/gmane.comp.version-control.git/26218/focus=26326
>> 
>> Any takers?
>
> I thought this was settled and you had it implemented?  Is this
> still an open topic?

I've implemented the core side and I think it is ready.  People
who actually have need for such a repack are welcome to take a
crack at it at the Porcelain-ish level.
