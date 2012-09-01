From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: diff/merge tool that ignores whitespace changes
Date: Sat, 01 Sep 2012 22:11:13 +0200 (CEST)
Message-ID: <fab86cd5-e3cf-4ddf-aa00-aafe44e8ce8c@zcs>
References: <1679275990.100371.1346175639379.JavaMail.root@genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 01 22:12:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7u32-0002dT-SM
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 22:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672Ab2IAULQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Sep 2012 16:11:16 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:40125 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755632Ab2IAULP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Sep 2012 16:11:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id EFB18460846
	for <git@vger.kernel.org>; Sat,  1 Sep 2012 22:11:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Eqm8yYKrsyuf for <git@vger.kernel.org>;
	Sat,  1 Sep 2012 22:11:13 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id A0FEA4602AB
	for <git@vger.kernel.org>; Sat,  1 Sep 2012 22:11:13 +0200 (CEST)
In-Reply-To: <1679275990.100371.1346175639379.JavaMail.root@genarts.com>
X-Originating-IP: [91.43.198.122]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC18 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204649>


<snip>

Thanks folks, but that doesn't solve my problem. I'm looking for someth=
ing
that's usable on command line or in scripts.

Usecase a)

* git-diff or git-format-patch or tig should not show differences
  that are only whitespace changes (eg. differing linefeeds or
  tabs vs. spaces, changed indentions, etc)

Usecase b)

* when doing merges or rebases, changes in whitespaces only should be
  either ignored or resolved fully automtically.
* For example:
  -> A changes spaces into tabs or adds leading/trailing spaces
  -> B changes some non-spaces=20

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
