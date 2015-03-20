From: Olaf Hering <olaf@aepfle.de>
Subject: cover letter and cc list
Date: Fri, 20 Mar 2015 18:35:04 +0100
Message-ID: <20150320173504.GA6162@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 18:35:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ0pH-0000GU-3Z
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 18:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbbCTRfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 13:35:10 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:52907 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbbCTRfG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 13:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1426872904; l=448;
	s=domk; d=aepfle.de;
	h=Content-Disposition:Content-Type:MIME-Version:Subject:To:From:Date;
	bh=bPKlsjEfEUEeRV6x77wTa4LCWZmR8+639ck5GtwuDvM=;
	b=WMkOO1uOtVpM1JGwzMEpIpXpi4JKCU4DWUeVefxDQ2tNNS7qdfoF6Bvw2EzHb4HS9AI
	IJZ2Dj/of2AfZVDpXXjuFVo1TnKSeDX3tMH7X0VvH4wtSczrjMkgqDLpXoMIHnemNpra9
	OQRUggtpKRUOvH9k8vihdAyVMm6D2YV9MHU=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfssDItSR5Gliv93fjczMS8dqZ7ZQnPKi0CzW59KJg==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:1085:1c01:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 37.4 AUTH)
	with ESMTPSA id J0345cr2KHZ4Z93
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	for <git@vger.kernel.org>;
	Fri, 20 Mar 2015 18:35:04 +0100 (CET)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id 4960650278; Fri, 20 Mar 2015 18:35:04 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265916>


What does it take to send the cover letter to all people which are
listed in the Cc: list of the following patches? Each patch has a
different Cc: list. The "git send-email --help" command suggests that
this cmdline should do it. But the cover letter goes just to the address
listed in --to=:

env TMPDIR=/dev/shm LC_ALL=C git send-email -M --stat --annotate \
        --cover-letter --cc-cover --to=$address \
        $base..$head

Thanks,

Olaf
