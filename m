From: Petr Baudis <pasky@ucw.cz>
Subject: Re: First web interface and service API draft
Date: Sat, 23 Apr 2005 00:45:54 +0200
Message-ID: <20050422224554.GG21204@pasky.ji.cz>
References: <1114166517.3233.4.camel@localhost> <20050422142342.GG30915@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 23 00:41:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP6pw-0002Bb-Fr
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 00:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVDVWqB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 18:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVDVWqB
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 18:46:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:62625 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261261AbVDVWpz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 18:45:55 -0400
Received: (qmail 25562 invoked by uid 2001); 22 Apr 2005 22:45:54 -0000
To: Christian Meder <chris@absolutegiganten.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050422142342.GG30915@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 04:23:42PM CEST, I got a letter
where Jan Harkes <jaharkes@cs.cmu.edu> told me that...
> On Fri, Apr 22, 2005 at 12:41:56PM +0200, Christian Meder wrote:
> > -------
> > /<project>/blob/<blob-sha1>
> > /<project>/commit/<commit-sha1>
> 
> It is trivial to find an object when given a sha, but to know the object
> type you'd have to decompress it and check inside. Also the way git
> stores these things you can't have both a blob and a commit with the
> same sha anyways.
> 
> So why not use,
>     /<project/<hexadecimal sha1 representation>
> 	will give you the raw object.
> 
>     /<project/<hexadecimal sha1 representation>.html (.xml/.txt)
> 	will give you a parsed version for user presentation

Because this gives you more type control, and type control is good where
it makes sense (i.e. the types are completely orthogonal). It makes
sense here - either you _know_ your sha1 is of given type, or you don't
know at all what are you doing.

Also, when looking at an URI, you can immediately say what type of
object does it point at. I actually consider that a pretty important
property.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
