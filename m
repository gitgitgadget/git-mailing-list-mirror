From: Robert Schiele <rschiele@gmail.com>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 3 Aug 2007 01:27:54 +0200
Message-ID: <20070802232754.GV29424@schiele.dyndns.org>
References: <86bqdqkygp.fsf@lola.quinscape.zz> <7vlkctvfk9.fsf@assigned-by-dhcp.cox.net> <85odhpzmbo.fsf@lola.goethe.zz> <7vsl71tyyq.fsf@assigned-by-dhcp.cox.net> <86bqdqkygp.fsf@lola.quinscape.zz> <7vlkctvfk9.fsf@assigned-by-dhcp.cox.net> <85odhpzmbo.fsf@lola.goethe.zz> <20070802214103.GT29424@schiele.dyndns.org> <85vebxy47e.fsf@lola.goethe.zz>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pnDjx0H/VpusRTEI"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 01:28:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGk5R-0007Xx-7m
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 01:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761919AbXHBX2B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 19:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757322AbXHBX2B
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 19:28:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:46280 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761919AbXHBX16 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 19:27:58 -0400
Received: by nf-out-0910.google.com with SMTP id g13so174908nfb
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 16:27:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=tECFsYk+/1zKHKZODoTjez+P5X1bUhxDwh+iXTpoTg6ie51KiNBG43SHgdHiAcBejqgYxscUXy3ecAcK15nGH+4Jno/gAVB9e+dqt34QMU6kASznRVs51GLSwD3j03DyJ1Y6ZlvS18WlpQxfu1n93FPilEBldoPHO33gn8lm/tk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=R5uArzN+TCGWkw2dd7m0f6PgUNc65gHoIQ0Wo+y1ZV+kbHYu+Mi4O/eZtdIrbNmEB6yVeoARwG/ePF4M3rbXAlajYMAsd6EB18CM0wNzMTAer1DYa0C4vbr9gz7d9N6g2uhLSK2JJrBMnkJW1z3L2mTf+kmxhXZEGxI60ACWAPI=
Received: by 10.86.68.16 with SMTP id q16mr1771318fga.1186097276946;
        Thu, 02 Aug 2007 16:27:56 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.91.135])
        by mx.google.com with ESMTPS id j2sm7796328mue.2007.08.02.16.27.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2007 16:27:56 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 0A78AC112CF; Fri,  3 Aug 2007 01:27:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <85vebxy47e.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54642>


--pnDjx0H/VpusRTEI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 03, 2007 at 12:14:13AM +0200, David Kastrup wrote:
> A non-working rebase would seem rather tough.

It depends on how you work.  I for example always just push any change to a
linux machine where I do the actual integration work.  Thus I don't need mu=
ch
commands on the Solaris machine.

> The "issues" are with Solaris, apparently.  There is always a price
> for portability.  If Solaris users can fix their problems with a
> global search and replace of the first line in *.sh, the question is
> whether it is worth the hassle of having unreadable but "portable"
> code.  After all, it has to be read also by humans.

Ok, but then we needed an infrastructure to replace the shell with a
configuration parameter.

> You are missing the line
> $ echo $0
> which is probably the most interesting one...  we don't need to be
> compatible with everything having a "$ " prompt, just with everything
> called "/bin/sh".

Your way of telling people that you are considering everybody besides you to
be a moron is somehow insulting.  You might wish to change that.

Sure I tested in on /bin/sh!

> See the rationale in my recently posted patch for implementing
> EDITOR/VISUAL support.  One needs to shell-quote stuff properly, and
> the shell is better at shell-quote magic than C is.

Ok, will look up that later.

> If you prepare a patch replacing all existing ${parameter#word} uses
> and get it accepted, I will not push for inclusion of my cleanup.
>=20
> But you _really_ should go for it _now_.

I have it ready now.  Just waiting for the answer of Junio to my last mail.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--pnDjx0H/VpusRTEI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGsmh6xcDFxyGNGNcRAoJ3AJ9HomW/f88rtQwPv+EEIKrRaopGdwCeOVBP
Uf7Ox4f8EyqcZHo4mOyhEfU=
=/UKB
-----END PGP SIGNATURE-----

--pnDjx0H/VpusRTEI--
