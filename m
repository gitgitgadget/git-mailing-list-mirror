From: Lukas Fleischer <git@cryptocrack.de>
Subject: Re: [PATCH] Fix grammar in the 1.8.3 release notes.
Date: Wed, 1 May 2013 10:24:34 +0200
Message-ID: <20130501082434.GA19771@blizzard>
References: <7vvc78u8jl.fsf@alter.siamese.dyndns.org>
 <1367262904-9885-1-git-send-email-marcnarc@xiplink.com>
 <7vli81ghsf.fsf@alter.siamese.dyndns.org>
 <517FD505.9000706@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed May 01 10:24:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXSLI-0007PI-RK
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 10:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312Ab3EAIYn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 May 2013 04:24:43 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:21826 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab3EAIYl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 04:24:41 -0400
Received: from localhost (p5B2C65AA.dip0.t-ipconnect.de [91.44.101.170])
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id db4230c8
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128);
	Wed, 1 May 2013 10:24:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <517FD505.9000706@xiplink.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223073>

On Tue, Apr 30, 2013 at 10:28:21AM -0400, Marc Branchaud wrote:
> On 13-04-29 05:15 PM, Junio C Hamano wrote:
> > Marc Branchaud <marcnarc@xiplink.com> writes:
> >=20
> >> This started out as an attempt to make the backward compatibility =
notes
> >> more parsable, but then I just kept going...
> >=20
> > Thanks.
> >=20
> >>   * "git bundle" did not like a bundle created using a commit with=
out
> >> -   any message as its one of the prerequistes.
> >> +   any message, as it is one of the prerequistes.
> >=20
> > This is actually saying a different thing. =20
> >=20
> > When you create a bundle, you can say "you can only unbundle this i=
n
> > a repository that has commit X", with "git bundle create $name ^X Y
> > Z".  Such a commit X is called the bundle's prerequisite.  You can
> > have more than one prerequisite, e.g. "... ^X ^W Y Z".
> >=20
> > But if you create a bundle by using a commit that does not have any
> > message as X (i.e. the bundle's prerequisite), the "git bundle" did
> > not like to read the resulting bundle output.
> >=20
> > So <a commit <without any message> as its (bundle's) one of the
> > prerequisites> is what the original wanted to say.  The rewrite
> > makes it read like "For a commit, having a message is a requirement
> > to be used in a bundle", at least to me.
>=20
> Thanks, I did get that wrong.
>=20
> CC'ing Lukas, who wrote the relevant commit (5446e33f35).
>=20
> How about:
>=20
> * "git bundle" can create a bundle that has a commit without a messag=
e as
>   a prerequisite, but it could not work with such a bundle.

Looks fine to me.

Junio's version with the last part changed to "as one of its
prerequisites" sounds also good to me (in both cases, however, note the
missing "i" in "prerequisites").

A third suggestion:

    "git bundle" erroneously=A0bailed out when parsing a valid bundle
    containing a prerequisite commit without a commit message.

>=20
> 		M.
