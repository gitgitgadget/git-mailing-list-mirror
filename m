From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] repack.c: rename and unlink pack file if it exists
Date: Wed, 05 Feb 2014 22:01:16 +0100
Message-ID: <52F2A69C.50000@web.de>
References: <xmqqwqha5twg.fsf@gitster.dls.corp.google.com>	<20140205011632.GA3923@sigill.intra.peff.net>	<xmqq1tzh494e.fsf@gitster.dls.corp.google.com>	<20140205201243.GA16899@sigill.intra.peff.net> <xmqqsirx2teh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	=?ISO-8859-1?Q?Torsten_?= =?ISO-8859-1?Q?B=F6gershausen?= 
	<tboegi@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 05 22:01:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB9bC-00061g-EQ
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 22:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175AbaBEVBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 16:01:24 -0500
Received: from mout.web.de ([212.227.15.4]:51425 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754449AbaBEVBT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 16:01:19 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LpfJW-1VXykl2rJu-00fVQX for <git@vger.kernel.org>;
 Wed, 05 Feb 2014 22:01:17 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqqsirx2teh.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:TjLV3AXpWXC0I6eJzeM+1IK0gdliZof9JDl2ZxmJxL+blgKqDM5
 3oZJgNzDxN9Pkn5o40d4jx75l1MX3FqqAu2gVViFCs1Fq48PBfNrotwITQ9hm5on9WrVwrH
 lbQcpdnf+ey2T+gIQAC2djMnm95i9KeV/K9n5WJDXZHZfZqBfXe/Ff0eVPT9ObKeHBS1MbR
 OuMAji4j1AUvRqznPBppw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241661>

On 2014-02-05 21.31, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> The minimal fix you posted below does make sense to me as a stopgap, and
>> we can look into dropping the code entirely during the next cycle. It
>> would be nice to have a test to cover this case, though.
> 
> Sounds sensible.  Run "repack -a -d" once, and then another while
> forcing it to be single threaded, or something?
I can put a test case on my todo list,
and thanks for the minimal patch.
