From: jelly <sinojelly@163.com>
Subject: How to use .gitattributes to tell git that .ini is text file?
Date: Sat, 20 Aug 2011 10:06:45 +0800 (CST)
Message-ID: <bfe44ee.e467.131e4f0b471.Coremail.sinojelly@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?R2l06K6o6K6657uEKOaXoOmhu+iuoumYhSk=?= 
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 20 04:22:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QubCG-00046o-HH
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 04:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab1HTCWA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 22:22:00 -0400
Received: from m13-124.163.com ([220.181.13.124]:34685 "EHLO m13-124.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590Ab1HTCV7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 22:21:59 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Aug 2011 22:21:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Received:Date:From:To:Message-ID:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding; bh=GqT6v50W
	yqfS8sWgZsLRsa0gz3vF70zYjdUIyfgtcGc=; b=FQgBLE2+mLoyfXQBtegKyOAG
	szlA7b3m04fc7BxeCowuQ3mLYPMrd8leXvq3/4p6C9lac1Diqu6/cE/XHChMWoZ3
	zLd6F0WZWdvGS3L+NZhBlf5PXDRPYr7Jui3lnMyNqPDmqYb6C9JPZjK9BM26d7aK
	3qvT9VJVDCksOTMdVKw=
Received: from sinojelly ( [58.247.242.137] ) by ajax-webmail-wmsvr124
 (Coremail) ; Sat, 20 Aug 2011 10:06:45 +0800 (CST)
X-Originating-IP: [58.247.242.137]
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 110713(13936.3901.3890) Copyright (c) 2002-2011 www.mailtech.cn 163com
X-CM-TRANSID: fMGowJD7X8i1Fk9OjEEKAA--.3570W
X-CM-SenderInfo: pvlq0yphoo5qqrwthudrp/1tbiSg+hyU4dPSpO5AAAsD
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179750>

When I use like this, it takes no effect.
C:\Users\jelly\Documents\My Knowledge\Plugins>cat .gitattributes*.ini =C2=
=A0 =C2=A0 text
C:\Users\jelly\Documents\My Knowledge\Plugins>git diffdiff --git a/Misc=
/plugin.ini b/Misc/plugin.iniindex 078c8a9..f73153c 100755Binary files =
a/Misc/plugin.ini and b/Misc/plugin.ini differ
