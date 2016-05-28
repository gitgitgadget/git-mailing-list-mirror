From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v8 0/9] connect: various cleanups
Date: Sat, 28 May 2016 10:17:19 +0200
Message-ID: <5ba52c0a-2b8f-91af-d823-9519cdb9f67c@web.de>
References: <20160527022756.22904-1-mh@glandium.org>
 <a6f4bf06-a52b-dcdf-9407-0c03b8b1dfe1@web.de>
 <20160527215943.GA21018@glandium.org>
 <5071966e-6bce-fa91-8837-81cb3c9157f7@web.de>
 <20160528053354.GA3860@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat May 28 10:17:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6ZRI-0007TY-6s
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 10:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbcE1IRk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 May 2016 04:17:40 -0400
Received: from mout.web.de ([212.227.15.4]:55459 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558AbcE1IRi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 04:17:38 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0LetUF-1bsIzV2LZ1-00qhlw; Sat, 28 May 2016 10:17:22
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.0
In-Reply-To: <20160528053354.GA3860@glandium.org>
X-Provags-ID: V03:K0:iJ2Y5WZXReyowHFBtG59Zneq9/qstLLgwy6sQnc6WLZjJZw0qmI
 rsRyOP8u0rQnYVG6jUw9oS9tYhtywlUw/g/aESLPlc8YwHVUsPp3hXuyj9PEldhdTsA0gzC
 XbaXfmllDva4uzSuS5xqcIVIN9QCgl2BSBEdmptNhT2awdcXyWtHQmYHiKrEk31xpXziOGP
 zc2PRDGc5qLd4oFCcaA7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qnl5WT8pSvE=:J/aFIWSTCaLKR76QLORqLY
 zRCl40otONP6Rh4A20X0mSFYaB4+94U/KxqxT0xH6v2W4VP2bUnsYZTA04/6pkHWiz/faElGF
 STUDq98Ey+eA6EwR5LafgGluLHVWYNm9JP/hf/At6Qh+iul3LGO8VEvg79JnbHG1wBWakyfsm
 i+6GYu9QNs+EGsq2A9EC5xZqyLjWtUGeOXrDGCPJY4HYCOMGLZRFTRNLT+SqNOjZRPIgSQ6hH
 iKtbhMYkXjVttmu3dI/IGESzm0Qqx56Y3ixWyvIUNHXubkqIPQN6XNOoZFjh7Ar6ocVxJ0hgV
 Bq1M/hPjZlvyB+hFAHjh7lYPB1q3q+8hxxEw0dsjLGtRndlVIMRXTKop6qwXrGVWiUs/lLBUT
 AyYLF+cNz96HZLzyLzU4aWii+/wqlAr72I/M/80GufQV9z2AkMgkBEJjsfdTz7mPFCzU5qiA8
 kOCxYwB/1KE9y4WQD7rcRNqSo6+zyMhzPTmynvhhXyPqyPG4my9TGkJYTlFGQx0IHatp9Uy2O
 zlj/N56/k7Mu2WO6zYZWuNo/IrWemR7fJRPGY4GljVnbZjvkQHs6dhfIltm3IMzvUyoPDO3Xv
 Bmzgrxn5wDVKczxgmqAqoW2FYrvSZj5ahjPzwoxYk9VWHhH/2oqwdw8wHmtDjX19pdGpSZtlN
 78WrnOByoEPyLlBvmtQa9c37J/e6iPCFOaTC9LlhHdcxyz3HDJciygidAJ0RadJyNSVmelt1W
 WIcnTQqAg7i4Fy3F7SIMImnjP5lZFVHSR5KS8T+XgO+y80N+gh21RMxxksLFLhbxUzdYZWOA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295805>

On 28.05.16 07:33, Mike Hommey wrote:
> On Sat, May 28, 2016 at 07:02:01AM +0200, Torsten B=F6gershausen wrot=
e:
>> On 27.05.16 23:59, Mike Hommey wrote:
>>> On Fri, May 27, 2016 at 04:24:20PM +0200, Torsten B=F6gershausen wr=
ote:
>>>> On 27.05.16 04:27, Mike Hommey wrote:
>>>>> Changes from v7:
>>>>> - Fixed comments.
>>>>>
>>>>> Mike Hommey (9):
>> All in all, a great improvement.
>> 2 things left.
>> - The comment about [] is now stale, isn't it ?
> No, it's still valid at this point, that's what the 2nd argument to
> host_end (0) does.
>
> Mike

The protocol (specific) code doesn't do this anymore,=20
because that is now common to all protocols.


       /*
        * Don't do destructive transforms now, the
        * '[]' unwrapping is done in get_host_and_port()
        */
