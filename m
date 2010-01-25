From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 10:58:22 +0100
Message-ID: <201001251058.22714.robin.rosenberg@dewire.com>
References: <201001250155.47664.robin.rosenberg@dewire.com> <fabb9a1e1001250136n2fb0043av7348db9177f4d096@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 10:58:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZLiO-00007r-CN
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 10:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204Ab0AYJ63 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2010 04:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752323Ab0AYJ63
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 04:58:29 -0500
Received: from mail.dewire.com ([83.140.172.130]:2018 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844Ab0AYJ62 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 04:58:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 04836800370;
	Mon, 25 Jan 2010 10:58:24 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q5RXzO6+Jarq; Mon, 25 Jan 2010 10:58:24 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 68CD4800356;
	Mon, 25 Jan 2010 10:58:24 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-17-generic; KDE/4.3.4; i686; ; )
In-Reply-To: <fabb9a1e1001250136n2fb0043av7348db9177f4d096@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137944>

m=E5ndagen den 25 januari 2010 10.36.59 skrev  Sverre Rabbelier:
> Heya,
>=20
> On Mon, Jan 25, 2010 at 01:55, Robin Rosenberg
>=20
> <robin.rosenberg@dewire.com> wrote:
> > In Windows paths beginning with // are knows as UNC paths. They are
> > absolute paths, usually referring to a shared resource on a server.
>=20
> Cute, but will it actually work? I've tried to use them // paths on
> windows before with MSysGit, and it's never worked, probably due to
Works here (tm). Latest msygit + rebuilt git binaries on Windows 2003.

The only program I know in the msysgit installation that didn't accept =
UNC=20
paths prior to this patch was in fact git.=20

> the same reason why it doesn't work in the cmd prompt (whatever reaso=
n
> that may be).

Any code of the this form will of course not support UNC paths:

if (!has_drive_letter(path))
	boom();

-- robin
