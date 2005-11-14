From: Petr Baudis <pasky@suse.cz>
Subject: Re: [Question] info/grafts file.
Date: Mon, 14 Nov 2005 20:59:11 +0100
Message-ID: <20051114195911.GU30496@pasky.or.cz>
References: <20051114182019.GA19105@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 14 21:03:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbkU1-0007DX-Nr
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 20:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVKNT7O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 14:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbVKNT7O
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 14:59:14 -0500
Received: from w241.dkm.cz ([62.24.88.241]:20147 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932070AbVKNT7N (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 14:59:13 -0500
Received: (qmail 30338 invoked by uid 2001); 14 Nov 2005 20:59:11 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051114182019.GA19105@hpsvcnb.fc.hp.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11841>

  Hello,

Dear diary, on Mon, Nov 14, 2005 at 07:20:19PM CET, I got a letter
where Carl Baldwin <cnb@fc.hp.com> said that...
> A simple question to clarify something in the repository.
> 
> What level of support is to be expected for the .git/info/grafts file?
> I added a grafts file to a repository imported from SVN.  However, when
> I cloned the repository using git clone -l -s I did not end up with a
> grafts file in the cloned repository.

  grafts are meant to be a purely local thing, private to your current
repository so that you can extend it in certain way. If you want
something public and official, that's what the "parent" lines in the
commit objects are - so you are really better off just rewriting the
history.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
