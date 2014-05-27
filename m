From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH] config: respect =?utf-8?b?J34n?= and =?utf-8?b?J351c2VyJw==?= in mailmap.file
Date: Tue, 27 May 2014 23:28:56 +0000 (UTC)
Message-ID: <loom.20140528T012425-812@post.gmane.org>
References: <1401180358-27281-1-git-send-email-oystwa@gmail.com> <20140527160939.GA29693@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 01:29:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpQo0-0001b1-Ct
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 01:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbaE0X3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2014 19:29:13 -0400
Received: from plane.gmane.org ([80.91.229.3]:59953 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916AbaE0X3M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 19:29:12 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WpQns-0001Qi-N9
	for git@vger.kernel.org; Wed, 28 May 2014 01:29:08 +0200
Received: from 80.156.189.109.customer.cdi.no ([109.189.156.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 May 2014 01:29:08 +0200
Received: from oystwa by 80.156.189.109.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 May 2014 01:29:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.189.156.80 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:29.0) Gecko/20100101 Firefox/29.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250249>

Jeff King <peff <at> peff.net> writes:

>=20
> Makes sense. Curious if there was a reason we did not use it in the
> first place, I looked at the history. The reason is that mailmap.file
> was added in d551a48 (2009-02-08) and git_config_pathname came months
> later in 395de25 (2009-11-17). Retro-fitting it now should not cause =
a
> problem for any sane paths. So:
>=20
> Reviewed-by: Jeff King <peff <at> peff.net>
>=20
> -Peff
>
=20
Thanks for the review.=20

I saw it was added back in 2009 but didn't give it much thought other
than "Oh, that bug has been there for a long time!" :) (Not that this i=
s
a serious bug as such, more than a slight inconsistency in how the path
is handled compared to other config values expected to be paths)

=C3=98sse
