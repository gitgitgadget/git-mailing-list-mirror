From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH v2] bisect reset: Allow resetting to any commit, not just
 a branch
Date: Tue, 13 Oct 2009 16:09:31 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0910131605170.5105@dr-wily.mit.edu>
References: <alpine.DEB.1.10.0910121237540.2223@dr-wily.mit.edu> <7vaazw6uyi.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0910131116300.5105@dr-wily.mit.edu> <200910132206.18460.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 22:26:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxnwT-0006OW-4f
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 22:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934261AbZJMUKO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Oct 2009 16:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933956AbZJMUKO
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 16:10:14 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:46547 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933939AbZJMUKN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 16:10:13 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n9DK9SZU002062;
	Tue, 13 Oct 2009 16:09:28 -0400 (EDT)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n9DK9VMs000809;
	Tue, 13 Oct 2009 16:09:31 -0400 (EDT)
In-Reply-To: <200910132206.18460.chriscool@tuxfamily.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130201>

On Tue, 13 Oct 2009, Christian Couder wrote:
> +       1) git rev-parse --quiet --verify "$1^{commit}" > /dev/null |=
|
> +               die "'$1' does not seem to point to a valid commit"
>=20
> It would give a better error message when "git rev-parse" fails inste=
ad of:
>=20
> fatal: Needed a single revision
>=20
> and it would not print the SHA1 from "$1^{commit}" when "git rev-pars=
e"=20
> succeeds.

Oh, oops, I somehow lost the > /dev/null in my version.

But as for the =E2=80=98git rev-parse=E2=80=99 error being confusing, w=
hy don=E2=80=99t we fix=20
=E2=80=98git rev-parse=E2=80=99 instead?

Anders
