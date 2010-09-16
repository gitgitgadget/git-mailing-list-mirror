From: Wincent Colaiuta <win@wincent.com>
Subject: Re: v1.7.3-rc2 has t7003 breakage on Mac OS X 10.6.4
Date: Thu, 16 Sep 2010 11:11:34 +0200
Message-ID: <42051373-11A7-4F8A-980F-9562CA3C522D@wincent.com>
References: <664FE520-CDB1-4595-867A-9AEB4790C092@wincent.com> <4C91DDB6.5000406@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 16 11:27:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwAkt-0004pR-AQ
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 11:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415Ab0IPJ1l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 05:27:41 -0400
Received: from outmail137144.authsmtp.net ([62.13.137.144]:57910 "EHLO
	outmail137144.authsmtp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751768Ab0IPJ1k convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 05:27:40 -0400
X-Greylist: delayed 961 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Sep 2010 05:27:40 EDT
Received: from mail-c187.authsmtp.com (mail-c187.authsmtp.com [62.13.128.33])
	by punt9.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o8G9BcAw065095
	for <git@vger.kernel.org>; Thu, 16 Sep 2010 10:11:38 +0100 (BST)
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o8G9BZVS098103
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 16 Sep 2010 10:11:36 +0100 (BST)
Received: from [192.168.1.6] (7.Red-83-59-198.dynamicIP.rima-tde.net [83.59.198.7] (may be forged))
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o8G9Aqto010915
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Thu, 16 Sep 2010 05:11:35 -0400
In-Reply-To: <4C91DDB6.5000406@viscovery.net>
X-Mailer: Apple Mail (2.1081)
X-Server-Quench: 68d0b5e4-c172-11df-ab46-001185d377ca
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha Dh4fBRVVLUBPVglL NEteaF1JP0tFGxZi ViYUWVRVUE1wWWl0 agBSaktcak5QWAZ0 UktNXFBTFBpqBAMA SEEWJRAAHWMleHd4 ZEZhEHJdWkw0c04p QhxRQGkbNmZnan0e URQOalIGdAVXfh9E a1h6AHAKZjZWKBg1 TUctZnZue24aMi8P CgEENhoOHh5TRXY2 XR0LHjwgEAUCQW0W JhduDWVULA5IagNs dwdJ
X-Authentic-SMTP: 61633436303433.1000:706
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156302>

El 16/09/2010, a las 11:04, Johannes Sixt escribi=F3:

> Am 9/16/2010 9:18, schrieb Wincent Colaiuta:
>> Just noticed a new test failure in t7003 on Mac OS X 10.6.4. Wasn't =
present in rc1, but is in rc2.
>=20
> git pull git://github.com/gitster/git.git bg/fix-t7003
>=20
> -- Hannes

Ok, just tested it and confirmed that that topic fixes the test breakag=
e for me, thanks to 77f2e4f5f.

Curses on the Mac's case-insensitive filesystem, again...

Cheers,
Wincent