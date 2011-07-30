From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: git fatal: error in sideband demultiplexer
Date: Sat, 30 Jul 2011 18:13:41 +0200
Message-ID: <20110730161341.GB7545@toss.lan>
References: <CALQf3znEm2ZqS1nvon0iB-6ddm-rJyTAPYgCENy2xF0AZb1U+g@mail.gmail.com>
 <CALQf3zknO9ZxXCLWy3Bep2eMhrt-jfLkRWJBOf-f2ebku7YZHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?5a2Z55Cm?= <qsundw@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 18:13:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnCAg-0005mw-Vv
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 18:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156Ab1G3QNp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jul 2011 12:13:45 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:59381 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752143Ab1G3QNo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 12:13:44 -0400
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 594BE130056;
	Sat, 30 Jul 2011 18:13:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CALQf3zknO9ZxXCLWy3Bep2eMhrt-jfLkRWJBOf-f2ebku7YZHg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178209>

On Sat, Jul 30, 2011 at 06:16:58PM +0800, =E5=AD=99=E7=90=A6 wrote:
>=20
> Cloning into newdb...
> remote: Counting objects: 1231592, done.
> remote: Compressing objects: 100% (239755/239755), done.
> Receiving objects: 100% (1231592/1231592), 2.70 GiB | 4.93 MiB/s, don=
e.
> fatal: read error: Invalid argument

Could you please try that again with "GIT_TRACE=3D1 git clone ..."?
Also, "strace git clone ..." (or whatever strace equivalent exists
on windows, if any?).

> Resolving deltas: 100% (935560/935560), done.
> fatal: error in sideband demultiplexer
