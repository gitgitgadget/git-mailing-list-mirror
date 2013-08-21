From: Zheng Liu <gnehzuil.liu@gmail.com>
Subject: Re: [GUILT] add FreeBSD support
Date: Wed, 21 Aug 2013 10:04:56 +0800
Message-ID: <20130821020456.GA6217@gmail.com>
References: <1376051548-3126-1-git-send-email-wenqing.lz@taobao.com>
 <20130809144641.GK22686@poseidon.cudanet.local>
 <68E9B1AC-A3A3-47DD-B0A7-07752428D16D@gmail.com>
 <20130809152046.GL22686@poseidon.cudanet.local>
 <20130820074415.GA27247@gmail.com>
 <20130820152547.GC8172@poseidon.cudanet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed Aug 21 04:04:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBxmR-0008Rk-Do
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 04:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978Ab3HUCEL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Aug 2013 22:04:11 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:65029 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab3HUCEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 22:04:09 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf1so201804pab.24
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 19:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K7czpOAy7VHokMzWHlQYXPIztN1MxNWjiRbYYrersFY=;
        b=Ja7SU2EyDdrmCmaCsYVm9EsDtTmDM1sQKckfSNDFRka0PLVR46Cqx3DOVgpZ59fsNV
         dIr01rkVoboBSTY0MXgzdsFVmnIirAYgC0lT+B9jyflbNdqLwGd7uT+BwBN3rI4nlYsZ
         irlZ+zvBkE0wHhxA637ehG3ehtXASouIu1C4nYzJjpN8iXa0oLDjngDmgSc2byqv3nT9
         68B29PFe+TTSoAmrR0db9LyRlWgGm6uCvXFXEBx6Ut/cCpsB9Qz6Hdato9ZKM+30DKz6
         HaHUzPSqoO85aAhzZJzNrFT/plYU0STHJkSNwV58GXHHwJ55guX3JgDhIfQZGck5Qh4g
         XZtg==
X-Received: by 10.68.235.37 with SMTP id uj5mr5172633pbc.85.1377050649404;
        Tue, 20 Aug 2013 19:04:09 -0700 (PDT)
Received: from gmail.com ([182.92.247.2])
        by mx.google.com with ESMTPSA id om2sm5004161pbc.30.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 19:04:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130820152547.GC8172@poseidon.cudanet.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232676>

On Tue, Aug 20, 2013 at 11:25:48AM -0400, Josef 'Jeff' Sipek wrote:
> On Tue, Aug 20, 2013 at 03:44:16PM +0800, Zheng Liu wrote:
> > Hi Josef,
> >=20
> > On Fri, Aug 09, 2013 at 11:20:46AM -0400, Josef 'Jeff' Sipek wrote:
> > > On Fri, Aug 09, 2013 at 11:04:45PM +0800, gnehzuil.liu wrote:
> > > > ?? 2013-8-9??????10:46??Josef 'Jeff' Sipek <jeffpc@josefsipek.n=
et> =D0=B4????
> > > >=20
> > > > > On Fri, Aug 09, 2013 at 08:32:28PM +0800, Zheng Liu wrote:
> > > > >> From: Zheng Liu <gnehzuil.liu@gmail.com>
> > > > >>=20
> > > > >> Currently guilt doesn't support FreeBSD platform.  This comm=
it tries to
> > > > >> add this support.  The file called 'os.FreeBSD' is copied fr=
om os.Darwin
> > > > >> due to these two platforms have almost the same command tool=
s.
> > > > >=20
> > > > > Out of curiosity, is it identical?  I eyeballed it, and they =
do look
> > > > > identical.  There's probably a better way to do this whole os=
-specific
> > > > > thing, but this will work well enough for now.
> > > >=20
> > > > Yes, it is identical.  Sorry, I am a newbie for guilt, but I am=
 happy to
> > > > improve this os-specific thing.    Any idea?
> > >=20
> > > So, I'm a bit torn between some "build-time" checking that genera=
tes
> > > something like an "os" file based on what it detects and somethin=
g that
> > > happens at runtime.  I like that currently there's nothing to do =
- you just
> > > clone the repo and you're set.  At the same time, the more code c=
an be
> > > avoided executing the faster (in theory) guilt gets.
> >=20
> > Sorry for the late reply.  I did a simple experiment that tries to =
fold
> > all os.* files into one file and uses a if statement to export func=
tions
> > according to different platforms.  But frankly I don't like this be=
cause
> > it is not very clearly.  So IMHO we'd better add a 'os.FreeBSD' fil=
e to
> > support FreeBSD platform.
>=20
> Yeah, sounds like the simplest (at least for the moment).  I'll commi=
t it.
> Thanks.
>=20
> FWIW, the idea I was thinking about was to make "make all" figure out
> various parts of the system and construct an os file.

Yes, I thought this.  We can create a os.in file and generate a os file
after running "make" command.  But currently os.* looks like the
simplest solution.

Regards,
                                                - Zheng
