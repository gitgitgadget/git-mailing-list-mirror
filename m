From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Re: Pull is Evil
Date: Thu, 01 May 2014 19:37:04 -0500
Message-ID: <5362e8b09aba1_429131b31038@nysa.notmuch>
References: <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
 <536173F5.7010905@xiplink.com>
 <53617877b41a9_41a872f308ef@nysa.notmuch>
 <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
 <5362266a3ca00_284da2f2eca3@nysa.notmuch>
 <7vbnvhil5x.fsf@alter.siamese.dyndns.org>
 <53629da233345_76612eb2f075@nysa.notmuch>
 <20140501194846.GA6227@odin.tremily.us>
 <20140501200703.GB6227@odin.tremily.us>
 <5362d7dc7b12_12fe14dd31095@nysa.notmuch>
 <20140502000208.GB28634@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 02:47:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg1dm-0001TH-Qi
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 02:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbaEBArp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 May 2014 20:47:45 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:57889 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbaEBAro convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2014 20:47:44 -0400
Received: by mail-ob0-f180.google.com with SMTP id va2so1740080obc.39
        for <git@vger.kernel.org>; Thu, 01 May 2014 17:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=kF35JJPp5N7fIz3PEFUwzKwg/tUE4lnPrC5Sge6aCC0=;
        b=NL4a/cMmpRAj1Yq7SkQi+Ait6pwiP/wvKEPMEUY6nAnVxi64WxkGbq3ChfAjISq+ks
         5Bs8fjayBs4VdTgpDyTdsu+vG4JKu7jky6cr0e+KFcRQN/5Kgh1sSoh22UrJq7o0hkc3
         5+EeZbBd7nehFmF4kpc2BfGmfLHt+T8hn8eNYtio1VTLupPEdwzhqZsTYCEBuQ/dAZyz
         P8G3WxxxScJuX2lhV9yGgEYhJewSpAnqUfjMm+mueAWIFHWXYEEUL7a530LyXKS9QA48
         9fRspv0ksLQ/jb/seyfRjV9i056JIRR5eynSPNN6vYy4MqJG9HS2ENaVhIvi0q/ctiDu
         wv0Q==
X-Received: by 10.182.33.99 with SMTP id q3mr12554022obi.33.1398991663744;
        Thu, 01 May 2014 17:47:43 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id 10sm62886044obq.18.2014.05.01.17.47.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 17:47:42 -0700 (PDT)
In-Reply-To: <20140502000208.GB28634@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247912>

W. Trevor King wrote:
> On Thu, May 01, 2014 at 06:25:16PM -0500, Felipe Contreras wrote:
> > W. Trevor King wrote:
> > > On Thu, May 01, 2014 at 12:48:46PM -0700, W. Trevor King wrote:
> > > > My interest in all of the proposed git-pull-training-wheel patc=
hes is
> > > > that they give users a way to set a finger-breaking configurati=
on that
> > > > makes pull a no-op (or slows it down, like 'rm -i =E2=80=A6'). =
 Then folks who
> > > > compulsively run 'git pull' (e.g. because SVN habits die slowly=
) can
> > > > set an option that gives them something to think about before g=
oing
> > > > ahead and running the pull anyway.
> > >=20
> > > Actually, what do we think about an -i/--interactive flag (with a=
n
> > > associated pull.interactive boolean config to setup global/per-re=
po
> > > defaults)?  Then after the fetch, you'd get one of the following:
> > >=20
> > >   Merge $count commits from $repository $refspec into $current_br=
anch?
> > >   Rebase $count commits from $current_branch onto $repository $re=
fpec?
> >=20
> > Not much interactivity in those options. Maybe --prompt would make =
more
> > sense.
>=20
> I think matching rm, mv, cp, etc. is good, but I'd be ok with
> --prompt.

Those are actually interactive. `git mergetool --prompt` is an exactly
of a configration where it's interactivity is constrainted to a single
input.

> > >   Fast-forward $current_branch by $count commits to $repository $=
refpec?
> >=20
> > Why would anyone say 'no' to this one?
>=20
> Because the want explicit merges when they bring in topic branches?

If that was the case the user wouls have run `git merge --no-ff`. Only
expereinced users would answer 'no'.

> > > and have a chance to bail out if you saw:
> > >=20
> > >   Merge 1003 commits from git://example.net/main.git master into =
my-feature?
> > >=20
> > > because you forgot which branch you were on.
> >=20
> > Yes, that might be nice. But we still need to change the defaults.
>=20
> So I should submit an orthogonal patch with -i/--interative/--prompt?

I'm not entirely sure what would be the ideal behavior.

=46or example, I'm thinking that by default when the a fast-forward is
possible, just do it, when it's not, ask if the user wants to do a merg=
e
or a rebase, if the user just press 'enter' a merge is attempted.

In addition a summary of the commits ahead behind would be helpful.

If the user wants to cancel the operation, he can just do CTRL+C.

--=20
=46elipe Contreras