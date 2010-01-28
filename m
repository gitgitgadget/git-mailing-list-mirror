From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@fzi.de>
Subject: Re: [PATCH] bash: support 'git notes' and its subcommands
Date: Thu, 28 Jan 2010 04:30:39 +0100
Message-ID: <20100128033039.GB15202@neumann>
References: <1264640755-22447-1-git-send-email-szeder@ira.uka.de>
	<201001280223.35625.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jan 28 04:30:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaL5n-0004B1-S5
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 04:30:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022Ab0A1Daq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2010 22:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821Ab0A1Dap
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 22:30:45 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:50449 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab0A1Dap (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 22:30:45 -0500
Received: from [127.0.1.1] (p5B1303A9.dip0.t-ipconnect.de [91.19.3.169])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MLT3m-1NatJt43s2-000a65; Thu, 28 Jan 2010 04:30:41 +0100
Content-Disposition: inline
In-Reply-To: <201001280223.35625.johan@herland.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX186fJIX188EXLID7XoG2hf3cJSjdoXAaz2yoWc
 NJG61zEbcqioGTiTkfcLlIuuOW5XlPW9Pb4lVpe73RjZIz26vR
 PsJDd2yX6T575bZowAaRA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138223>

Hi Johan,


On Thu, Jan 28, 2010 at 02:23:35AM +0100, Johan Herland wrote:
> On Thursday 28 January 2010, SZEDER G=E1bor wrote:
> > ... and it will offer refs unless after -m or -F, because these two
> > options require a non-ref argument.
>=20
> Maybe-NAK.
>=20
> The patch is probably good in itself, and the intent is certainly goo=
d, but=20
> we're currently discussing deprecating the -m/-F options to "git note=
s edit"=20
> (see http://article.gmane.org/gmane.comp.version-control.git/138215),=
 and if=20
> that's where we go, there's no point "encouraging" their use by addin=
g bash-
> completions for them...

-m and -F are not encouraged, because they are not offered (short
options in general are never offered by the completion script).
However, their presence or absence is taken into account to offer
something sensible: refs after 'git notes edit <TAB>', files after
'git notes edit -F <TAB>'.  Note, that I chose 'edit' here, because
currently it's the only subcommand taking '-F', but it will actually
work the same way with the upcoming 'add' and 'append' subcommands.


Best,
G=E1bor


[btw, Shawn, could you have a look at
http://article.gmane.org/gmane.comp.version-control.git/137754 ?]
