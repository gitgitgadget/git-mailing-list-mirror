From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: Support for a series of patches, i.e. patchset or changeset?
Date: Sat, 10 Nov 2012 09:52:21 +0100 (CET)
Message-ID: <6df0df49-afb9-4faf-9a2d-6f397f3a167a@zcs>
References: <CAMPhdO8Sy8ZuXyWbvch+fXzbSVdmwC69a-KaLBRBGX8MVGxv_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Eric Miao <eric.y.miao@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 09:56:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TX6ro-00053W-BV
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 09:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696Ab2KJIwX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 03:52:23 -0500
Received: from zcs.vnc.biz ([83.144.240.118]:42427 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605Ab2KJIwX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 03:52:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 0A1F046000A;
	Sat, 10 Nov 2012 09:52:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IoVWvPdfaknd; Sat, 10 Nov 2012 09:52:21 +0100 (CET)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 989D9460009;
	Sat, 10 Nov 2012 09:52:21 +0100 (CET)
In-Reply-To: <CAMPhdO8Sy8ZuXyWbvch+fXzbSVdmwC69a-KaLBRBGX8MVGxv_A@mail.gmail.com>
X-Originating-IP: [91.43.209.211]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209264>

<snip>

yet another idea:

you coud always put your patchsets into separate branches,
rebase them ontop target branch before merging, and then
do an non-ff-merge, which will make the history look like:

* merged origin/feature_foo
|\
| * first preparation fo feature foo
| * part a
| * part b
|/
* merged origin/bugfix_blah
|\
| * fixing bug blah
|/
*


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
