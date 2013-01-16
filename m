From: Max Horn <max@quendi.de>
Subject: Re: [PATCH] fix some clang warnings
Date: Wed, 16 Jan 2013 18:26:35 +0100
Message-ID: <7FDA1B56-731E-4BA2-8FE5-196B965FFFDB@quendi.de>
References: <1358348003-11130-1-git-send-email-max@quendi.de> <20130116160410.GC22400@sigill.intra.peff.net> <7vk3rdxe5y.fsf@alter.siamese.dyndns.org> <CALWbr2z4TiynwOR3Lk4005dbZaLtcHK3J01ZF73wp8Q7Rm6YBA@mail.gmail.com> <20130116171809.GA2476@farnsworth.metanate.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 16 18:27:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvWlY-0007Fq-4K
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 18:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289Ab3APR0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 12:26:47 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:53666 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756114Ab3APR0r (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 12:26:47 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TvWl2-0004ti-4W; Wed, 16 Jan 2013 18:26:36 +0100
In-Reply-To: <20130116171809.GA2476@farnsworth.metanate.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1358357206;10fd4354;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213775>


On 16.01.2013, at 18:18, John Keeping wrote:

> On Wed, Jan 16, 2013 at 06:12:57PM +0100, Antoine Pelisse wrote:
>> FWIW, I also happen to have the warning:
>> 
>> advice.c:69:2: warning: expression result unused [-Wunused-value]
>>        error("'%s' is not possible because you have unmerged files.", me);
>>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./git-compat-util.h:314:55: note: expanded from:
>> #define error(fmt, ...) (error((fmt), ##__VA_ARGS__), -1)
>>                                                      ^~
>> 
>> with clang: Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final)
>> (based on LLVM 3.0)
> 
> I have the same output with:
> 
> clang version 3.2 (tags/RELEASE_32/final)

Sorry for not being more specific in my message. I have this with 

Apple clang version 4.1 (tags/Apple/clang-421.11.66) (based on LLVM 3.1svn)


Max
