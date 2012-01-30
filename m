From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: git rebase and MacOS 10.7.2 file versions
Date: Mon, 30 Jan 2012 20:11:23 +0100
Message-ID: <4F26EB5B.4000907@web.de>
References: <A9AB7E23-3C22-4BCC-8E25-EF2D66B57E61@dfki.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Thomas_R=F6fer?= <Thomas.Roefer@dfki.de>
X-From: git-owner@vger.kernel.org Mon Jan 30 20:11:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrwdX-0002We-GR
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 20:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881Ab2A3TL1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 14:11:27 -0500
Received: from smtp-out11.han.skanova.net ([195.67.226.200]:57929 "EHLO
	smtp-out11.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752418Ab2A3TL0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 14:11:26 -0500
Received: from birne.lan (194.22.188.61) by smtp-out11.han.skanova.net (8.5.133) (authenticated as tboegi@telia.com)
        id 4EFC3D3500B58013; Mon, 30 Jan 2012 20:11:24 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <A9AB7E23-3C22-4BCC-8E25-EF2D66B57E61@dfki.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189403>

On 30.01.12 17:46, Thomas R=F6fer wrote:
> Hi,
>=20
> I get mysterious behavior during git rebase on MacOS 10.7.x. git repo=
rts unresolvable conflicts, stops the rebase, but afterwards the list o=
f files that needs to be fixed is empty. git rebase --skip does not hel=
p, because then the commit is actually missing.
>=20
> What helps is to abort the rebase, copy the conflicting files, delete=
 the originals and move back the copies instead. The files themselves a=
re identical before deleting and after restoring and their access right=
s are also unchanged. What is actually different is that all the confli=
cting files so far had older versions stored by Lion's "file versions" =
feature. The restored copies do not have such a version history. Since =
"file versions" cannot be deactivated, editing a file with an applicati=
on that supports it (e.g. TextEdit) will basically result in strange gi=
t conflicts later.
>=20
> I have tested this with a number of git versions, but the behavior is=
 always the same.
>=20
> All this may simply be a bug in MacOS 10.7.x, but maybe there is a wo=
rkaround for git to make this work again.
>=20
> Best regards,
>=20
> Thomas R=F6fer
Hi,

is that problem reproducable? It seems so.

Could provide a simple demo, what you have done and how to reproduce th=
e error?
=20
If that is the case, chances that we can reproduce it are much better.
And so are the chances that somebody reading this list can help you.

>Lion's "file versions" feature..
Are the files identical when you run e.g. md5sum on them?
And what does a simple "ls" from a terminal say?


/Torsten
