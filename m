From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Merging limitations after directory renames -- interesting test repo
Date: Sat, 19 Feb 2011 10:31:37 -0500
Message-ID: <AANLkTi=WCqUE-wAnhuG8Osrm3UcA5OXXRScqL-0COrVj@mail.gmail.com>
References: <AANLkTimsQmOLDENX27YqpicBeFFZrfgEAsLvFiJqoV7w@mail.gmail.com>
 <20110218222151.GB4258@sigill.intra.peff.net> <AANLkTimKp+Z==QXJg2Bagot+Df4REeANuxwVi7bpPCXr@mail.gmail.com>
 <20110219101936.GB20577@sigill.intra.peff.net> <AANLkTimiZo8yiwnqzbOTg1FmM4rZn7ypSdZ3-zukLees@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 19 16:32:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqomy-00086X-8A
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 16:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629Ab1BSPb7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 10:31:59 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:33099 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755616Ab1BSPb7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Feb 2011 10:31:59 -0500
Received: by yib18 with SMTP id 18so2016033yib.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 07:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=wy2VypdUcqgxm45HR3UB/TwLK0Y8cbbWBrXWLBvrOBw=;
        b=TlRe5qKjZKBWuqxbw5qy4cqueAqF4zMFUzDIRqjz0QzcM8LhWCGeQHPvfNqW6RqfvS
         zrLeAJBMqkudIx0A3TQP5OAOxJ+PSCwceAdp8VGURmD1b3XjokCLIHOwFM9yoLhGyVIF
         g49bIUJ58V8JD/YF2zFU4Y6ZsBnDKBK5Y1xnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hJbpp2Cf72RwgGrjZOaNzUYAfOMYw7DpbIm4Rzt/XlqN4Fb0WV+rAfOZjQwNiREpyM
         VWVZHiKzmOjDTFJB3UwTsKomgmUK1zeLQEDz7VwZMwygNKHDBp1NgMivxi9aAtraBEYh
         LMt0+DTiwxc1eNJYPind8JPuxEgjwTKflzWXs=
Received: by 10.90.75.18 with SMTP id x18mr2770879aga.5.1298129517106; Sat, 19
 Feb 2011 07:31:57 -0800 (PST)
Received: by 10.90.53.7 with HTTP; Sat, 19 Feb 2011 07:31:37 -0800 (PST)
In-Reply-To: <AANLkTimiZo8yiwnqzbOTg1FmM4rZn7ypSdZ3-zukLees@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167291>

On Sat, Feb 19, 2011 at 10:22 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> =A0git merge-helper --prefer-path foo/preferred/README

The concrete example in this repo could be

 gitk pg master --  trunk/etherpad/src/templates/store/eepnet_eval_sign=
up.ejs \
    etherpad/src/themes/default/templates/store/eepnet_eval_signup.ejs =
\
   etherpad/src/templates/store/eepnet_eval_signup.ejs

The ideal thing would be to have a helper that knows what to do if I sa=
y

  git merge-helper --prefer
etherpad/src/themes/default/templates/store/eepnet_eval_signup.ejs

cheers,


m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
