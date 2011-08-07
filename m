From: jelly <sinojelly@163.com>
Subject: When i run git difftool, git did not use difftool.bc3.cmd,why?
Date: Sun, 7 Aug 2011 09:48:18 +0800 (CST)
Message-ID: <24cad567.da0.131a1ed237b.Coremail.sinojelly@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?R2l06K6o6K6657uEKOaXoOmhu+iuoumYhSk=?= 
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 07 04:04:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qpsir-0006tC-GZ
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 04:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756886Ab1HGCDg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Aug 2011 22:03:36 -0400
Received: from m13-83.163.com ([220.181.13.83]:48519 "EHLO m13-83.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754873Ab1HGCDf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2011 22:03:35 -0400
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Aug 2011 22:03:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Received:Date:From:To:Message-ID:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding; bh=+iam01AB
	oJoNkqzSyFu2HS7ooXroclKYox7dz6MvAyM=; b=ZUhBjcpeCaC2lQAGxCxFTPrw
	ht3D/v+mzLkF80u0WMVo8RVu33H6H0wr8KGe8B/1lsr3+kTyij9Z+X5fwNmCCnus
	RRF5kotV3Bpf3a2m7U0BMCAczkTqOBi5ocSG5CsneSrwGvQopVidoJ5XIgMWgCZR
	dvSTS0s68Qw3ochPJ2s=
Received: from sinojelly ( [112.64.213.80] ) by ajax-webmail-wmsvr83
 (Coremail) ; Sun, 7 Aug 2011 09:48:18 +0800 (CST)
X-Originating-IP: [112.64.213.80]
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 110713(13936.3901.3890) Copyright (c) 2002-2011 www.mailtech.cn 163com
X-CM-TRANSID: U8GowJDr38Li7j1OauQlAA--.7513W
X-CM-SenderInfo: pvlq0yphoo5qqrwthudrp/1tbiLwGUyUlyuSSH5gABs1
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178894>

Even i write a wrong exe file name bcomp1.exe, git still use bcompare.
=C2=A0
[diff]
=C2=A0 =C2=A0 tool =3D bc3
[difftool "bc3"]
=C2=A0 =C2=A0 cmd =3D "/cygdrive/c/program files/beyond compare 3/bcomp=
1.exe" "$(cygpath -w $LOCAL)" "$REMOTE"

$ git difftool/usr/lib/git-core/git-mergetool--lib: line 124: bcompare:=
 command not found
