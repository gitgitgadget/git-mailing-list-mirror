From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: Re: [PATCH] Add a commit.signoff configuration variable to always
 use --signoff.
Date: Sat, 27 Dec 2008 20:15:41 +0100
Message-ID: <20081227201541.4a352129@neuron>
References: <1230296219-16408-1-git-send-email-dato@net.com.org.es>
	<20081227190819.7257932a@neuron>
	<20081227184001.GA31893@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Adeodato =?UTF-8?B?U2ltw7M=?=" <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Sat Dec 27 20:17:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGeem-0006YA-6N
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 20:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbYL0TPp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 14:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbYL0TPp
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 14:15:45 -0500
Received: from zoidberg.org ([213.133.99.5]:42149 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754628AbYL0TPo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Dec 2008 14:15:44 -0500
Received: from neuron (xdsl-78-34-155-251.netcologne.de [::ffff:78.34.155.251])
  (IDENT: unknown, AUTH: LOGIN jast, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Sat, 27 Dec 2008 20:15:44 +0100
  id 00189B6C.49567EE0.00007C3B
In-Reply-To: <20081227184001.GA31893@chistera.yi.org>
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104014>

Hi,

On Sat, 27 Dec 2008 19:40:01 +0100
"Adeodato Sim=C3=B3" <dato@net.com.org.es> wrote:

> > I think it might be a good idea to allow overriding the config
> > variable in the other direction, i.e. a --no-signoff option to
> > commit. [...]
>=20
> Good catch.
>=20
> --no-signoff exists already, so maybe git-rebase should just use it?

Oh, yeah, I didn't notice the option mechanism worked this way and the
options got parsed after processing the config variables. I guess
rebase and rebase--interactive should use it, then, and perhaps there
are other commands that should that I just don't know about (a grep
across all commands implemented in shell script didn't find anything
else, though).

-Jan
