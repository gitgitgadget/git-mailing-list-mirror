From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: File Systems and a Theory of Edits
Date: Sun, 31 Jul 2011 10:15:17 +0200
Message-ID: <4E350F15.9050009@lsrfire.ath.cx>
References: <CADo4Y9hG=-Bye5g7OWROJNbbUOcnH0hj0f3csws5V+YzEUKAMg@mail.gmail.com> <CACBZZX48aDN_Njm+qMvovfz1tjdhnmXe5-bbJe=0_Q3LbLWoPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mike@nahas.com, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 10:15:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnRBZ-0000Eo-Rk
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 10:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab1GaIPk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jul 2011 04:15:40 -0400
Received: from india601.server4you.de ([85.25.151.105]:44865 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab1GaIPi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 04:15:38 -0400
Received: from [192.168.2.104] (p579BEE49.dip.t-dialin.net [87.155.238.73])
	by india601.server4you.de (Postfix) with ESMTPSA id 1C4492F8050;
	Sun, 31 Jul 2011 10:15:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <CACBZZX48aDN_Njm+qMvovfz1tjdhnmXe5-bbJe=0_Q3LbLWoPA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178231>

Am 30.07.2011 21:06, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> On Sat, Jul 30, 2011 at 16:29, Michael Nahas <mike.nahas@gmail.com> w=
rote:
>>     "git xargs <commit> ..."  (Is this possible?)
>=20
> I don't have comments on the rest of your proposal, but I've often
> wanted a git-find(1) similar to git-grep(1). Which would give you thi=
s
> functionality.
>=20
> Then you could simply:
>=20
>     git find <commit> <path> -type f | xargs <whatever>
>=20
> Or something like that.

How about this, which should match your example:

	git ls-tree -r --name-only <commit> <path> | xargs <whatever>

Ren=C3=A9
