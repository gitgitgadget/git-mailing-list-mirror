From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 12:01:22 +0100
Message-ID: <201001251201.23064.robin.rosenberg@dewire.com>
References: <201001250155.47664.robin.rosenberg@dewire.com> <40aa078e1001250211w2dcc5e97vf89f64f136bd2f0@mail.gmail.com> <fabb9a1e1001250222n6912905fqfd2e76f8d4496bb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 12:01:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZMhS-00045n-Dk
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 12:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727Ab0AYLB1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2010 06:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611Ab0AYLB1
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 06:01:27 -0500
Received: from mail.dewire.com ([83.140.172.130]:3927 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab0AYLB0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 06:01:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 12655800370;
	Mon, 25 Jan 2010 12:01:25 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id luFyWoP-e2xV; Mon, 25 Jan 2010 12:01:24 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 91A78800353;
	Mon, 25 Jan 2010 12:01:24 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-17-generic; KDE/4.3.4; i686; ; )
In-Reply-To: <fabb9a1e1001250222n6912905fqfd2e76f8d4496bb7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

m=E5ndagen den 25 januari 2010 11.22.19 skrev  Sverre Rabbelier:
> Heya,
>=20
> On Mon, Jan 25, 2010 at 11:11, Erik Faye-Lund <kusmabite@googlemail.c=
om>=20
wrote:
> > C:\Users\kusma>dir \\mongo\code
> > The request is not supported.
> >
> > C:\Users\kusma>explorer \\mongo\code
> > <login on the gui>
> >
> > C:\Users\kusma>dir \\mongo\code
> >  Volume in drive \\mongo\code is Code
> >  Volume Serial Number is 04C3-0225
>=20
> Ah, that's very interesting. Not sure that will help MSysGit a lot th=
ough.
>=20

Could you perhaps *try* it before claiming it won't work? I suggest you
use forward slashes to avoid quoting problems.

-- robin
