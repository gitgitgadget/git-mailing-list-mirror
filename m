From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git-mediawiki : Encoding problems in perl
Date: Wed, 08 Jun 2011 20:20:16 +0200
Message-ID: <vpqboy8i3rz.fsf@bauges.imag.fr>
References: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
	<20110608150106.GB7805@sigill.intra.peff.net>
	<vpqhb8049m3.fsf@bauges.imag.fr>
	<BANLkTi=DLZQM_jzove_g0wLy_zgBF6Z0Xw@mail.gmail.com>
	<vpqtyc0wc1j.fsf@bauges.imag.fr>
	<BANLkTinKV3k7uu=+QzvUjrLdRD0TUj67pw@mail.gmail.com>
	<vpqsjrkqmdj.fsf@bauges.imag.fr>
	<BANLkTinE9+1cVk09KCP-iW=+GFbRdDAZFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, thomas@xteddy.org, git@vger.kernel.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= NIKAES <jeremie.nikaes@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:20:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNMo-0002L3-KS
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538Ab1FHSU3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 14:20:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42758 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036Ab1FHSU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:20:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p58IKEGm013229
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 8 Jun 2011 20:20:14 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QUNMW-0006AX-C4; Wed, 08 Jun 2011 20:20:16 +0200
In-Reply-To: <BANLkTinE9+1cVk09KCP-iW=+GFbRdDAZFg@mail.gmail.com>
 (=?iso-8859-1?Q?=22J=E9r=E9mie?=
	NIKAES"'s message of "Wed, 8 Jun 2011 20:03:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 08 Jun 2011 20:20:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p58IKEGm013229
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1308162017.71927@IGgMCDyPZ73FDXgwxoYgxg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175417>

J=E9r=E9mie NIKAES <jeremie.nikaes@gmail.com> writes:

> Yep this works if you manually set your $title variable earlier in th=
e
> code.

Or if you uri_escape the file on pull.

> However, I still have the problem which I think is on the git side
>
> - I pull the "Et=E9.mw" file from mediawiki
> - I edit it
> - When I commit it I get this message from git :
> [master sha1] commit message
> 1 files changed [...]
> create mode 100644 "Bl\303\251.mw"

I guess you mean "Et\303\251.mw" ?

> As a result, when I parse commit information, the title of the file i=
s
> indeed Bl\303\251...

The -z option of many Git commands is your friend.

Especially the one of "git diff --raw".

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
