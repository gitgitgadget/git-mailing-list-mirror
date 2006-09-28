From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 19:29:17 -0700 (PDT)
Message-ID: <20060928022917.29678.qmail@web51011.mail.yahoo.com>
References: <20060928013611.GC7469@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 04:29:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSleL-0006Vi-M8
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 04:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965218AbWI1C3T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 22:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbWI1C3S
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 22:29:18 -0400
Received: from web51011.mail.yahoo.com ([68.142.224.81]:61621 "HELO
	web51011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S965218AbWI1C3S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 22:29:18 -0400
Received: (qmail 29680 invoked by uid 60001); 28 Sep 2006 02:29:17 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=sherjmVR239spRzpYVZS5ATblo0f2CXUiYKb4nOj7lu3zGvXbvZq8E1S3I3e6S5YhlBqBTbRoicWSiNiawPwkY2m9l+Zg4rMhfwJDtorUugj0H88R9W8cFRt5nmPRrOHvl3MFcIN6dcCcc+pCV2DSQMnt/bU33t30/eRLcONgEg=  ;
Received: from [207.172.80.85] by web51011.mail.yahoo.com via HTTP; Wed, 27 Sep 2006 19:29:17 PDT
To: Theodore Tso <tytso@mit.edu>
In-Reply-To: <20060928013611.GC7469@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27968>

--- Theodore Tso <tytso@mit.edu> wrote:

> On Wed, Sep 27, 2006 at 05:12:41PM -0700, Matthew L Foster wrote:
> > 
> > Ignoring the separate issue of replication for a momment, can
> > someone respond to my time integrity question about whether a future
> > version of git could trust/prefer its local time rather than a
> > remote/sub/parent (non replicated) git server's timestamp? 
> 
> No, it can't.  In order to do that it would have to change the commit,
> and that would be rewriting history.

Perhaps the actual change itself should not contain a "commit time", only "local commit time"
should matter or be tracked locally (if time is tracked/matters any). To repeat from a previous
mail, I am not saying timestamps (local or other) should be tracked in a git distributed way,
quite the opposite, local commit time should be tracked locally. 

Replication is a separate issue if I understand git any. Please correct me if I misunderstand: the
kernel.org gitweb.cgi linux repo time inconsistencies happened when Linus pulled into his
_private_ repo from a remote git server with misconfigured time, _not_ when he later replicated
those errant timestamps from his private repo to the public kernel.org one. I don't care nearly as
much about replication not being time aware, I care about a _merge_ from a remote misconfigured
git server making timestamps inconsistent with commit order. Using/prefering local time could
solve this but perhaps I am the only one that thinks local time is most important.

-Matt


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
