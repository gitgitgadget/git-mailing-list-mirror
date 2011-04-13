From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Gitbox
Date: Wed, 13 Apr 2011 15:13:44 -0700
Message-ID: <86hba1hk9z.fsf@red.stonehenge.com>
References: <A2315DA1-780C-4024-B774-9AD5F9AA0DB6@medialab.com>
	<1302721187.21900.4.camel@drew-northup.unet.maine.edu>
	<1E5D7DCE-B3B3-4CC7-8F40-4ED48E76907D@gmail.com>
	<1302722214.22161.5.camel@drew-northup.unet.maine.edu>
	<86vcyigcqy.fsf@red.stonehenge.com>
	<7vfwpllw5g.fsf@alter.siamese.dyndns.org>
	<1C18B4FB-BB10-4AC7-8952-D477CB4EF289@medialab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Drew Northup <drew.northup@maine.edu>,
	Joshua Juran <jjuran@gmail.com>, git@vger.kernel.org,
	oleganza@gmail.com, Chris Perkins <cperkins@medialab.com>
To: Daniel Searles <dsearles@medialab.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:13:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA8Jy-0005fg-9j
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 00:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933265Ab1DMWNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 18:13:53 -0400
Received: from lax-gw08.mailroute.net ([199.89.0.108]:51177 "EHLO
	mail.mroute.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933068Ab1DMWNw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 18:13:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by lax-gw08.mroute.net (Postfix) with ESMTP id DC5AF299FAA;
	Wed, 13 Apr 2011 22:13:45 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by lax-gw08.mroute.net (Postfix) with ESMTP id 8CA8E299FA8;
	Wed, 13 Apr 2011 22:13:44 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 7A37118D3; Wed, 13 Apr 2011 15:13:44 -0700 (PDT)
x-mayan-date: Long count = 12.19.18.5.2; tzolkin = 10 Ik; haab = 10 Pop
In-Reply-To: <1C18B4FB-BB10-4AC7-8952-D477CB4EF289@medialab.com> (Daniel
	Searles's message of "Wed, 13 Apr 2011 14:56:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171491>

>>>>> "Daniel" == Daniel Searles <dsearles@medialab.com> writes:

Daniel> It seems to me that since gitbox is useless without git it is
Daniel> definitely in violation of the GPL. My interpretation of the GPL
Daniel> is based off of the following article:
Daniel> http://clisp.cvs.sourceforge.net/viewvc/clisp/clisp/doc/Why-CLISP-is-under-GPL

And note the author of that opinion, RMS, who would always rule in favor
of more things needing to be under the GPL as the One True License.

And it's also about readline.a, which *has* to be linked into a binary
to make it work.  None of the git code is being *linked* in.

Particularly, I see this phrase in the actual license of Git (version 2,
not version 3 under which Readline is distributed):

    Thus, it is not the intent of this section to claim rights or contest
    your rights to work written entirely by you; rather, the intent is to
    exercise the right to control the distribution of derivative or
    collective works based on the Program.

    In addition, mere aggregation of another work not based on the Program
    with the Program (or with a work based on the Program) on a volume of
    a storage or distribution medium does not bring the other work under
    the scope of this License.

I'd consider the git binary distribution to be an aggregation with
gitbox, not a "linking", presuming that one of the following has also
happened:

      3. You may copy and distribute the Program (or a work based on it,
    under Section 2) in object code or executable form under the terms of
    Sections 1 and 2 above provided that you also do one of the following:

        a) Accompany it with the complete corresponding machine-readable
        source code, which must be distributed under the terms of Sections
        1 and 2 above on a medium customarily used for software interchange;
        or,

        b) Accompany it with a written offer, valid for at least three
        years, to give any third party, for a charge no more than your
        cost of physically performing source distribution, a complete
        machine-readable copy of the corresponding source code, to be
        distributed under the terms of Sections 1 and 2 above on a medium
        customarily used for software interchange; or,

        c) Accompany it with the information you received as to the offer
        to distribute corresponding source code.  (This alternative is
        allowed only for noncommercial distribution and only if you
        received the program in object code or executable form with such
        an offer, in accord with Subsection b above.)

I cannot confirm that one of these has been done, but let's say it has.

As already said in this thread, if "execve()" is considered a "linking",
then *everything* in a typical Linux distro would *have* to be GPL.
That's patently not the case.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
