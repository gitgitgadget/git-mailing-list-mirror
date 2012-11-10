From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: t5801-remote-helpers.sh fails
Date: Sat, 10 Nov 2012 20:20:14 +0100
Message-ID: <509EA8EE.1030908@web.de>
References: <509E5B27.5080808@web.de> <CAMP44s0HtMRaQ91z95cZS73W7tnqYwyKV_2guWJ6u6UP4p5JNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 20:20:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXGbg-0000tQ-Dk
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 20:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524Ab2KJTU1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 14:20:27 -0500
Received: from mout.web.de ([212.227.15.4]:50721 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265Ab2KJTU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 14:20:27 -0500
Received: from wanderer.site ([195.67.191.23]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0Lj2I6-1Su4xy26xy-00cj99; Sat, 10 Nov 2012 20:20:25
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121025 Thunderbird/16.0.2
In-Reply-To: <CAMP44s0HtMRaQ91z95cZS73W7tnqYwyKV_2guWJ6u6UP4p5JNw@mail.gmail.com>
X-Provags-ID: V02:K0:Lq3ZhU2gNSZMI3Zk6Jr9ifCjNGgQEcV4YVc44KxI4gw
 MRMPxv5Kqt7Nm9gtH0Rkz9iiCLQtzLj9yQmKualkIlh42pO6b7
 4WTML7gE6KTr307xO2llhMOuPtU6YY7NSGKUP8RcMvz0Rari3I
 kBPWA1dOEKT9DhDT+BU/ZfxTOkmCNF56luRk8Wof5o9iFA3k40
 BFnUmM0DPm4Ce2pPqWPIg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209297>

On 11/10/2012 08:15 PM, Felipe Contreras wrote:
> Hi,
>
> On Sat, Nov 10, 2012 at 2:48 PM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>
>> on peff/pu t5801 fails, the error is in git-remote-testgit, please s=
ee below.
>>
>> That's on my Mac OS X box.
>>
>> I haven't digged further into the test case, but it looks as if
>> "[-+]A  make NAMEs associative arrays"
>> is not supported on this version of bash.
>> /Torsten
>>
>>
>> /Users/tb/projects/git/git.peff/git-remote-testgit: line 64: declare=
: -A: invalid option
>> declare: usage: declare [-afFirtx] [-p] [name[=3Dvalue] ...]
>> /Users/tb/projects/git/git.peff/git-remote-testgit: line 66: refs/he=
ads/master: division by 0 (error token is "/master")
>> error: fast-export died of signal 13
>> fatal: Error while running fast-export
>
> What is your bash --version?
>
  bash --version
GNU bash, version 3.2.48(1)-release (x86_64-apple-darwin10.0)
Copyright (C) 2007 Free Software Foundation, Inc.

On the other hand, Documentation/CodingGuidelines says:
   - No shell arrays.

Could we use perl to have arrays?

/Torsten
