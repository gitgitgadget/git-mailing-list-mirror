From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Deprecation warnings under XCode
Date: Mon, 01 Dec 2014 06:31:46 +0100
Message-ID: <547BFD42.3040104@web.de>
References: <CAO2U3Qg4DVxSk2u1eJwGqYoxVZTbWRV69J9HTo1rnjFCxSyi2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 01 06:33:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvJbl-0005hP-7N
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 06:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbaLAFdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 00:33:04 -0500
Received: from mout.web.de ([212.227.15.3]:60901 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbaLAFdC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 00:33:02 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Lr2I7-1YP8Nl2e8J-00eca5; Mon, 01 Dec 2014 06:32:58
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <CAO2U3Qg4DVxSk2u1eJwGqYoxVZTbWRV69J9HTo1rnjFCxSyi2g@mail.gmail.com>
X-Provags-ID: V03:K0:rnwVmS55IPWzYXuQd/zrfAp5AkMnBO46QP7V0qEEjOLyn2fGzeO
 a0gwZOnE21ggaO+Vixqke4vseLy6K+DD5jfjCZ06ksD8wJa1somG1UanHTOvDikFRbFUApz
 MtfJ0B1DIsv/xtUQyFcVHSxSqmDj9yQZ+vGPlzHfCx/QIctlORl2KGsk+Vh0qaMGZP3VDMX
 wmzIhHYU2pyweF1109AmA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260470>

On 12/01/2014 04:02 AM, Michael Blume wrote:
> I have no idea whether this should concern anyone, but my mac build of git shows
>
>      CC imap-send.o
> imap-send.c:183:36: warning: 'ERR_error_string' is deprecated: first
> deprecated in OS X 10.7 [-Wdeprecated-declarations]
>          fprintf(stderr, "%s: %s\n", func,
> ERR_error_string(ERR_get_error(), NULL));
>                                            ^
[]
Isn't the warning a warning ;-)
I don't see this warnings because my openssl comes from 
/opt/local/include (Mac ports)
Does anybody know which new functions exist in Mac OS X versions >= 10.7  ?
