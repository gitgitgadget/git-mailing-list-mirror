From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Sun, 25 Jul 2010 00:36:49 +0200
Message-ID: <201007250036.55811.jnareb@gmail.com>
References: <4C472B48.8050101@gmail.com> <m31vavn8la.fsf@localhost.localdomain> <4C488C9D.60606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"=?iso-8859-1?q?=C6var_Arnfj=F6r=F0?= Bjarmason" <avarab@gmail.com>
To: Bryan Larsen <bryan.larsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 00:37:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcnLJ-00012a-0q
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 00:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354Ab0GXWg4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 18:36:56 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51739 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab0GXWgz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 18:36:55 -0400
Received: by fxm14 with SMTP id 14so5598730fxm.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 15:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=3kCa2zHwRmY2Kjl3nvlO5SLBXDW73AqclwxVoyu2mBg=;
        b=KrF/TyV0RaPkvgQEDOe2M6Ripgcr9+UFc6aYYAd+EZCUWxqJqL9jcVP1kUGVeICaJq
         C7by7A8U116QlwJLaIIvcA3AJUQ6T+IQxSetj9cL1I/UwEiFJ35oLsN1i3YEQuFrsIPJ
         Z2HGJ3mAJ8rNKYyKT00OY4gZ1aXFEo7/KLtUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kTP9DTttzEVipb8njuJVqf57aRpRdjbHnYpWoj1CXDSHqtk/VdJn00LzVW/clLDZYQ
         IwhH151qtehOVBiSuuLu+ZrYTX1JBv1igISglj9WcNNJkF27U4hSX8Uc1G5mlUxeSztc
         jcQxD6pA6YjB4KwzUpmCEP0MJLWeIEcU0A4K8=
Received: by 10.223.122.210 with SMTP id m18mr4701614far.89.1280011014401;
        Sat, 24 Jul 2010 15:36:54 -0700 (PDT)
Received: from [192.168.1.13] (abwj172.neoplus.adsl.tpnet.pl [83.8.233.172])
        by mx.google.com with ESMTPS id r10sm680480faq.29.2010.07.24.15.36.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 15:36:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4C488C9D.60606@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151681>

Dnia czwartek 22. lipca 2010 20:23, Bryan Larsen napisa=B3:
> >
> > Using git-subtree has its warts too: I don't think for example that=
 there is
> > a way to get a log _automatically excluding_ history subtree-merged
> > subprojects.  Or is it there?
> >
>=20
> It works exactly right for me when I used git-subtree in "squashed"=20
> mode.  Changes which were done in tree show up separately in the log,=
=20
> changes which were pulled in via git-subtree pull show up as a single=
=20
> summary entry in the log.
>=20
> This discussion has been about how to improve git submodules, which i=
s=20
> sorely needed.   However, it's quite clear that git submodules will=20
> never work as well as git subtrees in certain quite common situations=
=2E=20
>   If fixed, git submodules will be more appropriate in other situatio=
ns.=20
>    However, I'm not asking to remove git submodules or prevent anybod=
y=20
> from fixing them, I'm just asking that git subtree be merged.
>=20
> Does anybody actually oppose the merger of git-subtree, which has (at=
=20
> least) hundreds of users despite its out-of-tree status?

I am very much *for* merging git-subtree into git core.  It is not that
much different from e.g. "git submodule" or "git remote" porcelain
commands.

--=20
Jakub Narebski
Poland
