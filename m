From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Mon, 05 Sep 2005 11:23:22 -0700
Message-ID: <7vek835q79.fsf@assigned-by-dhcp.cox.net>
References: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>
	<Pine.LNX.4.58.0509050738340.3504@evo.osdl.org>
	<u5tvf1feedt.fsf@lysator.liu.se>
	<Pine.LNX.4.58.0509050902070.3568@evo.osdl.org>
	<u5tk6hveawy.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp-2
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Sep 05 20:24:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECLdA-0004H9-4T
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 20:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVIESX1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 14:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVIESX1
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 14:23:27 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:64164 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932357AbVIESX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2005 14:23:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050905182323.JFES3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Sep 2005 14:23:23 -0400
To: David =?iso-2022-jp-2?B?SxsuQRtOZWdlZGFs?= <davidk@lysator.liu.se>
In-Reply-To: <u5tk6hveawy.fsf@lysator.liu.se> (David
 =?iso-2022-jp-2?B?SxsuQRtOZWdlZGFsJ3M=?= message of
	"Mon, 05 Sep 2005 18:28:45 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8106>

David K.ANegedal <davidk@lysator.liu.se> writes:

> If the "-script" part is supposed to be hidden from me, why do I keep
> seeing it everywhere I turn?
>
>> So to users it doesn't matter, and to developers it _does_ matter (and 
>> calling them ".pl" or ".sh" or something would be _bad_), why not please 
>> the developers?
>
> I'm not suggesting we'd call them ".pl" or ".sh".

Well, I was.  Here is what I had in mind.

1. Introduce SCRIPT_SH and SCRIPT_PERL, and make
   "SCRIPTS = $(SCRIPT_SH) $(SCRIPT_PERL)" in the Makefile.
2. Install git-foo.sh as $(DEST)$(bin)/git-foo
3. Documentation to describe git-foo command is Documentation/git-foo.txt

I was planning to leave gitk source as gitk, not gitk.tcl nor
gitk.wish nor gitk.sh for now, if only to help me merging from
paurus.

Depending on how people would react to the "why would people
care what scripting language is the thing written in" comment by
Linus, I may be persuaded otherwise though, in which case 1. is
not needed, and 2. would lose '.sh', but 3. would not change.
 
