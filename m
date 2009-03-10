From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 0/5] grep: color search patterns
Date: Tue, 10 Mar 2009 17:38:51 +0100
Message-ID: <49B6979B.8080900@lsrfire.ath.cx>
References: <1236428699.6486.41.camel@ubuntu.ubuntu-domain> <fcaeb9bf0903092301i7bc6322dtbd37f662fe4b224b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Thiago Alves <thiago.salves@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 17:40:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh50I-0006L2-D7
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 17:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbZCJQjA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2009 12:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754039AbZCJQjA
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 12:39:00 -0400
Received: from india601.server4you.de ([85.25.151.105]:43045 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962AbZCJQi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 12:38:59 -0400
Received: from [10.0.1.101] (p57B7FF57.dip.t-dialin.net [87.183.255.87])
	by india601.server4you.de (Postfix) with ESMTPSA id 655712F8045;
	Tue, 10 Mar 2009 17:38:57 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <fcaeb9bf0903092301i7bc6322dtbd37f662fe4b224b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112832>

Nguyen Thai Ngoc Duy schrieb:
> On 3/7/09, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
>> Match coloring is a major missing feature of git grep.  It makes rea=
ding
>>  the output much easier and brings grep onto the same visual level a=
s the
>>  other colorized git commands.
>=20
> "git --color test" did not colorize the result for me. "git --color
> --no-ext-grep test" did. Maybe you should ignore external grep unless
> it is explicitly requested, like in the last patch. I have very
> limited net access these days. Let's see if I can work out something
> for tomorrow, unless you beat me to it.

I assume with "last patch" you mean your last patch, right?  It
automatically switched to internal grep if coloring was turned on.

Patch 5 of my series adds support for coloring external greps, but you
have to explicitly specify the config option grep.color.external.  It
can be set by distributors in the system config file -- they should kno=
w
which grep option is needed.

But I can see that a half-colored git grep can be confusing.

Ren=C3=A9
