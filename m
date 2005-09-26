From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Mon, 26 Sep 2005 23:56:47 +0200
Message-ID: <20050926215647.GD26338@pasky.or.cz>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz> <20050926212536.GF26340@pasky.or.cz> <43386E56.8000208@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 23:57:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK0xy-0007ZD-MR
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 23:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVIZV4v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 17:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVIZV4v
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 17:56:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:27313 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932336AbVIZV4v (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 17:56:51 -0400
Received: (qmail 15478 invoked by uid 2001); 26 Sep 2005 23:56:47 +0200
To: Brian Gerst <bgerst@didntduck.org>
Content-Disposition: inline
In-Reply-To: <43386E56.8000208@didntduck.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9340>

Dear diary, on Mon, Sep 26, 2005 at 11:55:34PM CEST, I got a letter
where Brian Gerst <bgerst@didntduck.org> told me that...
> Petr Baudis wrote:
> >If it's NOT a commit, well, that's a question.  On the assumption that
> >it won't be a great deal of data and it's likely to be assumed that we
> >have it, I would be inclined to fetching it, but I don't feel strongly
> >about it.
> 
> It could point to a tree (ie. the kernel's v2.6.11 tag), which may end 
> up being a large pull.  I think it's best to not care what type of 
> object the tag references.

Yes, but the object may not be reachable in any other way.

Simple question - if you have a tagged blob containing a GPG public key
(let's call it.. hmm.. e.g. junio-gpg-pub ;), would you expect Cogito to
ignore it or pick it up?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
