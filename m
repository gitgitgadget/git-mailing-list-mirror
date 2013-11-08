From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 0/5] fix up 'jk/pack-bitmap' branch
Date: Fri, 08 Nov 2013 18:10:30 +0100
Message-ID: <527D1B06.3090807@web.de>
References: <527C0CEA.4020705@ramsay1.demon.co.uk> <20131107221944.GA19238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Vicent Marti <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Nov 08 18:10:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VepZt-0001P2-9K
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 18:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757686Ab3KHRKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 12:10:33 -0500
Received: from mout.web.de ([212.227.15.4]:51791 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757447Ab3KHRKc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 12:10:32 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0M1o86-1VuyaL0wiw-00tmRh for <git@vger.kernel.org>;
 Fri, 08 Nov 2013 18:10:31 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131107221944.GA19238@sigill.intra.peff.net>
X-Provags-ID: V03:K0:dibJl8yUWJ8bKC5LDVoeIb716xwE+JH/zWJN1yeSPR+YYFyMfNI
 QVe79QWMc5hzXDzj7ybcBDBMAzpSg5h7llvfTls0gCROUVZZgGWqnGw2dtU2p8lT4kvSqQ+
 DxeaQR2If+qYa/09XYra2H9kaC9AeyV/Kqve80zWOFTPuttoOs8tvcYSRUre+j/9sQzCY+G
 r4hCVE07voR4e3AXBzFag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237457>

On 2013-11-07 23.19, Jeff King wrote:
> On Thu, Nov 07, 2013 at 09:58:02PM +0000, Ramsay Jones wrote:
> 
>> These patches fix various errors/warnings on the cygwin, MinGW and
>> msvc builds, provoked by the jk/pack-bitmap branch.
> 
> Thanks. Your timing is impeccable, as I was just sitting down to
> finalize the next re-roll. I'll add these in.
> 
> -Peff

Side question:
Do we have enough test coverage for htonll()/ntohll(),
or do we want do the "module test" which I send a couple of days before ?
/Torsten
