From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz
 origin/frotz"
Date: Mon, 7 Jun 2010 23:12:53 +0200
Message-ID: <20100607211253.GA21738@localhost>
References: <AANLkTilbg2nGr_sVmJLboMgXbas_qsB4V6gYxDxcDgKy@mail.gmail.com>
 <20100605135811.GA14862@localhost>
 <AANLkTikE5BPD_DDqwEvPGxsMAIQCulpVwRKaCSnULcoP@mail.gmail.com>
 <20100606161805.GA6239@coredump.intra.peff.net>
 <20100606165554.GB10104@localhost>
 <AANLkTinTI3XaE6P_WZ_k56fgI4LNOLSalv_1GlVZNO7n@mail.gmail.com>
 <20100606173233.GA11041@localhost>
 <AANLkTilvHl-8eA6CbEDs4ty3h0h670L_enGsXunHxaPE@mail.gmail.com>
 <20100607182956.GA17343@localhost>
 <20100607221134.002ae81a@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jacob Helwig <jacob.helwig@gmail.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Peter Rabbitson <ribasushi@cpan.org>
To: Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Mon Jun 07 23:13:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLjd7-0007br-Bh
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 23:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642Ab0FGVNE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jun 2010 17:13:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45534 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab0FGVNB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 17:13:01 -0400
Received: by fxm8 with SMTP id 8so2456204fxm.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 14:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZI/JFPFSEEZPRQftOBRvKICQnXD4BvY2CkWmlrCX46c=;
        b=MEkJYaVJRczSl3sRMaSYHa5M8XDTsTjlKEjeDjMRLmTpNC6+G0U2JCTWhp+11iPCPy
         VZgqAj5nRCs+zq4s+fkJxBejlumeUrBKATWEFO3F/+weIDgg36u74HQlty3mC/jHLJ2J
         giYSLG9UG17XsyE31rYboTGq+gTcCHJGUnDWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=cNkJHDOOzvn98iOQqW7OD0orww7iNpzV/+0KVrHO/8vcIALU4jzq3+zMDKIqxfhLVm
         aD9OIJmdD064hH8CfoE7gTKrzGx9BY8qvUk3p6fNChKggOGgIrTAxPUO+yReHjj6Cyz/
         4CofWa0rM4E5Yr1VgWZ/QN04dhLR0jiMk6BKg=
Received: by 10.223.5.89 with SMTP id 25mr15648723fau.87.1275945179813;
        Mon, 07 Jun 2010 14:12:59 -0700 (PDT)
Received: from darc.lan (p549A5B93.dip.t-dialin.net [84.154.91.147])
        by mx.google.com with ESMTPS id r25sm22007317fai.23.2010.06.07.14.12.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 14:12:59 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OLjcr-0005he-MD; Mon, 07 Jun 2010 23:12:53 +0200
Content-Disposition: inline
In-Reply-To: <20100607221134.002ae81a@jk.gs>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148629>

On Mon, Jun 07, 2010 at 10:11:34PM +0200, Jan Kr=FCger wrote:
> Clemens Buchacher <drizzd@aon.at> wrote:
>=20
> > I am telling git to checkout a branch. Instead it creates a branch.
> > That is what is confusing to me. Until I found the commit that
> > introduced it, I was sure it must be a bug.
>=20
> I usually see the opposite kind of confusion on #git: someone cloned =
a
> repository and wants to work on one of the branches. After all, we te=
ll
> everyone that clone copies all the history.
>=20
> So they type "git checkout <that branch>"... and they get a weird
> error (what's a pathspec, anyway?).

I agree, that's a less than perfect error message. So let's improve
it. What about "unknown branch or file name"? Possibly also output
the most common synopsis?

> OMGWTFBBQ! Not knowing what's going
> on, they drop by in #git and hear they need to type something much le=
ss
> straightforward than "git checkout <that branch>". They don't really
> know why, so they probably assume it's because git is just so damn
> complicated and overengineered.

Well, but that's how it is. If we want more "global" branches, then
we will have to think about how to achieve that. But hiding what we
really have is not going to make it easier to understand.

> I have yet to see any newish users complain about the new syntax, by =
the
> way. You don't qualify, sorry. ;)

I started this entire thread only because someone on #git was
confused by it.
