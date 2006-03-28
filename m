From: sean <seanlkml@sympatico.ca>
Subject: Re: Cherry-pick particular object
Date: Tue, 28 Mar 2006 16:34:22 -0500
Message-ID: <BAYC1-PASMTP02B05019F52DE48793CB39AED30@CEZ.ICE>
References: <20060328113107.20ab4c21.sebastien@xprima.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 23:37:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOLsG-0004DK-1A
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 23:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWC1VhI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 28 Mar 2006 16:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWC1VhI
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 16:37:08 -0500
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:15130 "EHLO
	BAYC1-PASMTP02.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932213AbWC1VhH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Mar 2006 16:37:07 -0500
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 28 Mar 2006 13:37:05 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 0D763644C28;
	Tue, 28 Mar 2006 16:37:02 -0500 (EST)
To: =?ISO-8859-1?B?U+liYXN0aWVu?= Pierre <sebastien@xprima.com>
Message-Id: <20060328163422.0981a743.seanlkml@sympatico.ca>
In-Reply-To: <20060328113107.20ab4c21.sebastien@xprima.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 28 Mar 2006 21:37:06.0004 (UTC) FILETIME=[C2598940:01C652AF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 28 Mar 2006 11:31:07 -0500
S=E9bastien Pierre <sebastien@xprima.com> wrote:

> Hi all,
>=20
> This is a newbie question.
>=20
> I recently wanted to "cherry" pick a particular file from my=20
> git-managed project history. Using gitk, I identified which was=20
> the revision I wanted (95ba0c74e03874e8c1721b91f92f161e9061621f),=20
> and then using git ls-tree, I managed to get the id of the file I=20
> wanted (78132af26431e649a0f85f22dc27e5787d80700f).
>=20
> Now, what I simply wanted was to do something like:
>=20
> "get the file corresponding to 78132af26431e649a0f85f22dc27e5787d8070=
0f=20
>  and save it as myfile.txt"
>=20
> How would one properly do that with core git ?

If you used:

$ git cat-file -t 78132af2643

It would tell you that this object is of type "blob".
To see the contents of blobs you can do something like:

$ git cat-file blob 78132af2643

Sean
