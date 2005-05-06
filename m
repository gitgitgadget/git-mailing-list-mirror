From: Junio C Hamano <junkio@cox.net>
Subject: Re: How do I...
Date: Fri, 06 May 2005 09:35:52 -0700
Message-ID: <7vsm10cnx3.fsf@assigned-by-dhcp.cox.net>
References: <427B3DB3.4000507@tuxrocks.com>
	<Pine.LNX.4.58.0505060905090.2233@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Sorenson <frank@tuxrocks.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 18:32:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU5ja-0005TH-Ns
	for gcvg-git@gmane.org; Fri, 06 May 2005 18:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVEFQha (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 12:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVEFQha
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 12:37:30 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:49836 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261218AbVEFQfy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 12:35:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050506163553.OSIH16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 May 2005 12:35:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505060905090.2233@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 6 May 2005 09:13:27 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Fri, 6 May 2005, Frank Sorenson wrote:
>> 
>> Okay, I've got some "How can I?" questions.  I hope I'm not the only one
>> still working to "git it".
>> 
>> How can I git a list of commits that have modified a particular file?
>> For example, I'd like to do something like this:
>> # git-file-revs Makefile
>> f7eb55878f11575281add2a5726e483aed5e45bb
>> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
>> bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb

LT> Guys - whoever wrote one of the scripts, can you please send out your 
LT> current version to the git list and cc me, and explain why yours is 
LT> superior to the other peoples version. Please?

I think I mentioned and posted an interactive version called
jit-trackdown.  It is part of JIT found at [*1*].  You may have
an older version that does not have the command.

LT> But I might cook something up myself too. 

Yourself or not, I think it is a good idea to do something that
does exactly Frank wants, namely, just list commits.  Even
better would be, to take commits with multiple parents into
account, list of <commit> <parent> pairs, like:

    $ git-file-revs Makefile
    f7eb55....... aaaaaa.......
    f7eb55....... bbbbbb.......
    aaaaaa....... dddddd.......

which shows commit f7eb55... changed it relative to both of its
parents aaaaaa... and bbbbbb...

[Footnotes]
*1* http://members.cox.net/junkio/

