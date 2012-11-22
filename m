From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: Auto-repo-repair
Date: Fri, 23 Nov 2012 00:16:34 +0100 (CET)
Message-ID: <cd8ee2cf-2d4a-4d0c-931f-61de4c7f6348@zcs>
References: <CAM9Z-n=tAcpQHTU7WHhzZkoVL_ar9vcH8G1tKd-026+djAiJ4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 00:16:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbg0p-0004g6-71
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 00:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317Ab2KVXQg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2012 18:16:36 -0500
Received: from zcs.vnc.biz ([83.144.240.118]:45080 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790Ab2KVXQf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2012 18:16:35 -0500
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 94F176228CE;
	Fri, 23 Nov 2012 00:16:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rCQLEno2KSlE; Fri, 23 Nov 2012 00:16:34 +0100 (CET)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 2603A62225E;
	Fri, 23 Nov 2012 00:16:34 +0100 (CET)
In-Reply-To: <CAM9Z-n=tAcpQHTU7WHhzZkoVL_ar9vcH8G1tKd-026+djAiJ4A@mail.gmail.com>
X-Originating-IP: [91.43.169.28]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210224>

Hi,

> I still think that it would make the most sense to do the following
> (if you insist on some sort of automated repair):
> (1) Fetch a "good" clone (or clones) into a temporary directory;
> (2) Cannibalize the objects from it (them);
> (3) Re-run git fsck and check for still-missing / unreachable items;
> (4) IF THE RESULT OF (3) IS ACCEPTABLE, run git gc to clean up the
> mess, discard / "merge" duplicate objects, and fix up the packfiles.
>=20
> It is step (4) that requires the most user interaction. I could see
> building up a shell script that does all but (4) nearly
> automatically.
> None of this requires modifying Git itself.

Well, I'd like to have some really automatic mode, which does
everything ondemand.

Once we've got this not just for repair, but also to support
quick partial clones that fetch more objects when required.

In fact, finally, I'd like to have some storage cloud where
data automatically gets replicated to nodes which need the data,
not just for VCS, but other purposes (backup, filestore, etc) too.
But before inventing someting completely new (reinventing much
of the wheel), I'd like to investigate whether git can be
extended into this direction step by step.


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
