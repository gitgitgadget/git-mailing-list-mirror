From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: diff/merge tool that ignores whitespace changes
Date: Sun, 02 Sep 2012 23:07:34 +0200 (CEST)
Message-ID: <4eab55d2-b504-4c66-84be-c1ffe4edf94c@zcs>
References: <504272F0.3070701@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Sep 02 23:08:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8HP5-0000rP-7q
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 23:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893Ab2IBVHg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Sep 2012 17:07:36 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:7909 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754780Ab2IBVHg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Sep 2012 17:07:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 86A274608F4;
	Sun,  2 Sep 2012 23:07:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xS9Q2QaVRXkx; Sun,  2 Sep 2012 23:07:34 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 2954D460426;
	Sun,  2 Sep 2012 23:07:34 +0200 (CEST)
In-Reply-To: <504272F0.3070701@web.de>
X-Originating-IP: [91.43.180.222]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC18 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204677>

Hi,

> Would that help ?
> git help diff
> [snip]
>      --ignore-space-at-eol
>            Ignore changes in whitespace at EOL.
>=20
>        -b, --ignore-space-change
>            Ignore changes in amount of whitespace. This ignores
>            whitespace at
>            line end, and considers all other sequences of one or more
>            whitespace characters to be equivalent.
>=20
>        -w, --ignore-all-space
>            Ignore whitespace when comparing lines. This ignores
>            differences
>            even if one line has whitespace where the other line has
>            none.

That might be it :)
Now I yet need to find out how to configure tig for it.

By the way: anything similar for merge/rebase ?


thx
--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
