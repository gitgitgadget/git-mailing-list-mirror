From: Sven Strickroth <sven@cs-ware.de>
Subject: RFC: git status --amend
Date: Tue, 31 Mar 2015 16:59:27 +0200
Message-ID: <551AB64F.4030400@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 17:05:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycxjb-00037P-PJ
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 17:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbbCaPFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 11:05:38 -0400
Received: from srv1.79p.de ([213.239.234.118]:54738 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbbCaPFh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 11:05:37 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Mar 2015 11:05:36 EDT
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:46:830:9800:b405:1105:c2ef:4dc6] (p2003004608309800B4051105C2EF4DC6.dip0.t-ipconnect.de [IPv6:2003:46:830:9800:b405:1105:c2ef:4dc6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id 7992522008D;
	Tue, 31 Mar 2015 16:59:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs-ware.de;
	s=mail2014b; t=1427813967;
	bh=5FPRN8zlPZDXlp0XYSEWT4ZQGIqUuhZ5xfNE9f+ANxc=;
	h=Date:From:To:Subject;
	b=1lin6KyjvAdFRoF5Rxvke0itl5I/uDBMXL/4SBJH3OZj/4nDh0gboIfECaGaVuae/
	 oqt0cZ65QYUz54pJebQFT7l58TjYDVycZpHpr4qSjDde7mmKWdZ4q+LUPXY7GuGOMw
	 GOe4Ks77ny13ib/kb5nY5mWm4Q/pxzBxY58eZnsZYaAjWm7sOA9nXfP/PE1TmuqLrq
	 1ZOuthk/tMkg8NCmrAqAy2nlki+OsOBEZ0nAXZ61DkO/KJM3U9yjrk5uIjmO+Ty7br
	 BXBmH+JfIuT9NeBVWkeRsb5Kk3803DyK3OlO7BRMD7k/eZtGPWalPgtbW2/gZds4+j
	 uFbKMAMxGwZ8g==
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266526>

Hi,

for frontends or scripts it would be helpful to be able to use "git
status" for getting the repository status compared to HEAD~1 instead of
only HEAD (as provided by "git commit --amend" in the pre-filled commit
message).

Thus, I'm suggesting to add a "--amend" parameter (or a parameter with a
better naming) to "git status".

What do you think of this idea?

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
