From: Peter <vmail@mycircuit.org>
Subject: gitignore: how to exclude a directory tree from being ignored
Date: Thu, 01 Oct 2009 13:07:11 +0200
Message-ID: <4AC48D5F.6060401@mycircuit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 01 14:07:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtKRR-0000A2-76
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 14:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756519AbZJAMHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 08:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756517AbZJAMHN
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 08:07:13 -0400
Received: from mailfe05.tele2.ch ([212.247.154.136]:40491 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756516AbZJAMHM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 08:07:12 -0400
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Oct 2009 08:07:12 EDT
X-Cloudmark-Score: 0.000000 []
X-Cloudmark-Analysis: v=1.0 c=1 a=_Lt3xyT-zzgA:10 a=vWKxTcPCt1ggqAQrsOHYvw==:17 a=txvw553G9ge7Lt1OuhYA:9 a=GHbluKIcI-H3Zq62eCtaUAfusHAA:4
Received: from mail.mycircuit.org (account cxu-8g8-ypb@tele2.ch [188.155.226.135] verified)
  by mailfe05.swip.net (CommuniGate Pro SMTP 5.2.16)
  with ESMTPA id 1213440040 for git@vger.kernel.org; Thu, 01 Oct 2009 13:07:12 +0200
Received-SPF: none
 receiver=mailfe05.swip.net; client-ip=188.155.226.135; envelope-from=vmail@mycircuit.org
Received: from [192.168.1.192] (unknown [192.168.1.192])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "p_email", Issuer "192.168.2.2" (verified OK))
	by mail.mycircuit.org (Postfix) with ESMTP id 6FA12CFA43
	for <git@vger.kernel.org>; Thu,  1 Oct 2009 13:07:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (X11/20090605)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129387>

Hi
I want to exclude binaries except in a dir tree that I do not control.

In .gitignore  I have:

!vendor/
*.exe
*.o

I would expect that all *.exe and *.o are ignored except those somewhere 
in the vendor dir tree.
However, the *.exe and *.o in the vendor dir tree are also ignored.

What is wrong ?
Thanks for you help
P
