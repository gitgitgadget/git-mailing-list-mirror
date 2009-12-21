From: =?UTF-8?B?R3VzdGF2IEjDpWxsYmVyZw==?= <gustav@virtutech.com>
Subject: Re: [RFC PATCH] Record a single transaction for conflicting push
 	operations
Date: Mon, 21 Dec 2009 15:31:23 +0100
Message-ID: <4B2F86BB.9090104@virtutech.com>
References: <20091217232212.4869.43002.stgit@toshiba-laptop>	 <b8197bcb0912180123l4657839ctc121636af3724bee@mail.gmail.com>	 <b0943d9e0912180749ga8857d9j975e119937db9674@mail.gmail.com>	 <b8197bcb0912191550u300a9c20o351eba66c85292bb@mail.gmail.com>	 <b0943d9e0912201521k73bdcb5fl333e845028954050@mail.gmail.com>	 <b8197bcb0912202308p296207av416cd5590a11251b@mail.gmail.com>	 <b0943d9e0912210348o37b71935x5fad4f1a4be4b70@mail.gmail.com> <b8197bcb0912210548q67c1da4bhe023bed2811394d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 15:51:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMjbm-0003tq-D1
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 15:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbZLUOvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 09:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbZLUOvc
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 09:51:32 -0500
Received: from dns.vtab.com ([62.20.90.195]:35194 "EHLO oden.vtab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbZLUOvc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 09:51:32 -0500
X-Greylist: delayed 1203 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Dec 2009 09:51:31 EST
Received: from oden.vtab.com (oden.vtab.com [127.0.0.1])
	by oden.vtab.com (Postfix) with ESMTP id 3A36026EF73;
	Mon, 21 Dec 2009 15:31:24 +0100 (CET)
Received: from lux.e.vtech (unknown [62.20.90.206])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by oden.vtab.com (Postfix) with ESMTP id 0ED2026EF45;
	Mon, 21 Dec 2009 15:31:24 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Thunderbird/3.0
In-Reply-To: <b8197bcb0912210548q67c1da4bhe023bed2811394d4@mail.gmail.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135557>

On 2009-12-21 14:48, Karl Wiberg wrote:
> I've seen more than one complaint that the current behavior is
> confusing even if we don't count the bug, so I thought this was part
> of the motivation.

I don't know if this would be better than the other suggested solutions, 
but if "stg log" would clearly identify multi-stage entries as such, the 
current confusion would probably mostly go away.

Currently this is done reasonably well for make_temp_patch(), which says 
"refresh (create temporary patch)" in the log, but I think this could be 
taken further.

For example, if such annotations said "foo: stage N" or similar, 
indicating that this was the Nth step in the "foo" command (think 
"rebase" or whatever), it would be good enough for me least.

- Gustav
