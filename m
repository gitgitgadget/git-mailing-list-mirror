From: Mike Hommey <mh@glandium.org>
Subject: Re: git-send-email getting filtered as spam by vger.kernel.org
Date: Thu, 21 Feb 2008 22:34:23 +0100
Organization: glandium.org
Message-ID: <20080221213423.GA31786@glandium.org>
References: <200802210429.58353.lenb@kernel.org> <200802210721.29188.lenb@kernel.org> <20080221205104.GA14247@informatik.uni-freiburg.de> <7vejb6t3kk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, Len Brown <lenb@kernel.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 22:33:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSJ2U-0004xY-IC
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 22:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473AbYBUVce convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2008 16:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754813AbYBUVce
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 16:32:34 -0500
Received: from vuizook.err.no ([85.19.215.103]:43293 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752214AbYBUVcd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 16:32:33 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JSJ1b-0000Kg-NK; Thu, 21 Feb 2008 22:32:22 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JSJ3f-00006v-68; Thu, 21 Feb 2008 22:34:23 +0100
Content-Disposition: inline
In-Reply-To: <7vejb6t3kk.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74662>

On Thu, Feb 21, 2008 at 01:14:19PM -0800, Junio C Hamano wrote:
> Uwe Kleine-K=F6nig  <ukleinek@informatik.uni-freiburg.de> writes:
>=20
> > Len Brown wrote:
> >> It looks like the same patches formatted and set with git 1.5.4.2
> >> made it through to the list.
> > I suspect 1ca3d6ed01774eab37e96d9c88b840ea618f97af.
>=20
> When you talk about commits, please also add the summary line,
> like this [*1*]:
>=20
>     1ca3d6e (send-email: squelch warning due to comparing undefined $=
_ to "")
>=20
> Len said he has the issue with v1.5.4.2-184-gb23b27e but not
> with v1.5.4.2.
>=20
>     $ git lg v1.5.4.2..b23b27e -- git-send-email.perl
>     1ca3d6e... send-email: squelch warning due to comparing undefined=
 $_ to ""
>     6564828... git-send-email: Generalize auto-cc recipient mechanism=
=2E
>     8a7c56e... git-send-email: Better handling of EOF
>     8742997... git-send-email: SIG{TERM,INT} handlers
>     2363d74... git-send-email: ssh/login style password requests
>=20
> and I think you are right.  I see In-reply-to: <> in the reject
> message.
>=20
> Perhaps we should fix it up like this...
(...)

And perhaps add a test, because it's not the first time the issue is
discussed http://kerneltrap.org/mailarchive/git/2007/12/11/488243 ;)

Mike
