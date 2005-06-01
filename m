From: Junio C Hamano <junkio@cox.net>
Subject: Re: I want to release a "git-1.0"
Date: Tue, 31 May 2005 21:06:19 -0700
Message-ID: <7vmzqau3es.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
	<m1psv7bjb6.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 06:04:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdKSH-00013c-G6
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 06:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVFAEG1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 00:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVFAEG1
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 00:06:27 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:61383 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261236AbVFAEGV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 00:06:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050601040619.MPDW22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Jun 2005 00:06:19 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 31 May 2005 20:04:11 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Anyway, I wrote just a _very_ introductory thing in
LT> Documentation/tutorial.txt, I'll try to update and expand on
LT> it later. It basically has a really stupid example of "how
LT> to set up a new project".

I've spotted a couple of typos which I will leave others to fix,
but there is one thing I am to blame.

    (Btw, current versions of git will consider the change in question to be
    so big that it's considered a whole new file, since the diff is actually
    bigger than the file.  So the helpful comments that git-commit-script
    tells you for this example will say that you deleted and re-created the
    file "a".  For a less contrieved example, these things are usually more
    obvious). 

Do you want me to do something about this with -B (and possibly
-C/-M), like skipping the comparison altogether if the file size
is smaller than, say, 1k bytes or something silly like that?  Or
not having special case for this kind of "contrived example"
preferrable?

