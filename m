From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 01/16] bisect: write about `bisect next` in documentation
Date: Sat, 27 Feb 2016 14:45:23 +0100
Message-ID: <56D1A873.1090709@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
 <1456452282-10325-2-git-send-email-s-beyer@gmx.net>
 <xmqqoab3jokp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 14:48:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZfEE-0000Is-3t
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 14:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756446AbcB0Npd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 08:45:33 -0500
Received: from mout.gmx.net ([212.227.17.20]:60127 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756412AbcB0Npc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 08:45:32 -0500
Received: from [192.168.178.43] ([92.76.250.14]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0MCtLD-1aihrK2jUx-009gBH; Sat, 27 Feb 2016 14:45:25
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <xmqqoab3jokp.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:ltDI2tpv8SUWbf3GDLstTQxJC9KX5SQhd/PcONMTxpJVZ0IDmxW
 +0yeVa0nIcN6BlTzJyih3qNPa/AV/+ouc3zgDgDp+i8up9g6piOQdywvclNPWVl8UlzTuQW
 jB1Rza6ST1dsLWBdW7UurPNNTnmgiqSI2cnRkhM686ONv8IksincFx3mcQlU/aIfSHQjnmt
 DRyhnsu+TbKGsGaITbZug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E0ygZSDGyhI=:YnyEIb9Me3m3AyevupXUq6
 wBwuD+jIcdZVpPUXtA5LU1BIYosk/5BN4GPjZOnVdSy619Sw8I6LDswsLzffXVUTdOCncj0pH
 GOJt7DauuLMsGbaYdxqABLF+vTRgdaGomNq1Xz0Sb6xgNpqxckA6iPEuJTZmoADvAv6/Op/5g
 rf0wdcPXCIDIq2HekWu+pyR2P2cwcJSP+spZls/4vq7SB1Aln0j2nljMVZZOaYl7Yzi9li4Aj
 GQb/HTqR0mOVfHMSum5ZYXoLkqnMwPTEIKvChUFhDLy/nc69iMuHbpEUiy+alhwSaJss671iG
 1PlwUqghCcwqeewyoSCa47ofsUjd/GuOpnpjsA58y9IdWlV43MSphlqlf/+nipItauwGdkxKa
 rztFgPHMSt1ncUa+YkntMUHpHXwPGxBgapEQal7JxXclJdOCGlaR/yog0S5mrf5QZTfHF5SDw
 assVdEuF0zeFuHEbUFI8Xzkr5fn2v+VFrIKpflikknLLIX1/Ssg8xSg7Pds4geZOt7C8zh77H
 9GQsdZmcDbkyCKm8y9kc3v6XkNxv2gyKBR/SgQYlKr5U243SeC757/pGeXO0m78PkX/b2+gEC
 EsuaJauBnjeLQG3+5ZuMkqHZoVJ02bHCYbn1cdw8A9ZUFGlqGVwOfwJFW4keKCU242XQtNLlx
 QfCoYeJhfnGcpi4EOr4+/tL4hMNfGvL8JKvWNYH7rUqH+o4RBtwztHlyxMD77oVHu3nNqfQwF
 a0zOX+phRxujG1rUPQFNTQ0HZZF08d5AeOmsLWWzSygDuGPC/zWIrwml0U6vnHgt+84w8rwN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287699>

Hi,

On 02/26/2016 07:47 PM, Junio C Hamano wrote:
> But I wonder if it is safe and sane to encourage "checking out other
> branches during a bisect session." as you cannot tell what other
> crazy things they will do while on "other branches".  I do not think
> we even try to (and I do not think we should) handle a case where
> the user tries to merge another branch, sees conflicts and says
> "bisect next" without cleaning up, for example.

I rephrase it as follows to not encourage checking out another branch
(or commit ;]) but to mention that it works to get back if someone
accidentally did it.

--8<--8<--8<--

Bisect next
~~~~~~~~~~~

In case you have marked a commit as bad but you do not know a good
commit, you do not have to crawl through the commit history yourself to
find a good commit. Simply issue the command:

------------
$ git bisect next
------------

This command is also handy when you accidentally checked out another
commit during a bisection. It computes the commit for the bisection
and checks it out again.

-->8-->8-->8--

Is that better?

Thanks,
Stephan
