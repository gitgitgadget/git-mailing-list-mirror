From: Timur Tabi <timur@freescale.com>
Subject: git-clone does not work if run in /temp
Date: Thu, 28 Sep 2006 13:36:37 -0500
Organization: Freescale
Message-ID: <451C1635.9090608@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 28 20:37:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT0kV-0001BI-Nc
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 20:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWI1Sgk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 14:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWI1Sgk
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 14:36:40 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:6292 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1030358AbWI1Sgj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 14:36:39 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id k8SInZhR017120
	for <git@vger.kernel.org>; Thu, 28 Sep 2006 11:49:35 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k8SIabnI002828
	for <git@vger.kernel.org>; Thu, 28 Sep 2006 13:36:38 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28031>

If the current directory is '/temp', then git-clone fails:

$ git clone http://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git powerpc
ssh: /temp/http: Name or service not known
fatal: unexpected EOF
fetch-pack from '/temp/http:/git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git/.git' failed.

If I switch to /tmp and run git-clone again, it works.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
