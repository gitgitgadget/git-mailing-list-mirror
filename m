From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: svn to git, N-squared?
Date: Mon, 12 Jun 2006 12:44:07 -0400
Message-ID: <9e4733910606120944p4deb170ejc2863846685917f6@mail.gmail.com>
References: <20060612043949.20992.qmail@science.horizon.com>
	 <9e4733910606120832xaf74e77pad7f70df864541fc@mail.gmail.com>
	 <Pine.LNX.4.64.0606120843340.5498@g5.osdl.org>
	 <9e4733910606120855p1cec9acfy62dadb89c11756b4@mail.gmail.com>
	 <Pine.LNX.4.64.0606120906210.5498@g5.osdl.org>
	 <9e4733910606120922g181a5aaal623fd3f29b839f4c@mail.gmail.com>
	 <Pine.LNX.4.64.0606120938490.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 18:44:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FppWP-0002BV-SW
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 18:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbWFLQoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 12:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbWFLQoJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 12:44:09 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:23168 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752130AbWFLQoI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 12:44:08 -0400
Received: by nz-out-0102.google.com with SMTP id 16so1071526nzp
        for <git@vger.kernel.org>; Mon, 12 Jun 2006 09:44:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nwSzmYP3sBWHDuCd70Olf/j1jB8bD+QUMgQbP7GUbRXZ/EPtd7HVa8Ezqf0CsjrjNEH1n6wN6FT9xrbOAH4QZ35u1PVg1DbJ/TgjlpdwipgkEX3PA8aiIxnBnzKckYCnD46Jx/c+02zgcX5zBmBq/SIIrbA5xGzKMZuJDsCz0Go=
Received: by 10.36.118.13 with SMTP id q13mr9034880nzc;
        Mon, 12 Jun 2006 09:44:07 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Mon, 12 Jun 2006 09:44:07 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606120938490.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21716>

On 6/12/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > Is there some pack equivalent for svn that I haven't found yet?
>
> Is this literally what SVN does normally? That's just insane. I mean, even
> git tried to at least hash out the files (and yeah, admittedly even that
> worked less well than I was hoping for, but I at least fixed it within
> just a few weeks through the pack mechanism).
>
> Or is that 411,000 files a result of how git-svnimport does things, rather
> than some basic SVN approach to live: does it perhaps end up checking out
> each file under an individual temporary name?

The svn repository was built by cvs2svn, none of the git tools were involved.

-- 
Jon Smirl
jonsmirl@gmail.com
