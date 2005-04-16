From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Merge with git-pasky II.
Date: Sat, 16 Apr 2005 18:03:33 +0200
Message-ID: <20050416160333.GF19099@pasky.ji.cz>
References: <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org> <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org> <1113559330.12012.292.camel@baythorne.infradead.org> <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org> <20050416014442.GW4488@himi.org> <Pine.LNX.4.62.0504160518310.21837@qynat.qvtvafvgr.pbz> <20050416155536.GX4488@himi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Lang <david.lang@digitalinsight.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 18:00:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMpiB-0007Ju-SL
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 18:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbVDPQDh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 12:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVDPQDh
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 12:03:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51072 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262692AbVDPQDf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 12:03:35 -0400
Received: (qmail 29295 invoked by uid 2001); 16 Apr 2005 16:03:33 -0000
To: Simon Fowler <simon@himi.org>
Content-Disposition: inline
In-Reply-To: <20050416155536.GX4488@himi.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 16, 2005 at 05:55:37PM CEST, I got a letter
where Simon Fowler <simon@himi.org> told me that...
> On Sat, Apr 16, 2005 at 05:19:24AM -0700, David Lang wrote:
> > Simon
> > 
> > given that you have multiple machines creating files, how do you deal with 
> > the idea of the same 'unique id' being assigned to different files by 
> > different machines?
> > 
> The id is a sha1 hash of the current time and the full path of the
> file being added - the chances of that being replicated without
> malicious intent is extremely small. There are other things that
> could be used, like the hostname, username of the person running the
> program, etc, but I don't really see them being necessary.

Why not just use UUID?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
