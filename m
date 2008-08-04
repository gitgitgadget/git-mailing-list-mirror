From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: linking libgit.a in C++ projects
Date: Mon, 04 Aug 2008 11:57:22 +0300
Message-ID: <4896C472.9070002@panasas.com>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com> <4891B872.3040707@panasas.com> <20080731183732.GA7598@steel.home> <32541b130807311155v50ee6ddaha1bba2f56e9bd61d@mail.gmail.com> <20080803201211.GA11121@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>, cte <cestreich@gmail.com>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 10:59:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPvuA-0004rd-Sb
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 10:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbYHDI5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 04:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbYHDI5n
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 04:57:43 -0400
Received: from gw-colo-pa.panasas.com ([66.238.117.130]:13318 "EHLO
	natasha.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752635AbYHDI5m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 04:57:42 -0400
Received: from daytona.int.panasas.com (daytona.int.panasas.com [172.17.28.41])
	by natasha.panasas.com (8.13.1/8.13.1) with ESMTP id m748veMF006464;
	Mon, 4 Aug 2008 04:57:40 -0400
Received: from bh-buildlin2.bhalevy.com ([172.17.28.106]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 4 Aug 2008 04:56:43 -0400
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080803201211.GA11121@steel.home>
X-OriginalArrivalTime: 04 Aug 2008 08:56:44.0210 (UTC) FILETIME=[04E53920:01C8F610]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91331>

Alex Riesen wrote:
> Avery Pennarun, Thu, Jul 31, 2008 20:55:26 +0200:
>> On 7/31/08, Alex Riesen <raa.lkml@gmail.com> wrote:
>>> Boaz Harrosh, Thu, Jul 31, 2008 15:04:50 +0200:
>>>> Produce a C file and header that defines some stable API to your
>>>  > GUI application, that does not expose any git internal headers.
>>>  > Then compile that, say git_api.c, with C compiler in Makefile
>>>  > and extern "C" link that file to your C++ application. This will
>>>  > completely insulate you from any git code.
>>>
>>> no, it wont. He still have to resolve name conflicts at the link time.
>> Language keywords (as opposed to function names) like 'new' and
>> 'typename' are definitely not exported to the object files.  Moreover,
>> function parameter names aren't either.
>>
> 
> Didn't mean them. Meant the globally visible names. libgit does not
> use a prefix for its exported symbols. They will clash with the
> symbols of the programs it is linked to.
> 

But that's a problem for C programs, C++ programs will not have that 
problem, right? ;-)

With C programs these git symbols can be avoided.

Boaz
