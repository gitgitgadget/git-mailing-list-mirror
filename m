From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: Git bugtraq for all users who clone my repos?
Date: Tue, 1 Mar 2011 13:55:40 +0100
Message-ID: <20110301125540.GI3577@madism.org>
References: <4D6B8F7E.4070804@fischer.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Markus Fischer <markus@fischer.name>
X-From: git-owner@vger.kernel.org Tue Mar 01 14:05:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuPGh-0005Qw-T5
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 14:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab1CANF1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 08:05:27 -0500
Received: from pan.madism.org ([88.191.52.104]:37294 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752889Ab1CANF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 08:05:27 -0500
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Mar 2011 08:05:26 EST
Received: from madism.org (unknown [94.228.180.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 9CFBF51A65;
	Tue,  1 Mar 2011 13:55:41 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id B04A41908; Tue,  1 Mar 2011 13:55:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D6B8F7E.4070804@fischer.name>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168218>

On Mon, Feb 28, 2011 at 01:05:18PM +0100, Markus Fischer wrote:
> Hi,
>=20
> I'm used to svn to use svn:propset to set bugtraq URLs,
> pus^H^H^Hcommit them to the server and all users who
> clo^H^H^Hcheckout from it have the settings.
>=20
> In git I can store them in my local or repository specific
> configuration, but other users who clone from it don't benefit from
> it: they simply don't get my/the bugtraq configuration.
>=20
> Do I need to educate every developer to configure their checkouts
> (also unsatisfying for myself when I move somewhere else have to do
> clone my repository again) or it possible to feed it when the
> repository is being cloned?

This is horrible practice, but the top level makefile / configure of
some of my projects force the git configuration of the repository to
some sane values that are required for it to work properly.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
