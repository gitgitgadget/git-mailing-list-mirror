From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git bundle unbundle and "check-outable" refs
Date: Thu, 29 Sep 2011 10:20:43 -0700 (PDT)
Message-ID: <m3ty7vnu4g.fsf@localhost.localdomain>
References: <dec8c877-bd6e-4120-b045-87179d54abe2@i30g2000yqd.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Todd A. Jacobs" <nospam+listmail@codegnome.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 19:20:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9KI0-0007W2-Oq
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 19:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757303Ab1I2RUr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 13:20:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35262 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959Ab1I2RUq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 13:20:46 -0400
Received: by fxe4 with SMTP id 4so1966651fxe.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 10:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=CGovS94tnhR7yBdo51xYvuqNKCJ81FDIhxgg3eZ1gC8=;
        b=qdyPsDnIkck4gi98vE7dzqNrK7VNEoadOjxJx17GGz/UgsCBCv0/7rdgo3OKmsqbzd
         ELY/26ceih6LqNEBJ2Jv6ibyRzYGhTeBHoKlQJ0k33nBnMPgZszWIF/CmE574u6XHk0+
         VYNVaqSWiwUjiTG2Nit15VSxFRRCF2DVV5jVI=
Received: by 10.223.48.69 with SMTP id q5mr16714586faf.80.1317316845367;
        Thu, 29 Sep 2011 10:20:45 -0700 (PDT)
Received: from localhost.localdomain (abvt90.neoplus.adsl.tpnet.pl. [83.8.217.90])
        by mx.google.com with ESMTPS id u6sm2914465faf.3.2011.09.29.10.20.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Sep 2011 10:20:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8THKBDR022980;
	Thu, 29 Sep 2011 19:20:27 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8THK0Od022970;
	Thu, 29 Sep 2011 19:20:00 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <dec8c877-bd6e-4120-b045-87179d54abe2@i30g2000yqd.googlegroups.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182415>

"Todd A. Jacobs" <nospam+listmail@codegnome.org> writes:

> Never having needed git bundle before, I've recently been using it as
> a sneakernet. In particular, I'm using bundles to work around
> limitations of filesystem semantics on vfat and hpfs+ drives when
> shared between Linux and OS X systems. The systems are air-gapped, so
> sneakernet is essential.
>=20
> At any rate, the issue I'm dealing with is that "git bundle unbundle"
> is sort of non-intuitive to deal with. [...]

I guess the fault is with "git bundle" documentation.

The "Example" section of git-bundle(1) manpage shows that you can use
path to bundle in place of URL to repository in "git clone".  Actually
you can use path to bundle anywhere where URL or nickname of
repository is/can be used, i.e.:

  git remote add <name> <bundle>
  git fetch <bundle> [<refspec>...]
  git pull <bundle>  [<refspec>...]

  git ls-remote <bundle>

HTH
--=20
Jakub Nar=EAbski
