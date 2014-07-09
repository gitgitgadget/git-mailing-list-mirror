From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 0/2] always run all lint targets when running the test
 suite
Date: Wed, 09 Jul 2014 21:33:28 +0200
Message-ID: <53BD9908.1060807@web.de>
References: <53B5D6FE.2090700@web.de> <53B5D76D.1090509@web.de> <xmqq38eddolk.fsf@gitster.dls.corp.google.com> <53BC4569.3020907@web.de> <CAPc5daUXZNB=2X8zsrhs9=Z-nV1o1v7KWGydAj6UmBk23UBEEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 21:34:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4xdK-0000Ob-BW
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 21:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbaGITdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 15:33:54 -0400
Received: from mout.web.de ([212.227.15.4]:58082 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932446AbaGITdr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 15:33:47 -0400
Received: from [192.168.178.41] ([84.132.188.65]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MOzrj-1Wzixi25P5-006QaN; Wed, 09 Jul 2014 21:33:29
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAPc5daUXZNB=2X8zsrhs9=Z-nV1o1v7KWGydAj6UmBk23UBEEw@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:yCnF2sUBAFKI3guXLgFtQK+njpBjexcE7F+/GPtBK3bruQmamus
 2NptY8MD3CJav631y8QxMH3JVm+kUyCYYJ0uTNainEtogfRgPzMaGFgjY9e23Z7+7/nVt/8
 /4M2gexqyXgIg2pl5rBuoNtGgMh4L16qSxSJEVit9Uey7yP/QaMRmyUMig7nD56IZ1Qh1d8
 gc87qUNdWiQ2Uszzz08Eg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253141>

Am 09.07.2014 07:42, schrieb Junio C Hamano:
> On Tue, Jul 8, 2014 at 12:24 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>
>> Am 07.07.2014 20:13, schrieb Junio C Hamano:
>>>
>>> So I am not very enthusiastic to see this change myself.
>>
>> Ok, I understand we do not want to lightly risk false positives. I
>> just noticed that I accidentally forgot to sign off this series, so
>> I'd resend just the first patch with a proper SOB, ok?
> 
> 
> Nah, let's do both and how it plays out. My not being very enthusiastic
> myself does not necessarily mean that it is bad for the project. Maybe
> most people like it and if I cannot bear with it I can always turn it off
> myself for my environment.
> 
> I just have a strange feeling that we may be seeing some twisted shell
> script updates and when the author gets asked why it was written in
> such a strange way, the answer might turn out to be "just to work around
> the false positive from the test-lint", which I would not want to see.

Me neither. But until then it might well be that the benefit of having
this test on by default outweighs this potential problem. It would have
surely detected my fingers typing "echo -n" without my brain being alert
enough to catch this portability issue ;-)

This is the updated version with proper SOBs and an updated commit message
for 2/2 which is trying to sum up the considerations raised in this thread.


Jens Lehmann (2):
  t/Makefile: check helper scripts for non-portable shell commands too
  t/Makefile: always test all lint targets when running tests

 t/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.0.1.476.gf051ede
