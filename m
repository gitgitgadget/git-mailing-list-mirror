From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-fetch question/bug
Date: Fri, 14 Mar 2008 08:52:58 +0100
Organization: At home
Message-ID: <frdasr$v81$1@ger.gmane.org>
References: <5d46db230803132208r3f3f9e34q80bb9c03d65ab67c@mail.gmail.com> <7vbq5hub74.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 08:53:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja4jm-0006X6-RI
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 08:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbYCNHxR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2008 03:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbYCNHxQ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 03:53:16 -0400
Received: from main.gmane.org ([80.91.229.2]:34321 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641AbYCNHxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 03:53:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ja4iz-0007ef-VX
	for git@vger.kernel.org; Fri, 14 Mar 2008 07:53:09 +0000
Received: from abut199.neoplus.adsl.tpnet.pl ([83.8.191.199])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 07:53:09 +0000
Received: from jnareb by abut199.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 07:53:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abut199.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77189>

Junio C Hamano wrote:

> "Govind Salinas" <blix@sophiasuchtig.com> writes:
>=20
>> ... git-fetch when I discovered that it does not return
>> error when the
>> fetch fails due to it not being a ff...
>=20
> I think this is a regression introduced when "git-fetch" was
> re-implemented in C. =A0git-fetch--tool's native-store subcommand see=
ms to
> have signaled this as an error, and it is reasonable to expect an err=
or
> exit from the command in this case.
>=20
> Probably something like this?

[...]

Wouldn't it be better to distinguish somehow remote side errors (like f=
or
example: could not connect to remote server) and local side errors (lik=
e
fetch refused because of being not fast-forward)? The former are usuall=
y
not recoverable (unless it is URL that is mistyped), the latter could b=
e
usually resolved (forced for example)...

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
