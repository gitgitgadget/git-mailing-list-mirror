From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Weird filename encoding issue
Date: Fri, 17 Oct 2008 01:57:36 -0700 (PDT)
Message-ID: <m3hc7bk39g.fsf@localhost.localdomain>
References: <c6c947f60810170059s3859d906r9935b5e80d8a41c6@mail.gmail.com>
	<c6c947f60810170108q3038b66bj2ad89bdcb7105903@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: "Alexander Gladysh" <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 10:58:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqlAc-0005bm-76
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 10:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbYJQI5l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Oct 2008 04:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbYJQI5k
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 04:57:40 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:31780 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbYJQI5j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Oct 2008 04:57:39 -0400
Received: by ey-out-2122.google.com with SMTP id 6so157901eyi.37
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 01:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=uNcimM5+Qy8hFYBXC/PdGuZRKQ/LR/poXeeexANA1QM=;
        b=FKWDUebNyshDlj7+R7B/87zA+AZavYswSs7I3dspVql6llkdqP+B7RWvcqNrhH6JuB
         k6Tg1ACjUm6Pua03nY6JdohjhhBSBxbWYvEtjSdjb4t+QLJcq4uFJZtS2BdToxihifK6
         s22BshWxZfk182mx62nmKRsIQS/13Tg60T7os=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=cPUkznppxTPql0eKYCfVr9UyPnGx2ypSXrfQZgZFFoFoqzVpf9ye9CJ2liFsAwyB08
         KHni14X+iAfogOipnqK/YcszblxN3RErc/mPYjrHZm/Uddj+BP6NrzlT4spbmiMOLpvP
         IZ5pv/kQbwpSfEn0NnZXq5uhRv+0uh75qeryc=
Received: by 10.210.81.10 with SMTP id e10mr1356964ebb.187.1224233857470;
        Fri, 17 Oct 2008 01:57:37 -0700 (PDT)
Received: from localhost.localdomain (abvf153.neoplus.adsl.tpnet.pl [83.8.203.153])
        by mx.google.com with ESMTPS id 5sm3496936eyf.8.2008.10.17.01.57.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Oct 2008 01:57:36 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9H8vWY7029814;
	Fri, 17 Oct 2008 10:57:33 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9H8vVSX029811;
	Fri, 17 Oct 2008 10:57:31 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <c6c947f60810170108q3038b66bj2ad89bdcb7105903@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98461>

"Alexander Gladysh" <agladysh@gmail.com> writes:

> Steps to reproduce:
>=20
> 1. Create git repo on Windows machine, add there file, named
> "=D0=9A=D0=BE=D0=BF=D0=B8=D1=8F.txt" (Russian for Copy.txt) in CP1251=
 (NOT UTF-8). Just in
> case, hopefully correctly named file is attached.
>=20
> File must be added and committed from git gui, not from command line.
>=20
> $ mkdir test && cd test
> $ git init
> <put file there>
> $ git gui
>=20
> 2. Share the repo somewhere, so it would be accessible from OS X (rep=
o
> should still be on Windows machine).
>=20
> 3. Clone repo to OS X machine and see the weird behaviour. Git status
> can't decide how file should be named, "%CA%EE%EF%E8%FF.txt" or
> "\312\356\357\350\377.txt".

I _suspect_ that it is caused by known issue with MacOS X filesystem
in default settings.  Git assumes that what he puts in filesystem is
the same that it reads from filesystem; there is ongoing (although
bit stalled) effort to make Git work around this.  Unfortunately HFS+
does not, I think, fullfil this requirement.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
