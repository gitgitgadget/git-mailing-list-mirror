From: Yann Dirson <dirson@bertin.fr>
Subject: Re: ghost refs
Date: Tue, 20 Apr 2010 16:42:25 +0200
Organization: Bertin Technologies
Message-ID: <20100420164225.1400c280@chalon.bertin.fr>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com>
 <r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com>
 <20100407210010.GB27012@coredump.intra.peff.net>
 <loom.20100420T085842-887@post.gmane.org>
 <20100420115124.GB22907@coredump.intra.peff.net>
 <s2m76718491004200633la1cb07a6n8bc0d8d8e71b4e92@mail.gmail.com>
 <20100420142444.GA8851@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 20 16:45:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4EhF-0005GK-71
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 16:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889Ab0DTOo7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 10:44:59 -0400
Received: from blois.bertin.fr ([195.68.26.9]:36880 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754812Ab0DTOo6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Apr 2010 10:44:58 -0400
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id D123B545EB
	for <git@vger.kernel.org>; Tue, 20 Apr 2010 16:44:56 +0200 (CEST)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 9E854545D9
	for <git@vger.kernel.org>; Tue, 20 Apr 2010 16:44:56 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.3.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0L16009RSJMWSVA0@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Tue, 20 Apr 2010 16:44:56 +0200 (CEST)
In-reply-to: <20100420142444.GA8851@coredump.intra.peff.net>
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.12.12; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8146-6.0.0.1038-17330.007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145379>

Le Tue, 20 Apr 2010 10:24:44 -0400,
Jeff King <peff@peff.net> a =C3=A9crit :

> On Tue, Apr 20, 2010 at 09:33:42AM -0400, Jay Soffian wrote:
>=20
> > 4. Just append to the existing reflog? Given:
> >=20
> > $ git checkout -b topic origin/master # 1
> > $ git add; git commit ...
> > $ git checkout master
> > $ git merge topic
> > $ git branch -d topic
> > $ git checkout -b topic origin/master # 2
>=20
> I like how the user would interact with that, but what happens with:
>=20
>   git checkout -b topic/subtopic
>=20
> The reflog of the deleted branch is in the way.

That would be addressed by considering logs/dead_refs/* contents
*logical* continuations of logs/refs/* (bottom-most suggestion in my
other email)

--=20
Yann
