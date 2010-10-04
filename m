From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH v4 3/3] git-remote-ext
Date: Mon, 4 Oct 2010 21:11:33 +0300
Message-ID: <20101004181133.GA14661@LK-Perkele-V2.elisa-laajakaista.fi>
References: <1286190258-12724-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1286190258-12724-4-git-send-email-ilari.liusvaara@elisanet.fi>
 <AANLkTikenkhm0RJR0ovVyY9WLHtwWo+qQsyAhFDk=BO2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 20:06:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2pQF-0005rc-76
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 20:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756398Ab0JDSFx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 14:05:53 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:38101 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022Ab0JDSFw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 14:05:52 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 5A851EC032;
	Mon,  4 Oct 2010 21:05:51 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A0662A5382C; Mon, 04 Oct 2010 21:05:51 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 48522158A65;
	Mon,  4 Oct 2010 21:05:49 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <AANLkTikenkhm0RJR0ovVyY9WLHtwWo+qQsyAhFDk=BO2@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158077>

On Mon, Oct 04, 2010 at 06:56:24PM +0200, Sverre Rabbelier wrote:
>=20
> > +"ext::git-server-alias foo %G/repo %Vfoo"::
> > + =C2=A0 =C2=A0 =C2=A0 Represents a repository with path /repo acce=
ssed using the
> > + =C2=A0 =C2=A0 =C2=A0 helper program "git-server-alias foo". =C2=A0=
The hostname for the
> > + =C2=A0 =C2=A0 =C2=A0 remote server passed in the protocol stream =
will be "foo"
> > + =C2=A0 =C2=A0 =C2=A0 (this allows multiple virtual git servers to=
 share a
> > + =C2=A0 =C2=A0 =C2=A0 link-level address).
>=20
> Can you explain better what the 'git-server-alias' helper is supposed=
 to do?

Connect its stdin and stdout to git://-type server somewhere. It might
be that the actual address of server is variable depending on network
conditions, the connection is tunneled somehow, etc..

-Ilari
