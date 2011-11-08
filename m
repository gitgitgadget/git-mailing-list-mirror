From: =?utf-8?b?RnJhbsOnb2lz?= Dagorn <Francois.Dagorn@univ-rennes1.fr>
Subject: Re: git-receive-pack missing credentials ?
Date: Tue, 8 Nov 2011 08:26:36 +0000 (UTC)
Message-ID: <loom.20111108T091907-908@post.gmane.org>
References: <4EB7FA3A.8070908@univ-rennes1.fr> <CALUzUxpiOoY3Qy0oXzgioBGkZyBF_vpHV3OHm-DWfChR9pPHHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 09:30:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNh4Q-0007RY-Cv
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 09:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534Ab1KHIaJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 03:30:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:42867 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753499Ab1KHIaI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 03:30:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RNh4I-0007NS-SS
	for git@vger.kernel.org; Tue, 08 Nov 2011 09:30:07 +0100
Received: from zag.istic.univ-rennes1.fr ([148.60.10.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 09:30:06 +0100
Received: from Francois.Dagorn by zag.istic.univ-rennes1.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 09:30:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 148.60.10.22 (Mozilla/5.0 (X11; Linux i686; rv:6.0) Gecko/20100101 Firefox/6.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185077>

Tay Ray Chuan <rctay89 <at> gmail.com> writes:

>=20
> On Mon, Nov 7, 2011 at 11:33 PM, Fran=C3=A7ois Dagorn

>=20
> Can you update your git installation and try again? v1.7.3.4 sounds
> pretty old (almost a year).
>=20


On the server side I'm using the last 1.7.7.2 and 1.7.3.4 is on
the client side used for testing.=20

When apache is configured to serve without authentication, everything
is ok !

PS: I don't know where to report but there are mistakes (IMHO) in the
git-http-backend man page : the LocationMatch directive cannot be used=20
to restrict access to "receive-pack" because "receive-pack" does not
take part of the URL but only in the QUERY_STRING.


GET /test13/info/refs?service=3Dgit-receive-pack
                    ****

Cheers.

=46ran=C3=A7ois
