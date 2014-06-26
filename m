From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Is it possible to list unpushed tags without accessing remote?
Date: Thu, 26 Jun 2014 18:54:22 +0200
Message-ID: <874mz76281.fsf@igel.home>
References: <BAA3119F-8351-4BFD-B42A-C96E4C7A1440@jetbrains.com>
	<CAJo=hJvdMURuaEZA3XEWE_Uuq8QRZ+mt8K2H8XrbTuZsVX9gKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 18:54:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0CwS-0005WC-4O
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 18:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757436AbaFZQy1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jun 2014 12:54:27 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:42325 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756853AbaFZQy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 12:54:26 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3gznPq5gJsz3hhTs;
	Thu, 26 Jun 2014 18:54:23 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3gznPq10q3z7S6QT;
	Thu, 26 Jun 2014 18:54:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id QNAL9zC3LUMl; Thu, 26 Jun 2014 18:54:22 +0200 (CEST)
X-Auth-Info: gVrSyMDQz6wn3OOBc4m+whGeXtygiR7r+pVFkThjeIQ=
Received: from igel.home (ppp-188-174-158-98.dynamic.mnet-online.de [188.174.158.98])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Thu, 26 Jun 2014 18:54:22 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 43CCF2C2527; Thu, 26 Jun 2014 18:54:22 +0200 (CEST)
X-Yow: Let's send the Russians defective lifestyle accessories!
In-Reply-To: <CAJo=hJvdMURuaEZA3XEWE_Uuq8QRZ+mt8K2H8XrbTuZsVX9gKQ@mail.gmail.com>
	(Shawn Pearce's message of "Thu, 26 Jun 2014 09:13:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252510>

Shawn Pearce <spearce@spearce.org> writes:

> On Thu, Jun 26, 2014 at 5:42 AM, Kirill Likhodedov
> <kirill.likhodedov@jetbrains.com> wrote:
>> is it possible to know which tags are not yet pushed to a remote via=
 a completely local command?
>>
>> (e.g. the list of unpushed _commits_ may be received by =E2=80=98git=
 log <upstream>..=E2=80=99)
>>
>> I know it is possible to execute 'git ls-remote=E2=80=99 or 'git pus=
h --dry-run=E2=80=99, but both ask the remote server.
>> I=E2=80=99m almost sure that the answer is =E2=80=9CNO=E2=80=9D, but=
 want to receive a confirmation from Git gurus :)
>
> No. The client doesn't track what tags the remote has.

Not by default, but it is easy to configure your clone to fetch tags to
a separate namespace.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
