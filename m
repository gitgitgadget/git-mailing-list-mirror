From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Question about 'branch -d' safety
Date: Mon, 19 Jul 2010 21:22:05 +0200
Message-ID: <20100719192205.GA21744@localhost>
References: <20091230065442.6117@nanako3.lavabit.com>
 <m3lj9jknlr.fsf@localhost.localdomain>
 <20100711065505.GA19606@localhost>
 <201007110916.29567.jnareb@gmail.com>
 <20100711133730.GA10338@localhost>
 <20100717093006.GA11452@localhost>
 <7v7hkrpcrk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 21:22:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oavv1-0001hC-TG
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 21:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966488Ab0GSTWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 15:22:19 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38429 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965996Ab0GSTWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 15:22:17 -0400
Received: by ewy23 with SMTP id 23so1420062ewy.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 12:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=oF2zin+0n3/zXqM2LNbpua3NMD5WTItEJKXk6EwDoVI=;
        b=Ia4IVRQy9SegOiNrCxEQy156eshcETzkO5q0Z5Gs+0B4TLd5VY64YQwDIpwfDFVjeu
         dcNN2jRDkhkYT0kb/ZRSzcwEQ5DBJ47lH46fk8BL5mtH6Ex4b0u/iv4wRTyORXbzIr9O
         QbxsbNDrkg0osDDSnfAM3DG6d5gqxYMbQ3FYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=xf/GV71QX9I9fyLNRLGHazFfaJreeXF3Pxt60K3xzOc1dOnhbEmelr3Gj6Mg3DfBx0
         ooDHi1xDT9d2zO0a5f8Wl4SnuUZNgqPhpMDaqE/RehxQu/DLliAzCvczZpQyQRc0rexh
         2Rnt0zGBWFM+IjuPc6sbfEpgg0KRSdrt6uzhU=
Received: by 10.213.16.137 with SMTP id o9mr5060115eba.86.1279567336245;
        Mon, 19 Jul 2010 12:22:16 -0700 (PDT)
Received: from darc.lan (p549A3118.dip.t-dialin.net [84.154.49.24])
        by mx.google.com with ESMTPS id a48sm49974317eei.6.2010.07.19.12.22.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 12:22:14 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1Oavuf-0005jX-Nz; Mon, 19 Jul 2010 21:22:05 +0200
Content-Disposition: inline
In-Reply-To: <7v7hkrpcrk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151270>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 19, 2010 at 11:06:23AM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
>=20
> > + less dependant on git branch -d
> >
> > Since git branch -d deletes branches which have been merged to a
> > remote tracking branch, it does no longer guarantee that the branch
> > is still available in history locally, and if the branch is also
> > deleted remotely, running git remote prune removes it entirely.
>=20
> Sorry, I have no idea what you are talking about in this paragraph.  I
> cannot read "Who depends on git branch -d to achieve what" from your
> description.  All I read in the above description is that what the command
> does is a good thing.  If you want to keep the remote tracking branches
> around, don't run "branch -d".  If you do want to remove the history of a
> branch, run "branch -d".  Isn't it that simple?

So why do we have "branch -d" in the first place? Exactly because I
do _not_ want to reomve the history of a branch. I just want to
remove the reference to it, because it has already been merged and
is therefore of no interest any more.

> Perhaps the missing "achieve what" may be that "output from 'git branch'
> is too cluttered if I don't remove already merged branches as early as
> possible, and forces me to run 'git branch -d' to clean things up too
> often"?  If that is the issue you are trying to address, perhaps we can
> solve that in a more direct way, e.g. "git branch --no-merged" easier to
> access?

That would only delay the need for cleanup. And when I do the
cleanup, I have typically forgotten what the branch contains
exactly. So I like to use "branch -d" to find out if the branch
potentially contains something interesting, and get rid of it
immediately if it does not. If that does not work I have no choice
but to look at the branch before deleting it blindly.

And I used to consider both "branch -d" and "remote prune" to be
safe, because I knew that at some point I would have had to use
"branch -D" in order to actually lose history. Now this is not true
any more due to the scenario described above. In that sense,
"branch -d" is now pointless, because it's hardly safer than
"branch -D".

So this process is where a cannot depend on "branch -d" any more.

> > - user interface complexity
> >
> > How to prune deleted branches? Currently, it is enough to do "git
> > branch -D branch; git gc --prune" in order to get rid of the branch
> > objects, at least if the HEAD reflog does not contain it or has
> > expired. Consider for example adding a remote, and removing it
> > again. This operation would leave a bunch of deleted branches,
> > which potentially occupy a lot of disk space.
> >
> > How to find and restore deleted branches? If the reflog is used to
> > record deleted branches, and a new branch of the same name is
> > created, the reflog contains entries from unrelated branches. [1]
> > If the deleted reflogs are stored in an attic, how do we reference
> > those?
>=20
> This is the area I am most concerned about.

Below you explain that we not need this feature, because we can do
backups instead. I disagree. But even if I were to agree, why are
you concerned about that? Even if you do not use the feature
personally, does it do any harm?

The effort necessary to permanently delete a branch (delete,
expire, prune) will stay exactly the same. The reflog syntax can
also stay the same. We only really need new commands to list and
recreate deleted branches.

> If you take an analogy in say a file server implementation, yes, it should
> not be easy to lose information there.  But it is and should be easy to
> say "rm junk".  How would people recover from a mistake if they typed a >=
 wrong filename, "rm junio" to lose a precious file "junio", when they
> meant to lose "junk"?  They go to backups.

Backups are a good measure to protect against loss of large amounts
of data. They do not protect very well from an accidental "rm
junio", because that only works if junio was already in the latest
backup. Protecting against small-scale changes is exactly what a
version control system is good at. And they are much superior to
backups, because they keep history.

> Can't git users do the same?
> After all, .git directory is stored on a filesystem of some sort, and
> taking a backup (you do take backups, don't you?) and picking the stuff
> you lost from there should be a standard procedure that can be learned
> outside of the context of git.

I usually use git for my more frequent backups. I put everything
that changes a lot and contains much personal work under version
control.

Clemens

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMRKXWAAoJELKdZexG8uqMQUMH/iy1KG3LVRHGurZh5ORTV87R
Gjc1spDWyei7vco5wQALNcu1XR+BvDbMKy7xW/VWRB7vTxj5Lbt/xY3U8RxJDMf8
Ox5P+5WDM/v9EuSvMyl2gCvnv2AE3RXldJiJjO98vZsLoKQshXpRoYPIyAWIA8Ww
aT4V1egiPplZrz74BVPQUbpr/Ki+Xm4znxhIMvmBd7DVZcDHtXDw8sNHw+iKQd87
mGr28A2+gTcDp7BYAtDJHHsghxP7QYGSM9NkW4KBRVxwcV64eA/YbvXs6DXMpxP9
RXZq7Psr6Yf9NidgrJFxc/m430VzqgHYGG1Q8EbhSLY25jCW/A5pRscfx/jbRjE=
=aLdm
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
