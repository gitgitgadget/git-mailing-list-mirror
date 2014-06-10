From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] t5551: fix the 50,000 tag test
Date: Tue, 10 Jun 2014 05:45:12 +0200
Message-ID: <53967F48.1080103@web.de>
References: <5390E2D5.9070000@web.de> <xmqqr42xevwi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 10 05:45:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuD0B-0006fS-J5
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 05:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933801AbaFJDpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 23:45:31 -0400
Received: from mout.web.de ([212.227.15.14]:59768 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933775AbaFJDpb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 23:45:31 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MEEMy-1X0kS12f2e-00FSN8; Tue, 10 Jun 2014 05:45:13
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqqr42xevwi.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:ia2M/RPzp/wgwPMKCuCULMAnVzYKdNqTMj0SXRxB5By9g1U855T
 DoPJCbmLFgbg/Xn64hO/wA67tSHjepj5r93EhM6x7xJeB53dZniejptyTPhuVBl3Bqo3OLM
 LaQly6XfbBKi6jlTYOcYn4dHdga9D4HIu1md2qrI8HsSnKTCJMnWbxxFppI7al5mwbFGIDC
 pC2EQltO7c0JqK7KnKTkA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251154>

On 2014-06-09 21.16, Junio C Hamano wrote:

>> Since the day "git clone" printed "Cloning into 'too-many-refs'" to stderr,
> 
> Thanks.  It is 68b939b2 (clone: send diagnostic messages to stderr,
> 2013-09-18); before it we showed the message to the standard output
> stream instead.
> 
> Will queue.
Thanks for digging, as we now know better:
do you want to squeeze in someting like this:

s/Since the day/Since commit 5e2c7cd2/ 
