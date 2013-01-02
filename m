From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/4] test: Add target test-lint-shell-syntax
Date: Wed, 02 Jan 2013 01:14:11 +0100
Message-ID: <50E37BD3.6060709@web.de>
References: <201301012240.10722.tboegi@web.de> <7v7gnw8slq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 01:14:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqByh-0007ui-Mg
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 01:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348Ab3ABAOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 19:14:21 -0500
Received: from mout.web.de ([212.227.17.11]:61411 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221Ab3ABAOU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 19:14:20 -0500
Received: from [192.168.2.107] ([79.244.173.33]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0M6mL2-1T4wyE0u84-00wqkm; Wed, 02 Jan 2013 01:14:19
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7v7gnw8slq.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:9LbC6q+mduLC7aGRCAuTBXBHbsg0ntk+cQR984+7v4a
 Hqg+T0KHOEAuaFAr7NszSZeMgiQmKEprj/Anadekje1+ukx/lF
 1ssYfRbpsODNnuIYZYc9ID11qQOU7Og0NaLpCh3+MUbAPJ9T2O
 MRiTFBuSiVWKRlR8PE1953NXUb/0VoO0VwghnAo/QvwJ848jVG
 yN3kHNRZSjn9+dZ1Aw6FQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212475>

On 01.01.13 23:07, Junio C Hamano wrote:
[snip]
> What it checks looks like a good start, but the indentation of it
> (and the log message) seems very screwed up.
OK
> I also have to wonder what's the false positive rate of this.  When
> you are preparing a new test, you would ideally want a mode that
> checks only parts that you just added, without seeing noises from
> existing violations and false positives from the part you did not
> touch.  Otherwise, it will be too cumbersome to run for developers,
> and the check mechanism will end up used by nobody.
>
The script found all problems which make the testsuite (unecessary) fail on Mac OS X.

The false positive rate is currently 0% (otherwise I should not have send it to the list)

The suggestion is to run it every time the test suite is run, at the begining.
And it seems to be fast enough:

$ time ./check-non-portable-shell.pl ../../git.master/t/t[0-9]*.sh
real    0m0.263s
user    0m0.239s
sys     0m0.021s

/Torsten
