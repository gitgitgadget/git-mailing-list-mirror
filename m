From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: reducing line crossings in gitk
Date: Fri, 17 Jun 2005 01:05:29 +1000
Message-ID: <2cfc403205061608053664cc1e@mail.gmail.com>
References: <17066.53047.660907.453399@cargo.ozlabs.ibm.com>
	 <7v8y1gvjfz.fsf@assigned-by-dhcp.cox.net>
	 <17072.3723.242985.824999@cargo.ozlabs.ibm.com>
	 <2cfc40320506150534380bb5f8@mail.gmail.com>
	 <17073.28667.819809.89026@cargo.ozlabs.ibm.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 16 17:02:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Divri-0005A6-Je
	for gcvg-git@gmane.org; Thu, 16 Jun 2005 17:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVFPPFw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Jun 2005 11:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVFPPFw
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jun 2005 11:05:52 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:17362 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261654AbVFPPFd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2005 11:05:33 -0400
Received: by rproxy.gmail.com with SMTP id i8so351095rne
        for <git@vger.kernel.org>; Thu, 16 Jun 2005 08:05:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G58RlhWXnlWw8R1gaRzRjlLzRtHusEX9+A9FsZRUI2zGIvVedpqSkgP/N9Q4p/hJk1pIGmtG5qQne/1pwtcSEw5EMr8TWlMu4qBCPgNbkIa1ztMXxiwCpy+SW40iLEptadk3ayNM9dUyMoXzmenw2Ze2JVU0tCkghECa2Jy6aF4=
Received: by 10.38.66.4 with SMTP id o4mr611165rna;
        Thu, 16 Jun 2005 08:05:29 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Thu, 16 Jun 2005 08:05:29 -0700 (PDT)
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17073.28667.819809.89026@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/16/05, Paul Mackerras <paulus@samba.org> wrote:
> Jon Seymour writes:
> 
> > Another feature that would be handy is the ability to be able to
> > create tags by pointing to an item and selecting a "create-tag"
> > action. The effect would be to write the SHA1 id into
> > GIT_DIR/refs/tags in the expected way.
> 
> Hmmm, that would create a "direct" tag, not a normal tag, which is
> an object of type "tag" that contains a reference to a commit along
> with some other stuff.
> 
> In general I'd like to keep gitk as purely a viewer.  Ultimately I'll
> probably do a graphical tool for checking stuff in and other
> operations that modify the repository as well, but I think that should
> be a separate tool.
> 
> Regards,
> Paul.
> 

Fair enough... the reason I suggested it is that I use gitk to help me
decide how to merge stuff with the mainline. Currently I have to cut
and paste the ids of the "interesting" commits into the command line.
It would be nice to be able to point directly to an interesting commit
and tag it so that I can later get to it from a command line using a
name I can remember.

Still, I can quite accept that I have an idiosyncratic way of
interacting with git and gitk.

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
