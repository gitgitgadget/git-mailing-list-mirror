From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: A basic question
Date: Thu, 11 Oct 2012 20:51:45 +0200 (CEST)
Message-ID: <d89615b8-d153-41c9-963d-127a614321cb@zcs>
References: <002801cda7d7$4792c260$d6b84720$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Skot Davis <skotd122@gmail.com>, git@vger.kernel.org,
	Drew Northup <drew.northup@maine.edu>
To: Jim Vahl <jv@wmdb.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 20:52:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMNrT-0006db-9z
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 20:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758977Ab2JKSvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2012 14:51:48 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:49935 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756745Ab2JKSvs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 14:51:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 442B36228C2;
	Thu, 11 Oct 2012 20:51:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xWk5pjxcFEbU; Thu, 11 Oct 2012 20:51:45 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id DEEDC6228BF;
	Thu, 11 Oct 2012 20:51:45 +0200 (CEST)
In-Reply-To: <002801cda7d7$4792c260$d6b84720$@com>
X-Originating-IP: [91.43.169.65]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207505>


> 1) Does git have a built-in way to get a list of all of the "most
> recently
> committed" files only at a given point in time, thus automatically
> recording
> the revisions of all of the component files of a release? =20

There is no concept of per-file revisions in git.
But you can check which ones are changed in multiple ways, eg:

* per commit, commit-range or per-branch level -> see git-log manpage
* between arbitratry commints -> see git-diff manpage

> This implies that for files which are being modified or which have
> been staged but not committed, that git would go back to find the
> "predecessor" file which had been committed.

=46orget about the staging issue (index) at this point - it's just
existing in the _local_ clone (eg of some individual developer),
for your usecase you're only interested in what's actually committed
to certain branch(es).


cu
--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
