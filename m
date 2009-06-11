From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: EasyGit Integration
Date: Wed, 10 Jun 2009 17:15:53 -0700 (PDT)
Message-ID: <m38wjz4odq.fsf@localhost.localdomain>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	<alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
	<51419b2c0906091530t3dfa5267s2262f979f1e9982a@mail.gmail.com>
	<alpine.LFD.2.01.0906091535410.6847@localhost.localdomain>
	<20090610033211.GA7411@mit.edu>
	<alpine.LFD.2.01.0906092058430.6847@localhost.localdomain>
	<94a0d4530906101531ja6f1deeob703f546d62e7599@mail.gmail.com>
	<alpine.LFD.2.01.0906101555590.6847@localhost.localdomain>
	<d411cc4a0906101657v601aba20q5708e114fc7d4bca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Theodore Tso <tytso@mit.edu>, Elijah Newren <newren@gmail.com>,
	git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 02:16:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEXxd-0006e4-ET
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 02:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760544AbZFKAPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 20:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758959AbZFKAPx
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 20:15:53 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:36723 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959AbZFKAPx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 20:15:53 -0400
Received: by fxm9 with SMTP id 9so1198507fxm.37
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 17:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=dbcHtF8VsVipK6tt07ozr1LbIbStqFtx139XB3G+xi0=;
        b=Dafkiev/JZsr1fo+dBwwcVT9FsLPzZ0LfA3lEATvg+wAfUuzuKzq8vMn+Yg44xv08W
         zxX2XvRHvPlD3ol87T/Nh4/ILdoJUI3xKgWq5/OHA3Blt58YtvCQD3tzUHCyydOqAKVC
         rz0vmmOqGClXeSydMZXfc0DK9enmGOs9iPjK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=DYVBzB+Yecz2qi6fMANVlE/0Ecuco4P4ifkAtRGc4hTGNHCVCNTdwCiaG5s555i09c
         GQTvwLNMH0UIq6+oEcsU1YApa+lss69sHh9jgtzQQxWn1Apuzcu7wx6c2iLFVqkT/Dva
         rUSuockH8vG78sLuVHov7oTf2qlOMeUzM2OvA=
Received: by 10.103.121.19 with SMTP id y19mr975214mum.103.1244679354220;
        Wed, 10 Jun 2009 17:15:54 -0700 (PDT)
Received: from localhost.localdomain (abwl198.neoplus.adsl.tpnet.pl [83.8.235.198])
        by mx.google.com with ESMTPS id i5sm14655915mue.25.2009.06.10.17.15.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Jun 2009 17:15:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5B0FaS4002897;
	Thu, 11 Jun 2009 02:15:42 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5B0FE36002888;
	Thu, 11 Jun 2009 02:15:14 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <d411cc4a0906101657v601aba20q5708e114fc7d4bca@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121319>

Scott Chacon <schacon@gmail.com> writes:
> On Wed, Jun 10, 2009 at 4:04 PM, Linus
> Torvalds<torvalds@linux-foundation.org> wrote:
> >
> > IOW, both would be "if you give it a commit, it acts at a commit level",
> > and "if you give it pathnames, it acts on a pathname level".
> >
> > That is totally obvious, and not in the least confusing. They are two
> > different things, but at the same time, there is no question about which
> > is which.
> >
> >> In my mind these are 2 completely different commands.
> >
> > They are two different things, but they both make sense within the
> > _context_.
> >
> > Only earthworms and FOX news have no concept of "in context". So it does
> > make sense to say "git checkout filename" (and expect it to check out that
> > _filename_ - surprise surprise), and also say "git checkout branch" (and
> > expect it to check out that branch - again, big surprise).
> 
> The problem here is that you're using 'check out' in your descriptions
> of the expectations to mean two different things.  One means 'switch
> branches' and the other means 'extract content'.

In both cases it means getting something out of repository (checking
out) and into working area.

> If you provide both
> a branch and a filename, what happens? It still means 'extract
> content'.  

If there is a filename,  then it is checking out a file or files.
If there is no filename, then it is checking out a commit.

Checking out commit means switching branch if it is branch name,
detaching HEAD if it is not branch name.

When you are checking out a file or set of files, you cannot change
branch; commit is state of a whole project, not of individual files.

> Not everyone assumes that 'checkout' can or should mean
> both of these things depending on context.  I mean honestly, the
> 'context' of 'git checkout branch' and 'git checkout branch file'
> doesn't really look that much different, but the command completely
> switches semantics from 'switch active branch' to 'extract content'.

Note that "git checkout <commit-ish>" was first (well, it was only 
"git checkout <branch>" then.

> It's not that the command assumes some subtle defaults depending on
> what arguments you give it - it's that it completely changes the
> nature of what it does depending on the arguments.  It only makes
> sense to us because we specifically learned that it did this, not
> because it makes sense intuitively.  Hell, _neither_ of these meanings
> are what SVN-inbound users are used to, which they map to 'extract
> content _from a remote server_'.

So perhaps _understanding_ those commands require understanding git
model.  I don't see how this is a bad thing.  You would have to learn
it anyway... ;-)

[...]
> I understand that clarity and ease of use is not really of primary
> importance to this project.  However, is it not slightly ironic that
> the Git project is so obsessed with squeezing 5% or 10% of raw speed
> out of each command, yet feels that the onus should be on each user to
> study for hours to memorize a bunch of arbitrary idiosyncrasies of the
> tool?  Can we not obsess a little about flattening the learning curve
> 10% as well (possibly at the slight expense of command normalization
> or verb bloat)?

The problem is bakcward compatibility and the fact that git was not as
much as designed, as it has grown.  Which is very good solution for
getting good feature set, but not so much for an UI...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
