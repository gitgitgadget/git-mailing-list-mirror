From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git-mediawiki : Encoding problems in perl
Date: Wed, 08 Jun 2011 10:07:17 -0700 (PDT)
Message-ID: <m3tyc0dzi1.fsf@localhost.localdomain>
References: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
	<20110608150106.GB7805@sigill.intra.peff.net>
	<vpqhb8049m3.fsf@bauges.imag.fr>
	<BANLkTi=DLZQM_jzove_g0wLy_zgBF6Z0Xw@mail.gmail.com>
	<vpqtyc0wc1j.fsf@bauges.imag.fr>
	<BANLkTinKV3k7uu=+QzvUjrLdRD0TUj67pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, thomas@xteddy.org,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: =?iso-8859-15?q?J=E9r=E9mie_NIKAES?= <jeremie.nikaes@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:07:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUME2-0000bT-0e
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 19:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab1FHRHU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 13:07:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36088 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab1FHRHT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 13:07:19 -0400
Received: by fxm17 with SMTP id 17so464503fxm.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=tsrMorttKGT+zY2xeuCO+oY0u1Ea1v0+E7uDl6FqILA=;
        b=BJjB8eUmbBmZqcRauuR4Z2VfLprYyouUWMGF65E+Dy3Xlz4C97CQjosbLr6wsZdyTH
         If5eoUDM9k4fxdFKX7LXWaUFRp4vfJe9e8Qg3h3e+40e19xfeScuPAbxxmNEhQF5h52f
         uFfRWCbnOz0Lhm9sn3IdeFi5kAribqJ5i3oQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=oQLXqyLSD3mQH8o4PwSU5Q+HaolhjNEguGsTygGRUCcXVWj0WuxvXp7ZQgCAvz8Ol7
         KDZcihzcdJzW5oORqTf0DrqpWNpBNk0FDLwHMVnAVlmJDShoykpohzRZ/Jh3rGzmTfYx
         TqckgSOTJzCZMqNbOsZL+vlAa2Dchya3IdOzU=
Received: by 10.223.54.219 with SMTP id r27mr2574975fag.124.1307552838356;
        Wed, 08 Jun 2011 10:07:18 -0700 (PDT)
Received: from localhost.localdomain (abvo166.neoplus.adsl.tpnet.pl [83.8.212.166])
        by mx.google.com with ESMTPS id y14sm319362fah.13.2011.06.08.10.07.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 10:07:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p58H6ZY5020010;
	Wed, 8 Jun 2011 19:06:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p58H6ExC020004;
	Wed, 8 Jun 2011 19:06:14 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTinKV3k7uu=+QzvUjrLdRD0TUj67pw@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175402>

J=E9r=E9mie NIKAES <jeremie.nikaes@gmail.com> writes:

> 2011/6/8 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:

[...]

> > My advice, at least in the short-term (already discussed offline): =
use
> > urlencode ( http://php.net/manual/en/function.urlencode.php ) on pu=
ll,
> > and don't bother with encoding on push. Non-ascii characters in
> > filenames are a nightmare ...
> >
>=20
> Yes I tried uri_escape, but that only works in the direction mediawik=
i -> git.
> A page named "Et=E9" on mediawiki comes as a Et%C3%A9.mw file on the =
repo.
> However, when I try to send that file "Et%C3%A9" with the mediawiki
> API, I get this error
>=20
> "Can't use an undefined value as a HASH reference at
> /usr/local/share/perl/5.10.1/MediaWiki/API.pm line 554."

Can you show us this line end its neighourhood?
=20
It might be bug in MediaWiki::API...

> So I tried to backslash the '%' but it does not do it...

Decode if from URI encoding to UTF-8 and mark as UTF-8 before sending
to mediawiki API.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
