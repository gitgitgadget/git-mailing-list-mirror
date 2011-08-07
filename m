From: jelly <sinojelly@163.com>
Subject: Re:When i run git difftool, git did not use difftool.bc3.cmd,why?
Date: Sun, 7 Aug 2011 10:03:45 +0800 (CST)
Message-ID: <9c0c497.f7f.131a1fb4855.Coremail.sinojelly@163.com>
References: <24cad567.da0.131a1ed237b.Coremail.sinojelly@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit
To: =?GBK?B?R2l0zNbC29fpKM7e0Ou2qdTEKQ==?= <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 07 04:04:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpsjX-000724-CP
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 04:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756922Ab1HGCEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 22:04:50 -0400
Received: from m13-83.163.com ([220.181.13.83]:49039 "EHLO m13-83.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754873Ab1HGCEt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 22:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Received:Date:From:To:Message-ID:In-Reply-To:
	References:Subject:MIME-Version:Content-Type:
	Content-Transfer-Encoding; bh=me+ap9ijAj3dN1ezgdKMVX1vyQvLYi/SnC
	0rzQc68Zc=; b=JJuWaxgmHMpiv7MVIdar8seyY1o7mHYcED7kan8KeTT19GgLxi
	zcxaQolz43mRRk/1yHnBmAS5bHuxsdpM3CAl4++ggohAN1hR6FcgaUQqPaLtQzlU
	usni3cU3ZUcglbHelxXiN5VpVRs8hGsBMbTw2qa+vMGYOX3DWPzoUxDio=
Received: from sinojelly ( [112.64.213.80] ) by ajax-webmail-wmsvr83
 (Coremail) ; Sun, 7 Aug 2011 10:03:45 +0800 (CST)
In-Reply-To: <24cad567.da0.131a1ed237b.Coremail.sinojelly@163.com>
X-Originating-IP: [112.64.213.80]
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 110713(13936.3901.3890) Copyright (c) 2002-2011 www.mailtech.cn 163com
X-CM-TRANSID: U8GowJD7L96B8j1OwOclAA--.16891W
X-CM-SenderInfo: pvlq0yphoo5qqrwthudrp/1tbiLwGUyUlyuSSH5gADs3
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178895>

>When i run git difftool, git did not use difftool.bc3.cmd,why?>Even i write a wrong exe file name bcomp1.exe, git still use bcompare.
I found the reason.
because bc3 is a special name, git call bcompare internal.change the name bc3, it works fine.
