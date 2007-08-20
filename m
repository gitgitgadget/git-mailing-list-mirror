From: Tom Schinckel <gunny01@gmail.com>
Subject: Re: Git Questions
Date: Mon, 20 Aug 2007 21:45:56 +0930
Message-ID: <1187612156.11595.17.camel@tom-desktop>
References: <1187603749.11595.10.camel@tom-desktop>
	 <87bqd2bgb0.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?ISO-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Aug 20 14:17:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN6C5-0001PB-Ml
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 14:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234AbXHTMRO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 20 Aug 2007 08:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756091AbXHTMRO
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 08:17:14 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:7039 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813AbXHTMRN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 08:17:13 -0400
Received: by rv-out-0910.google.com with SMTP id k20so952774rvb
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 05:17:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=YVESbVGBwtnYM4Nyr5RZdbjse+vie4Y0XAm53jv0Fde00OJfiApg00bajGqJ2SMQ+xD3eGgr0XgkMra8Tg/suVvr3v/dbSa9kjuNgjU947/MSwC55SCUQ3wQk8EGE3B8khn5plyIJYMUpdFHEGv0QNbBwB/B9NiS6ss2J885Xv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=mKQVt8GO7PHPJDtk/apdojmQc0R+BqIS9JF+zJ1hEJGv68IqgMjL2veXLSHnC2Jr9jbMqPkGPkMilJSMFK98cEReMxLisQAA7BlVLDLEpV7jY/9Aa8rfaBSEcoc1VcMXBNBSlJ/w3gXogY6syB/iv1b/6YsjaeDtm7iL3ADdqok=
Received: by 10.141.28.12 with SMTP id f12mr2648612rvj.1187612232029;
        Mon, 20 Aug 2007 05:17:12 -0700 (PDT)
Received: from ?192.168.1.67? ( [121.45.94.82])
        by mx.google.com with ESMTPS id c19sm804330rvf.2007.08.20.05.17.09
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Aug 2007 05:17:10 -0700 (PDT)
In-Reply-To: <87bqd2bgb0.fsf@morpheus.local>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56210>

On Mon, 2007-08-20 at 13:23 +0200, David K=C3=A5gedal wrote:
> Tom Schinckel <gunny01@gmail.com> writes:
>=20
> > Hi all,
> >
> > I've just started using git to run a repository on my local machine=
=2E I'm
> > wondering about the following questions:
>=20
> You seem to have a very strange use case that you need to explain
> better.

What I'm using it for is to essentially create a history of various
documents and other files that I'm creating. So if I accidently delete
something or want to make a major change in the direction of an essay o=
r
the like.=20

(If anyone reads Linux Format, there was an article about a year ago
about "Subverting your Home Directory". I'm doing a similar thing, but
with git)

>=20
> > Is it possible to change the revision numbers from long hashes to n=
ormal
> > numbers (i.e, 0001 for first, 0002 for the second)
>=20
> There are no "revision numbers" in git.  There is only content.  The
> history of commits is created by having one commit point to its
> "parent" commit.  And in git, everything is addressed by its content,
> by using hashes.  So the long hash is a universal identifier for what
> it refers to.  It is not a revision number in your repository, it is
> something that can be used by someone else who hasn't even heard of y=
o
> to refer to exactly the same thing.
>=20
> So, no you can't change that.  But there might be something else that
> you can do if you explain what you're actually after?
>=20

Gotcha.

> > Can I set up Git to:
> >
> > a) Automatically commit a file to the repository every time it's sa=
ved
>=20
> Probably, but remember that git doesn't track individual files.  It
> tracks the whole tree, so you would be creating a new revision of the
> whole tree every time you saved that single file.  Which would not
> create a very nice history if you are using git for something it
> usually is used for (tracking source code etc).
>=20
> > b) Automatically use the default hashed-out bit:
> >
> > 	# Please enter the commit message for your changes.
> > 	# (Comment lines starting with '#' will not be included)
> > 	# Updated but not checked in:
> > 	#   (will commit)
> > 	#
> > 	#       modified:   TOK/bce.abw
> > 	#
> > 	# Untracked files:
> > 	#   (use "git add" to add to commit)
> > 	#
> > 	#       TOK/bce.abw.bak~
> >
> > as the commit message? (i.e, remove the hash signs and not bring up=
 vim
> > in the first place?)
>=20
> Why on earth would you want to do that?  That comment doesn't contain
> any information about what change you committed?  The list of files
> that were modified by the commit is already in git.

The reason I want to do that is so I can set up blind commits that I ca=
n
add in a anacron job or something. The information about the files isn'=
t
really important

Thanks for the help: I'm using git in a uncoventional way.=20

tom
