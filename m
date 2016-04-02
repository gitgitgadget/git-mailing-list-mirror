From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/4] config --show-origin: report paths with forward
 slashes
Date: Sat, 2 Apr 2016 20:51:33 +0200
Message-ID: <570014B5.4030203@kdbg.org>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
 <8beb1c208e33e1de8f272caa22fb7a0b662ca4cc.1458668543.git.johannes.schindelin@gmx.de>
 <56F8E435.3020304@kdbg.org> <alpine.DEB.2.20.1603281712470.4690@virtualbox>
 <56FAD506.4050701@kdbg.org> <56FB6989.8070906@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 02 20:51:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amQe6-0006T5-LJ
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 20:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbcDBSvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 14:51:37 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:43655 "EHLO bsmtp2.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbcDBSvh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 14:51:37 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 3qcnQt1JJnz5tlG;
	Sat,  2 Apr 2016 20:51:33 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 714345220;
	Sat,  2 Apr 2016 20:51:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <56FB6989.8070906@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290605>

Am 30.03.2016 um 07:52 schrieb Johannes Sixt:
> Am 29.03.2016 um 21:18 schrieb Johannes Sixt:
>> It does pass. The reason is that pwd -W generates forward slashes.
>
> It just occurred to me that we might be observing a difference in
> behavior of pwd -W between the modern MSYS2 bash and the old MSYS1 bash
> that I am using.

No that isn't it. Both versions produce forward slashes. Puzzled...

-- Hannes
