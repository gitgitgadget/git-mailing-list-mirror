From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [GSoC] A late proposal: a modern send-email
Date: Sun, 27 Mar 2016 22:00:02 +0000
Message-ID: <20160327220002.GA29057@dcvr.yhbt.net>
References: <CAKqreuyC8p9m_dgVpXCiT_hf=8qBA_5kZ5NABQGx0QDOiCBbww@mail.gmail.com>
 <xmqqzitm2zkj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 00:00:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akIjH-0001ch-88
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 00:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbcC0WAF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Mar 2016 18:00:05 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46274 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752238AbcC0WAE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 18:00:04 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8FCC633805;
	Sun, 27 Mar 2016 22:00:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqzitm2zkj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290024>

Junio C Hamano <gitster@pobox.com> wrote:
> =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:
> > - Build a simple email client (maybe a web components based web app=
 or
> > wxwidgets based GUI client, they are both cross-platform) which is
> > easy to use for sending patch without disrupting the mailbox format=
=2E
>=20
> I suspect it would yield a better result if the plan were to update
> a popular email client and make it possible to tell it to read an
> existing text file (i.e. mbox) without corrupting its contents.
> People do not have to learn a new mail client if done that way.

Another bigger problem is people rely heavily on webmail UIs
nowadays instead of running any local mail clients :<

While Gmail provides SMTP access, it was (last I was told)
incompatible with two-factor auth; so I've encountered users
unable to send patches with their normal 2FA-enabled accounts.

Maybe git hackers at Google have enough pull to lobby Gmail's
web interface to make it easier to send plain-text patches;
but I would love more to see users running local mail clients
and even running their own SMTP servers.

> That may not be a "Git" project, but GSoC is not limited to Git ;-)

Completely agreed; email is critical to decentralized development;
but I don't believe decentralization is in the best interests of
any large and powerful corporation.

IMHO, what we need is a SoIS: Summer of Independent Sysadmins :>
