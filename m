From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH RFC] CYGWIN: avoid implicit declaration warning
Date: Mon, 24 Nov 2014 17:00:56 +0100
Message-ID: <54735638.9000502@web.de>
References: <5471EC26.3040705@web.de> <5472159B.4060905@ramsay1.demon.co.uk> <xmqqegstychq.fsf@gitster.dls.corp.google.com> <54726A8C.4040600@ramsay1.demon.co.uk> <5472DC24.9010008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 17:01:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xsw4a-000744-Pf
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 17:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202AbaKXQBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 11:01:03 -0500
Received: from mout.web.de ([212.227.17.12]:53419 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753974AbaKXQBC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 11:01:02 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MSai0-1XTbBN0gBI-00RaOl; Mon, 24 Nov 2014 17:00:57
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <5472DC24.9010008@web.de>
X-Provags-ID: V03:K0:xMTOapz1QaoPARqqRVdfpuGEsFxgFT6J1GklXWNpLq9jA7bAfVH
 kEK/oeAgYS7w4QOEi9m9AaE3TeV9inziZVce5l3cMIpmHjP/UfuiBissk47We3AMA5QrA8B
 h78uoENeB5+7hPiA3a1EUF2F1DoH8473SH3F4D0se1pIC6iskI6TEYS4R0n7GTgG45FoKom
 eN35KRVg+D0ymGDvncz6g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260131>

> 
> It depends what we mean with "old":
> cygwin 1.5 is old, and I lost my test installation this summer:
> One netbook was converted from XP to Linux, the other machine needs to be
> re-installed and CYGWIN 1.5 is no longer available for download.
> 
> I can confirm that Ramsays patch works with CYGWIN 1.7 32 Bit.
Another update:
The test suite passes, except
t5000 - not ok 48 - archive and :(glob)

fatal: pathspec '*.abc' did not match any files
