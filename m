From: Christian Soltenborn <christian@soltenborn.de>
Subject: Re: Git crash on different versions, including current
Date: Tue, 1 Sep 2015 22:32:04 +0200
Message-ID: <55E60B44.1070407@soltenborn.de>
References: <55E17049.8030706@soltenborn.de>
 <77acde26d3e0af558670ce430f24e21c@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 01 22:33:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWsEn-0007wT-SR
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 22:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbbIAUc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 16:32:58 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:34613 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbbIAUc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 16:32:57 -0400
Received: from [95.223.81.151] (helo=[192.168.1.5])
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.84)
	(envelope-from <christian@soltenborn.de>)
	id 1ZWsCx-0002U9-2m; Tue, 01 Sep 2015 22:31:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <77acde26d3e0af558670ce430f24e21c@www.dscho.org>
X-Df-Sender: Y2hyaXN0aWFuQHNvbHRlbmJvcm4uZGU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277040>

Hi Johannes,

> If you copy the entire `GoogleTestExtension` folder somewhere else,
does the crash happen there, still? Can you share a .zip of this folder?
Ciao, Johannes

I just unzipped the folder to C: and tried again, and it indeed still
crashes. Which is probably good news, because it shouldn't be too hard
for you guys to reproduce the issue :-)

I will upload the zip file in a minute and drop you a private email -
it's not exactly secret stuff, but I feel better this way. Feel free to
share the zip with other git developers, but please don't make it
publicly available somewhere. Thanks...

Final note: My workaround was to move the gtest folder somewhere else,
commit the outgoing single "gtest deleted" dir, move the dir back to its
original place, add all (which worked fine) and finally committed.

All the best,
Christian


-- 
H.L. Mencken: "Say what you will about the Ten Commandments, you must
always come back to the pleasant fact that there are only ten of them."
