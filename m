From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Re: Re: Darcs-git pulling from the Linux repo: a
	Linux VM question
Date: Wed, 27 Apr 2005 17:54:32 +0200
Message-ID: <7iu0lskyfb.fsf@lanthane.pps.jussieu.fr>
References: <7i7jionz5q.fsf@lanthane.pps.jussieu.fr>
	<Pine.LNX.4.58.0504270823480.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, darcs-devel@darcs.net
X-From: darcs-devel-bounces@darcs.net Wed Apr 27 17:51:37 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQonF-0002tW-W9
	for gcvdd-darcs-devel@m.gmane.org; Wed, 27 Apr 2005 17:49:42 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DQos1-0008FU-JD; Wed, 27 Apr 2005 11:54:37 -0400
Received: from shiva.jussieu.fr ([134.157.0.129])
	by abridgegame.org with esmtp (Exim 4.50) id 1DQory-0008F6-Jm
	for darcs-devel@darcs.net; Wed, 27 Apr 2005 11:54:34 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr
	[134.157.168.1])
	by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j3RFsWl6012649
	; Wed, 27 Apr 2005 17:54:32 +0200 (CEST)
X-Ids: 164
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr
	[134.157.168.57])
	by hydrogene.pps.jussieu.fr (8.13.3/jtpda-5.4) with ESMTP id
	j3RFsWVW015817 ; Wed, 27 Apr 2005 17:54:32 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.34)
	id 1DQorw-0004XB-NV; Wed, 27 Apr 2005 17:54:32 +0200
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504270823480.18901@ppc970.osdl.org> (Linus
	Torvalds's message of "Wed, 27 Apr 2005 08:31:37 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2
	(shiva.jussieu.fr [134.157.0.164]);
	Wed, 27 Apr 2005 17:54:32 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 426FB5B8.000 by Joe's j-chkmail
	(http://j-chkmail.ensmp.fr)!
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net

>> For now, does anyone know how I can tune the Linux VM to get a 720
>> MB process to run reliably in 640 MB of main memory?

> I really think you're screwed.

Thanks, that's what I needed to know.

> You _really_ shouldn't read in files that you don't absolutely need.

Ahem... you don't expect me to embark on hacking Git without at least
understanding that, do you?

> That's really the biggest point of git: using the sha1 for naming the
> objects is really all about "descrive the contents using 20 bytes instead
> of by reading the contents".

Here we're speaking about the initial import.  Committed on 17 April
2005 by Linus Torvalds, with the comment ``Let it rip''.  220 MB of
changed files in a single commit.  2 minutes real time just to read
all the files, never mind doing anything useful with them.

To put it mildly, Darcs is not optimised for that sort of usage.

> Sorry.  You really need to fix darcs.

That's exactly why we're so interested in your repository.

                                        Juliusz
