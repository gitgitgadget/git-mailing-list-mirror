From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 15:29:35 -0700 (PDT)
Message-ID: <20060928222935.66578.qmail@web51012.mail.yahoo.com>
References: <20060928195056.GA3751@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Rogan Dawes <discard@dawes.za.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 00:29:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT4Nv-0005zF-Ow
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 00:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161339AbWI1W3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 18:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161340AbWI1W3h
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 18:29:37 -0400
Received: from web51012.mail.yahoo.com ([68.142.224.82]:8325 "HELO
	web51012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1161339AbWI1W3g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 18:29:36 -0400
Received: (qmail 66580 invoked by uid 60001); 28 Sep 2006 22:29:35 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=BSzUkfYmplVqbylW42JxWzGB6JbqUp96h/61aXq/M8RYvhx+DhOoJzGvPuqyiRYNOsf19FkNrEct82Wqc0ED4oB6lQ/ZJXZIwuQuVTVCq6dFCQm/BNmEwDtppdq4EzOJcS1/X7IRgcv4bsMcDXjljlKZJ0wrBYsuCyRFJuvCYKA=  ;
Received: from [207.172.80.85] by web51012.mail.yahoo.com via HTTP; Thu, 28 Sep 2006 15:29:35 PDT
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060928195056.GA3751@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28060>

--- Shawn Pearce <spearce@spearce.org> wrote:

> > - So exported data is never/rarely in an inconsistent state with respect to commit order and
> > local time order (data integrity).
> 
> Pick one.  You can't have "never" and "rarely".

I mean "rarely" in the sense that there is no guarantee that local time is exact but any
inexactness would be confined locally.
 
> Track it by version, not timestamp.  Know what commit or tag SHA1
> was used to produce that binary.  Ask GIT if the fix is in that
> SHA1 ancestory or not.  I've already said that on this thread.

So you are saying time, even local commit time, is completely unnecessary? I disagree. Git doesn't
need to keep track of any times in a distributed way, it just might be worthwhile to keep track of
local commit timestamps internally per repo.

> I think they care more about what release of the kernel will have
> that driver.  That can easily be determined by the DAG and by
> understanding what branch(es) will wind up in the next release and
> doing simple math: "Lets see, current release is version 2.6.9000,
> so it will be in 2.6.9001."

Even if people care more about "what release" that doesn't mean they don't care about (local
commit) time.

-Matt


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
