From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Thu, 29 Sep 2011 22:18:39 +0200
Message-ID: <4E84D29F.6020305@lsrfire.ath.cx>
References: <4E37202B.80208@lsrfire.ath.cx> <20110802040004.GC17494@sigill.intra.peff.net> <4E3829DC.8070802@lsrfire.ath.cx> <20110802181357.GA1861@sigill.intra.peff.net> <4E388A55.6080606@kdbg.org> <4E3D0C1D.9000807@lsrfire.ath.cx> <4E3EEF3B.80908@kdbg.org> <4E401869.8060702@lsrfire.ath.cx> <20110809050211.GA3588@sigill.intra.peff.net> <4E410B26.1080407@lsrfire.ath.cx> <20110809200504.GA31944@sigill.intra.peff.net> <CABPQNSba+nQ+AOmVEVNWhJi2e65EiuhRxfOWZsW03Pkc6zXdHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, msysGit <msysgit@googlegroups.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 29 22:19:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9N57-00019f-0L
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 22:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757667Ab1I2USv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 16:18:51 -0400
Received: from india601.server4you.de ([85.25.151.105]:55467 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757651Ab1I2USs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 16:18:48 -0400
Received: from [192.168.2.104] (p4FFD9870.dip.t-dialin.net [79.253.152.112])
	by india601.server4you.de (Postfix) with ESMTPSA id 697CD2F805F;
	Thu, 29 Sep 2011 22:18:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <CABPQNSba+nQ+AOmVEVNWhJi2e65EiuhRxfOWZsW03Pkc6zXdHg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182430>

Am 29.09.2011 21:54, schrieb Erik Faye-Lund:
> So the way forward is probably to just change to a self-compiled gzip
> in msysGit (and Git for Windows by proxy).
>=20
> I'll post the patch to build a native-gzip to the msysGit mailing lis=
t
> (I only got 1.2.4 to compile on Windows, but it's the same version as
> we have in msysGit so it's probably fine), and post the latest versio=
n
> of this series soon...

Good to hear that.

By the way, are you aware of http://unxutils.sourceforge.net/ (includes
a native gzip 1.2.4 binary)?

Or http://zlib.net/pigz/ (parallel gzip, no binaries)?

Ren=E9
