From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Use the best available exec path only
Date: Sun, 11 Nov 2007 22:12:39 +0100
Organization: At home
Message-ID: <fh7r84$vj$1@ger.gmane.org>
References: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com> <Pine.LNX.4.64.0711111557370.4362@racer.site> <FCFF59B3-D3F1-4BEB-B3C3-D07DD5D5D8EF@silverinsanity.com> <7v3avcefg9.fsf@gitster.siamese.dyndns.org> <20071111203318.GA32671@atjola.homenet> <Pine.LNX.4.64.0711112047170.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 22:13:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrK7A-0000Kd-3b
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 22:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbXKKVMv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 16:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752246AbXKKVMv
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 16:12:51 -0500
Received: from main.gmane.org ([80.91.229.2]:57320 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbXKKVMu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 16:12:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IrK6k-0002lN-TH
	for git@vger.kernel.org; Sun, 11 Nov 2007 21:12:43 +0000
Received: from abtr2.neoplus.adsl.tpnet.pl ([83.8.163.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 21:12:42 +0000
Received: from jnareb by abtr2.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 21:12:42 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abtr2.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64513>

Johannes Schindelin wrote:
> On Sun, 11 Nov 2007, Bj=F6rn Steinbrink wrote:
>>
>> ---
>> Instead of adding all possible exec paths to PATH, only add the best
>> one, following the same rules that --exec-path, without arguments, u=
ses
>> to figure out which path to display.
>>=20
>> Signed-off-by: Bj?rn Steinbrink <B.Steinbrink@gmx.de>
>> ---
>=20
> For easy application by the maintainer, please make the commit messag=
e the=20
> first part, then have a single "---", and then the quoted mail.

There are two conventions, for slightly different cases:

1. Commit message, then diffstat / single "---", then comments,
   then patch

2. Email (for example long discussion), then separator BUT NOT "---";
   use for example "-- >8 --" (cut here scissors), then commit message,
   then diffstat and patch, beginning with "---".

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
