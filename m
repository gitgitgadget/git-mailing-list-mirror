From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: Re: [PATCH] Add a commit.signoff configuration variable to always
 use --signoff.
Date: Sat, 27 Dec 2008 19:08:19 +0100
Message-ID: <20081227190819.7257932a@neuron>
References: <1230296219-16408-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Adeodato =?UTF-8?B?U2ltw7M=?=" <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Sat Dec 27 19:10:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGdcQ-0005yu-Bz
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 19:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbYL0SI6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 13:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbYL0SI6
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 13:08:58 -0500
Received: from zoidberg.org ([213.133.99.5]:53334 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818AbYL0SI5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Dec 2008 13:08:57 -0500
Received: from neuron (xdsl-78-34-155-251.netcologne.de [::ffff:78.34.155.251])
  (IDENT: unknown, AUTH: LOGIN jast, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Sat, 27 Dec 2008 19:08:55 +0100
  id 00189B6C.49566F37.00002EEC
In-Reply-To: <1230296219-16408-1-git-send-email-dato@net.com.org.es>
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104010>

Hi,

On Fri, 26 Dec 2008 13:56:59 +0100
"Adeodato Sim=C3=B3" <dato@net.com.org.es> wrote:

> > Has there even been talk of a commit.signoff configuration variable
> > to always add a S-o-b line? This could allow to enable it on a
> > per-project basis, which would be cool.
>=20
> Well, it seemed easy enough to do, so I went ahead. Comments would be
> welcome.

I think it might be a good idea to allow overriding the config variable
in the other direction, i.e. a --no-signoff option to commit. Otherwise=
,
for example, rebase would have no way of suppressing the S-o-b lines in
rebased commits (and you might want to not automatically sign off
commits you rebase).

-Jan
