From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Modify mingw_main() workaround to avoid link errors
Date: Tue, 29 Jul 2008 06:46:59 +0200
Message-ID: <B6158330-640B-4CA3-8589-310FA8EA6CC9@zib.de>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de> <1217104655.488b8b0f5ca48@webmail.nextra.at> <4CCD1862-48FB-412B-80B6-E1B822BF3A87@zib.de> <1217186640.488ccb50a934a@webmail.nextra.at>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Jul 29 06:48:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNh84-00063A-BT
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 06:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbYG2ErH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 00:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbYG2ErH
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 00:47:07 -0400
Received: from mailer.zib.de ([130.73.108.11]:32793 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbYG2ErG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 00:47:06 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6T4kf02023784;
	Tue, 29 Jul 2008 06:46:46 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db9068d.pool.einsundeins.de [77.185.6.141])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6T4kahr018889
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 29 Jul 2008 06:46:37 +0200 (MEST)
In-Reply-To: <1217186640.488ccb50a934a@webmail.nextra.at>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90563>


On Jul 27, 2008, at 9:24 PM, Johannes Sixt wrote:

> Zitat von Steffen Prohaska <prohaska@zib.de>:
>
>>
>> On Jul 26, 2008, at 10:37 PM, Johannes Sixt wrote:
>>
>>> Zitat von Steffen Prohaska <prohaska@zib.de>:
>>>> With MinGW's
>>>>
>>>>  gcc.exe (GCC) 3.4.5 (mingw special)
>>>>  GNU ld version 2.17.50 20060824
>>>>
>>>> the old define caused link errors:
>>>>
>>>>  git.o: In function `main':
>>>>  C:/msysgit/git/git.c:500: undefined reference to `mingw_main'
>>>>  collect2: ld returned 1 exit status
>>>>
>>>> The modified define works.
>>>
>>> I have the same tools, but not this error. ???
>>
>> I cleaned my work tree and built several times but did not
>> find out what exactly is causing the error.  So I came up
>> with the modified define, which declares the static
>> mingw_main in global scope.  I have no clue why I see the
>> error that you don't have.
>
> Neither do I. But a strange line number you have there. In 01d9b2d  
> (from
> mingw.git) I have 'exit(1)' in line 500 of git.c.

I have the same in line 500.  I am still wondering what this could
mean.  But I do not yet now :-(

	Steffen
