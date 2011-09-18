From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] Configurable hyperlinking in gitk
Date: Sun, 18 Sep 2011 11:50:30 -0700 (PDT)
Message-ID: <m3hb49sn26.fsf@localhost.localdomain>
References: <20110917022903.GA2445@unpythonic.net>
	<4E7467B7.1090201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff Epler <jepler@unpythonic.net>, git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 20:50:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5MRu-0004MS-9J
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 20:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171Ab1IRSug convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Sep 2011 14:50:36 -0400
Received: from mail-wy0-f170.google.com ([74.125.82.170]:41755 "EHLO
	mail-wy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932136Ab1IRSuc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2011 14:50:32 -0400
Received: by wyg8 with SMTP id 8so8209005wyg.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 11:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=7jubzSzOAoQQLe4de3zghlKpHZtfhGMOLDl7UsaYRJY=;
        b=IpNKKzpTiDU+yZFoSLgkJ/5pI+32sSfUcrOhVeCfB60fV9vp+0WODUZT+hycbaRX91
         Mx4Tff0eKsq/Cu1W6nzhkg2AvLBmwIRj73GPYBgC90IAY2q9Fk8r6xlvA9sP0LyMEf0O
         zzJCz7z9rhHilsLOrIQqTzQSf1i/9Tm4KrCf8=
Received: by 10.227.206.136 with SMTP id fu8mr1811215wbb.109.1316371831242;
        Sun, 18 Sep 2011 11:50:31 -0700 (PDT)
Received: from localhost.localdomain (abvm199.neoplus.adsl.tpnet.pl. [83.8.210.199])
        by mx.google.com with ESMTPS id fa7sm22420948wbb.26.2011.09.18.11.50.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 11:50:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8IInu2A030209;
	Sun, 18 Sep 2011 20:50:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8IInbZp030205;
	Sun, 18 Sep 2011 20:49:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4E7467B7.1090201@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181621>

Chris Packham <judge.packham@gmail.com> writes:
> On 17/09/11 14:29, Jeff Epler wrote:

> > Some time ago I hardcoded this into gitk for $DAY_JOB and find it v=
ery
> > useful.  I made it configurable in the hopes that it might be adopt=
ed
> > upstream. (unfortunately, the configurable version is radically
> > different from the original hard-coded version, so I can't say this
> > has had much testing yet)
>=20
> This is definitely something folks at my $dayjob would be interested =
in.
> We've already done some customisation of gitweb to do something simil=
ar.
> I'm not actually sure what the changes where or how configurable they
> are. I'll see if I can dig them out on Monday someone else might want=
 to
> polish them into something suitable (I might do it myself if I get so=
me
> tuits).

That would be nice.  So called "committags" support was long planned
for gitweb, and even some preliminary work exists...
=20
> > There are probably better names for the configuration options, too.
>=20
> It'd be nice if the config variables weren't gitk specific. .re and .=
sub
> could be applied to gitweb and maybe other git viewers outside of
> gig.git might decide to use them. My bikeshedding suggestion would be=
 to
> just drop the gitk prefix and have linkify.re and linkify.sub.

Perhaps more descriptive name, i.e.

  linkify.<name>.regexp
  linkify.<name>.subst

would be better?

I guess that regexp is an extended regular expression, isn't it?

--=20
Jakub Nar=EAbski
