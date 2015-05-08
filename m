From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 11/12] t5524: test --log=1 limits shortlog length
Date: Fri, 08 May 2015 19:19:54 +0200
Message-ID: <554CF03A.7030503@kdbg.org>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com> <1430988248-18285-12-git-send-email-pyokagan@gmail.com> <05adfac12cb9a7ad183281974d991e00@www.dscho.org> <CACRoPnRfqQMRJ5N=oL84SMw=FC=Eg-Co-De_9E9cpWCaaSZAxw@mail.gmail.com> <554BB93A.3090000@kdbg.org> <8e34bc9ea27d147f86de0cf60141687a@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 08 19:20:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqlwu-00032u-Gl
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 19:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbbEHRU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 13:20:26 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:57118 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932299AbbEHRUC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 13:20:02 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.107])
	by bsmtp4.bon.at (Postfix) with ESMTPS id 3ljz1X2d04z5tml
	for <git@vger.kernel.org>; Fri,  8 May 2015 19:20:00 +0200 (CEST)
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3ljz1R5Cszz5tlB;
	Fri,  8 May 2015 19:19:55 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id B3FAE5250;
	Fri,  8 May 2015 19:19:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <8e34bc9ea27d147f86de0cf60141687a@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268628>

Am 08.05.2015 um 12:07 schrieb Johannes Schindelin:
> On 2015-05-07 21:12, Johannes Sixt wrote:
>> Nope, it's not better. test_must_fail is explicitly only for git
>> invocations. We do not expect 'grep' to segfault or something.
>>
>> Cf. eg.
>> http://thread.gmane.org/gmane.comp.version-control.git/258725/focus=258752
>
> That link leads to a patch that changes `! grep` to a `test_must_fail
> grep` and is not contested, at least not in the thread visible on
> GMane. Would you have a link with a more convincing argument for me?

Gah! Sorry for sending you in circles. I see that others have brought 
forward sufficient arguments. Just to get my own argument straight, here 
is the message I wanted to direct you to:

http://thread.gmane.org/gmane.comp.version-control.git/258725/focus=258792

-- Hannes
