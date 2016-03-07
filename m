From: Olga Pshenichnikova <olga@ip-5.ru>
Subject: How to include just some subdirectory excluding all envelop tree
Date: Mon, 7 Mar 2016 22:01:52 +0300
Message-ID: <56DDD020.2050101@ip-5.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 20:02:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad0Po-00058M-PV
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 20:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbcCGTB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 14:01:57 -0500
Received: from [178.62.228.239] ([178.62.228.239]:59396 "EHLO server.ip-5.ru"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752248AbcCGTB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 14:01:56 -0500
Received: from [10.143.26.93] (unknown [31.40.132.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by server.ip-5.ru (Postfix) with ESMTPSA id C856610165A
	for <git@vger.kernel.org>; Mon,  7 Mar 2016 22:01:53 +0300 (MSK)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288395>

I have some tree structure:

/a
/a/a
/a/b
..
/a/z
/b
.. (thousands of folders)
/z

How can I control just /a/a folder?
What exclude file should be?

The way we use now is:

/a/*
/b/
.. (thousands of folders)
/z/
!/a/a

But it is very not nice looking and hard for maintenance...
