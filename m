From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: tree view: hash_base and hash are now context sensitive
Date: Thu, 28 Sep 2006 11:52:32 -0700 (PDT)
Message-ID: <20060928185232.96094.qmail@web31802.mail.mud.yahoo.com>
References: <20060927225342.7695.qmail@web31801.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, ltuikov@yahoo.com
X-From: git-owner@vger.kernel.org Thu Sep 28 20:53:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT10a-0004em-QX
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 20:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbWI1Swz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 14:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbWI1Swf
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 14:52:35 -0400
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:22691 "HELO
	web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751980AbWI1Swd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 14:52:33 -0400
Received: (qmail 96096 invoked by uid 60001); 28 Sep 2006 18:52:32 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6HbhmpLIakwWCUbCVv25QSH6aEg1sQa8HoGKb86SyOi0tqO+dKmsPBM32FlrANXR9vb92AwR8seeiAlHi0iFy55lEyFSGDtQE/xjwBjFvKALUNUe12w19vwasR0VPgF5bJ9dk0PfYGuusTX1ltdOeTFwSRaiJmchZ9xvSN5yNcc=  ;
Received: from [64.215.88.90] by web31802.mail.mud.yahoo.com via HTTP; Thu, 28 Sep 2006 11:52:32 PDT
To: ltuikov@yahoo.com, Junio C Hamano <junkio@cox.net>,
	Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <20060927225342.7695.qmail@web31801.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28034>

--- Luben Tuikov <ltuikov@yahoo.com> wrote:
> --- Junio C Hamano <junkio@cox.net> wrote:
> > Luben Tuikov <ltuikov@yahoo.com> writes:
> > 
> > > --- Jakub Narebski <jnareb@gmail.com> wrote:
> > >> I think that this need some thinking over. For blob we have two
> > >> "base" objects: tree which have specified blob, and commit which
> > >> have tree which have specified blob. We might want to specify
> > >> that all hash*base are to the commit-ish.
> > >
> > > Agreed, we should always refer to the commit-ish, for obvious
> > > reasons.
> > >
> > > This patch doesn't make this decision though.  It simply
> > > sets hash_base to HEAD if not defined.
> > >
> > > Now, since "git-ls-tree" works on both commit-ish and
> > > tree-ish, we are ok.
> > 
> > I think so, too.  Jakub?
> 
> Status?  I see Jakub hasn't objected, and it is really important
> for us to be able to link to "latest" binary blob -- for example
> a PDF spec file.

Junio,

What are the objections to this patch?

Thanks,
   Luben
