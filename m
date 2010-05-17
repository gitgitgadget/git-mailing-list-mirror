From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Has anyone looked at Gettext support for Git itself?
Date: Mon, 17 May 2010 19:56:59 +0100
Message-ID: <1274122619.4780.36.camel@dreddbeard>
References: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
	 <201005171632.48253.trast@student.ethz.ch>
	 <AANLkTil0iESsCpHm-X3iiMZC3sEzCqYvXjsZiIHvFz3n@mail.gmail.com>
	 <201005171712.22763.trast@student.ethz.ch>
	 <20100517175939.GA3575@efreet.light.src>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon May 17 20:57:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE5V3-00044T-EK
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 20:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab0EQS5H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 May 2010 14:57:07 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36938 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab0EQS5F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 14:57:05 -0400
Received: by wyb39 with SMTP id 39so725512wyb.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 11:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=/qsliJN/yFXn9ES/y0ZRploH4f3LakDedUi0zpYUId0=;
        b=N4zi7yC2QtSw3kRsGz6Yrhq+ZwEWbrd/YYFqGYwXc87cKodwLRG4rLridVzcgPf+P9
         7IA49twez1b2kyi6IEQgsDDPwWUJ1DAq9OfQx1VSmNWVgJaKLd330M2QN1srtFzgv9W7
         Uz6IFyuz6908Snf83qRjBZ8Jy0uvtmHmxYU2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=PE5w7J2pLGE7H3XPKaGuzoQ6EHfG5MaedKr8BzzwGSdGdlUkLGl+B4oZjOa6/7iQXK
         ZnLbImgXlWj91Guu3w4VeGnhBzCC1J+WdoVOC7wnd49GAj+DLJlED/Qwxqb79kJ8LboM
         U7SBZfAYHyZBpr2We3EUbWnzlDHeQxxMYKPVI=
Received: by 10.227.134.193 with SMTP id k1mr5296052wbt.39.1274122622389;
        Mon, 17 May 2010 11:57:02 -0700 (PDT)
Received: from [192.168.0.129] (5acc3abb.bb.sky.com [90.204.58.187])
        by mx.google.com with ESMTPS id l23sm42489684wbb.20.2010.05.17.11.57.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 May 2010 11:57:01 -0700 (PDT)
In-Reply-To: <20100517175939.GA3575@efreet.light.src>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147250>

On Mon, 2010-05-17 at 19:59 +0200, Jan Hudec wrote:
> On Mon, May 17, 2010 at 17:12:22 +0200, Thomas Rast wrote:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > > On Mon, May 17, 2010 at 14:32, Thomas Rast <trast@student.ethz.ch=
> wrote:
> > > > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> There are cases though, where somebody calls *porcelain* commands in =
their
> scripts and there they occasionally may need this LC_ALL=3DC thing. I=
 suppose
> having a global option to turn off localization might be useful for s=
uch
> users.

Would it be that bad to define something like GIT_PLUMBING=3D1 to mean =
"I
am using this as plumbing"? It seems that this is the way things are
headed with --porcelain, even if the name is backwards.

I agree that error messages should be localised either way- if you're
trying to parse an error message, something's always gone wrong.

Does anyone know how large of a non-english-speaking community git
currently has? Would this effort include adding localised git command
names or arguments?

It may also be worth mentioning that a git "commit", for example,
doesn't have anything (other than historical reasons) to do with the
English word "commit". A git commit is a git commit, and perhaps such
conceptual terms should best be left untranslated anyway. It would
certainly make it easier to answer questions in #git if people continue=
d
to use the same terms everywhere. Just as a weak anecdotal argument,
when someone uses the term "revision" in #git, there's generally a lack
of understanding about what a "commit" is. "commit" means something ver=
y
specific in git, and I would hesitate to try to translate that into
another language as if it's just a synonym for "revision" or
"checkpoint", or "transaction", etc


--=20
-- Will
