From: Niki Guldbrand <niki.guldbrand@gmail.com>
Subject: git-archive not working correctly ?
Date: Mon, 17 Sep 2007 00:50:26 +0200
Message-ID: <1189983026.22727.61.camel@niki2.guldbrand.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 00:50:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX2x1-0005Xf-29
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 00:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbXIPWur convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2007 18:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbXIPWur
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 18:50:47 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:54636 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbXIPWuq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 18:50:46 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1394409fkz
        for <git@vger.kernel.org>; Sun, 16 Sep 2007 15:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=Re0rtcA7bUVVk/lBH2MiXFZ41aoXhxaOYwI+C3a0G34=;
        b=CDZQWPIclXHXALsezev50z+t7PZERK17wY5WOkh2o1CGyFNeaxgYT70KhUnFAWQE1dd4OcRvAYN/54ZSWErMDOQq1vVOY8zJl4SZp50DEmh3RkR2KCUmZ9NTu4+YcFLW6rnMlE8vlVPKhjcu8a2ov0UgBnWDHPAgpuiuPuWMsIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=hFbbTLXdHUWddIN+VQtTZliKdDf8topXoe6Bbpt0w3a/55Iromx9nP7z1hzhGFb23H+ZFjI9RN4TlkBJHlhUwoDFJZ/usLB6qsjTRMVYRhD3R3/scCXP7yX0U2ICMZ+9ZFTfrIoFnMkfewpx/J0MwdPROIecNcQEgVPV30j731A=
Received: by 10.82.186.5 with SMTP id j5mr4574557buf.1189983044604;
        Sun, 16 Sep 2007 15:50:44 -0700 (PDT)
Received: from ?10.5.20.82? ( [85.83.22.156])
        by mx.google.com with ESMTPS id i3sm2899973nfh.2007.09.16.15.50.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Sep 2007 15:50:43 -0700 (PDT)
X-Mailer: Evolution 2.10.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58363>

Hi.

I have been playing with git-archive for and hour or so, but can't get
it to pass "extra" options to tar as it's documented that it should, or
am i reading the docs wrong ?

git-archive --format=3D<fmt> [--list] [--prefix=3D<prefix>/] [<extra>]
[--remote=3D<repo>] <tree-ish> [path=85]

<extra>
        This can be any options that the archiver backend understand.
        See next section.
       =20
I want to git tar the "--exclude=3Doption", but i can't get it through.
Is this option only valid for the zip format with the options "-0" and
"-9" ?


Kind regards

Niki Guldbrand
