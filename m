From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 21:15:51 +0100
Message-ID: <201001252115.52081.robin.rosenberg@dewire.com>
References: <201001250155.47664.robin.rosenberg@dewire.com> <201001252037.41497.robin.rosenberg@dewire.com> <40aa078e1001251148p6263feeevc85a3223f85873@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Jan 25 21:16:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZVLs-0001YJ-K3
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 21:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab0AYUP5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2010 15:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654Ab0AYUP5
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 15:15:57 -0500
Received: from mail.dewire.com ([83.140.172.130]:21453 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752107Ab0AYUP4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 15:15:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 02D4D147E155;
	Mon, 25 Jan 2010 21:15:54 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5KoJU70bycqD; Mon, 25 Jan 2010 21:15:54 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 1734B8006B7;
	Mon, 25 Jan 2010 21:15:54 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-17-generic; KDE/4.3.4; i686; ; )
In-Reply-To: <40aa078e1001251148p6263feeevc85a3223f85873@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137989>

m=E5ndagen den 25 januari 2010 20.48.22 skrev  Erik Faye-Lund:
> On Mon, Jan 25, 2010 at 8:37 PM, Robin Rosenberg
>=20
> <robin.rosenberg@dewire.com> wrote:
> > m=E5ndagen den 25 januari 2010 18.57.06 skrev  Erik Faye-Lund:
> >> On Mon, Jan 25, 2010 at 6:34 PM, Johannes Schindelin
> >>
> >> <Johannes.Schindelin@gmx.de> wrote:
> >> > And even a simple "cd" with them does not work.
> >>
> >> But it does, at least for me - both in bash and cmd.exe. I just ne=
edt.
> >
> > In cmd,exe surprises me a bit. pushd \\server\share is not the same
> > as it maps a drive and then uses it to cd.
> >
> > -- robin
>=20
> My guess would be that Dscho mentioned this because git internally
> does a chdir() to the path that is cloned, so currently chdir'ing mus=
t

chdir doesn't call cmd.exe and does not suffer from cmd's limitations.

-- robin
