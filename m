From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: a few beginner git questions
Date: Sun, 7 Mar 2010 12:08:34 +0300
Message-ID: <20100307090834.GB31105@dpotapov.dyndns.org>
References: <15b345f1003052242r7d812fe4q6ade253283696304@mail.gmail.com>
 <20100306070533.GL2480@ece.pdx.edu>
 <15b345f1003061823u2d7edeeo25229f0a32456f45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tait <git.git@t41t.com>, git@vger.kernel.org
To: Thomas Anderson <zelnaga@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 10:08:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoCTe-0004ND-Kc
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 10:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870Ab0CGJIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 04:08:40 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:38706 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab0CGJIi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 04:08:38 -0500
Received: by fg-out-1718.google.com with SMTP id l26so782193fgb.1
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 01:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EDTZjzg+rIpt052Wg+Vh0HzQBmuYQJpLKPbQK5leAsM=;
        b=UUwOX1TRp92t9xkPgcWycfdz36wQeZVElOghGml8+QH7odtW1oerCYvzWWP6VO8RZw
         MD6nD/7yeEpxWeUkK5afyNACz3xdYRzUkF+JQWoKVrBvru15qs10KKqRGHyiyH0notrw
         8kc6TkSk5tV6nAW2/aOVa7uQBANN+uxqNEoKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Bg6Ag2BHk1/hsYFhK71h/OEd7Jpq6IF//uc+hJtO/qaQMxH/1OmajAFywOwFUkuo5T
         Ycc/OV74X4rrlDo/iUwkGI3IQ0/7yUR3FmFSrRQYEegq4Av4dUK3Xa//eDJ63MwzvZq5
         0c7k+5bHnhln7nJ/RQIIkRczz49fgsuiGITSc=
Received: by 10.103.76.21 with SMTP id d21mr228414mul.17.1267952916703;
        Sun, 07 Mar 2010 01:08:36 -0800 (PST)
Received: from localhost (ppp91-77-225-63.pppoe.mtu-net.ru [91.77.225.63])
        by mx.google.com with ESMTPS id 23sm17394974mun.37.2010.03.07.01.08.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 01:08:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <15b345f1003061823u2d7edeeo25229f0a32456f45@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141682>

On Sat, Mar 06, 2010 at 08:23:18PM -0600, Thomas Anderson wrote:
> 
> What's the difference, then, between doing "stage, stage, commit" as
> opposed to "stage, commit"?

Probably none... If you stage twice the exactly same file, it does not
change anything. But if you "stage, stage" means to stage two different
files while "stage" is to stage just one then the outcome will be
different.

> Why not just make all commits stage automatically?

The goal of the stage area is to mark what changes you want to commit.
So, one commit will contain only one semantic change and not everything
what you have in your working tree at that moment. CVS also allows to
not commit all changes at the same time (you can specify what files to
commit in the command line), but with Git you can not only to choose
what files but also what change in each file you want to commit now.
More importantly, git allows you to look at the stage area and see what
you are going to commit.

In simple cases, you can just do "git commit -a" which means to commit
all changes for all tracked files or "git commit somefile" to commit
changes only in "somefile".


Dmitry
