From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Commited to wrong branch
Date: Tue, 15 Sep 2009 15:06:40 +0200
Message-ID: <20090915130640.GC31846@atjola.homenet>
References: <26ae428a0909150331q391ed39ak622902d175b46d84@mail.gmail.com>
 <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
 <26ae428a0909150405v3087016fxee5ac98057868677@mail.gmail.com>
 <46a038f90909150416h60ea7d74xd2337fe50f603dcb@mail.gmail.com>
 <26ae428a0909150510n56b1d4eg6565a6cca8c9b46c@mail.gmail.com>
 <46a038f90909150546i508d3781id1dcd8e6c64942cf@mail.gmail.com>
 <26ae428a0909150558i508e5878q8a1ee7cb7311fc57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 15 15:06:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnXkA-0003xe-SL
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 15:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576AbZIONGl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 09:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbZIONGl
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 09:06:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:42202 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753473AbZIONGl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 09:06:41 -0400
Received: (qmail invoked by alias); 15 Sep 2009 13:06:43 -0000
Received: from i59F56716.versanet.de (EHLO atjola.homenet) [89.245.103.22]
  by mail.gmx.net (mp048) with SMTP; 15 Sep 2009 15:06:43 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19B6fcJ3qZB4Tk3dLazVg0S8P3Vm+sBcMPhXseLId
	TlpQLxBTokaDTA
Content-Disposition: inline
In-Reply-To: <26ae428a0909150558i508e5878q8a1ee7cb7311fc57@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128540>

[Please stop top-posting...]

On 2009.09.15 13:58:32 +0100, Howard Miller wrote:
> Got as far as applying the temporary patch and I now get a load of...
>=20
> Reversed (or previously applied) patch detected!  Assume -R? [n]
> Apply anyway? [n]
> Skipping patch.
> 1 out of 1 hunk ignored -- saving rejects to file
> theme/onepointnine/local.css.rej
> The next patch would create the file theme/onepointnine/local.css,

Just don't use patch(1), there's no sane reason to do that, you're
sacrificing all of what git can offer there.

cherry-pick or format-patch + am -3 are simply much better. (Or
"checkout -m" or stash + stash apply, if you're dealing with uncommitte=
d
changes).

Bj=F6rn
