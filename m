From: Petr Baudis <pasky@suse.cz>
Subject: Re: simple use case scenario for --read-tree and --write-tree with --prefix option
Date: Mon, 19 Jun 2006 15:53:43 +0200
Message-ID: <20060619135343.GP2609@pasky.or.cz>
References: <cc723f590606190028t65c76c74t6a90d1dcec411598@mail.gmail.com> <7vpsh5a8gs.fsf@assigned-by-dhcp.cox.net> <cc723f590606190058w2d7481ecsaded46095aee2355@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 19 17:05:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsLJq-0005Qi-Ve
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 17:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWFSPFg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 11:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWFSPFg
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 11:05:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64698 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932506AbWFSPFf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 11:05:35 -0400
Received: (qmail 16578 invoked by uid 2001); 19 Jun 2006 15:53:43 +0200
To: Aneesh Kumar <aneesh.kumar@gmail.com>
Content-Disposition: inline
In-Reply-To: <cc723f590606190058w2d7481ecsaded46095aee2355@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22127>

Dear diary, on Mon, Jun 19, 2006 at 09:58:31AM CEST, I got a letter
where Aneesh Kumar <aneesh.kumar@gmail.com> said that...
> cd test
> 
> kvaneesh@satan:/tmp/test$ git read-tree --prefix=test1/ $(cat
> test1/.git/refs/heads/master)
> fatal: failed to unpack tree object c6c049d03f0bee0ac546ff6e436d5f6f3a5f4864
> 
> But the above command doesn't work for me. I guess i am missing something.

You need to do a fetch to your /tmp/test repository first.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
