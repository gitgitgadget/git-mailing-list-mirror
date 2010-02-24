From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git as an sfc member project
Date: Wed, 24 Feb 2010 08:07:13 -0800 (PST)
Message-ID: <m3k4u2mxdr.fsf@localhost.localdomain>
References: <20100224154452.GA25872@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 17:07:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkJlt-0004rE-1x
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 17:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757214Ab0BXQH2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 11:07:28 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:39902 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756294Ab0BXQH1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 11:07:27 -0500
Received: by fxm19 with SMTP id 19so5226558fxm.21
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 08:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=ll93fylLtdVvI96gYdOxAecrcYINCzeNsGdINw4AlvI=;
        b=e02gCYMhZcTBf69bNN38l9v8K68HO8P9upxUMeH6Bg1YQMXpF/TsJlCcf/a4kS0OUY
         4DMW6ENwRBWPrqwhN5P+sACW1osexibl4ZBbE+XRkgLZeQ34EOhORwQyIuL/ctgXXj9m
         g8V056jKZc4UtxBaA5QFL6OxMVToDlAwoM0z0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=pObbtMVqNvXHFxfeONF/Fm6wsU357Tuexjw1oITgN6lDFSTOO35UkVGmvuklTvCQgL
         7lai7aicM5mjTZh/FLja9UJHpucSX+7o05JQS4gcf1M7K1wPqn+mMRyT94xr4jcDG14q
         w6Ew0goyDHJR+NrF/lckkThsNEEGqRAyaupCs=
Received: by 10.223.5.17 with SMTP id 17mr41776fat.0.1267027645123;
        Wed, 24 Feb 2010 08:07:25 -0800 (PST)
Received: from localhost.localdomain (abwi180.neoplus.adsl.tpnet.pl [83.8.232.180])
        by mx.google.com with ESMTPS id 14sm3521944fxm.9.2010.02.24.08.07.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 08:07:13 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o1OG6gvs020486;
	Wed, 24 Feb 2010 17:06:48 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o1OG6PIt020475;
	Wed, 24 Feb 2010 17:06:25 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100224154452.GA25872@coredump.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140950>

Jeff King <peff@peff.net> writes:

> >    * Names, email addresses, and affiliations of key developers, pa=
st and
> >      present.
>=20
> Junio C Hamano <gitster@pobox.com>
> Shawn O. Pearce <spearce@spearce.org>
> Linus Torvalds <torvalds@linux-foundation.org>
> Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Eric Wong <normalperson@yhbt.net>
> Jeff King <peff@peff.net>
> Jakub Narebski <jnareb@gmail.com>
> Nicolas Pitre <nico@fluxnic.net>
> Paul Mackerras <paulus@samba.org>
> Christian Couder <chriscool@tuxfamily.org>
>=20
> [This is basically "shortlog -ns | head". I am happy to make it short=
er
> or longer if people think it should be. Affiliations?]

I wouldn't say I am "key developer"...

In the "A note from maintainer", which is send periodically to git
mailing list, and which is also available as MaintNotes file in 'todo'
branch in git repository, you have the following description of
developers at the end of this file:

-- >8 -- [git.git$ git show todo:MaintNotes] -- >8 --

I [=3D=3D Junio C Hamano, Git maintainer] would like to thank everybody
who helped to raise git into the current shape.  Especially I would
like to thank the git list regulars whose help I have relied on and
expect to continue relying on heavily:

 - Linus on general design issues.

 - Linus, Shawn Pearce, Johannes Schindelin, Nicolas Pitre, Ren=C3=A9
   Scharfe, Jeff King and Johannes Sixt on general implementation
   issues.

 - Shawn and Nicolas Pitre on pack issues.

 - Martin Langhoff and Frank Lichtenheld on cvsserver and cvsimport.

 - Paul Mackerras on gitk.

 - Eric Wong on git-svn.

 - Simon Hausmann on git-p4.

 - Jakub Narebski, Petr Baudis, Luben Tuikov, Giuseppe Bilotta on
   gitweb.

 - J. Bruce Fields on documentation (and countless others for
   proofreading and fixing).

 - Alexandre Julliard on Emacs integration.

 - Charles Bailey for taking good care of git-mergetool (and Theodore
   Ts'o for creating it in the first place).

 - David Aguilar for git-difftool.

 - Johannes Schindelin, Johannes Sixt and others for their effort to
   move things forward on the Windows front.

 - People on non-Linux platforms for keeping their eyes on
   portability; especially, Randal Schwartz, Theodore Ts'o, Jason
   Riedy, Thomas Glanzmann, Brandon Casey, Jeff King, Alex Riesen and
   countless others.

-- >8 -- [end] -- >8 --
--=20
Jakub Narebski
Poland
ShadeHawk on #git
