From: bob <kranki@mac.com>
Subject: Re: git packs
Date: Sat, 10 Nov 2007 13:01:46 -0500
Message-ID: <134659C4-BA10-4B9E-9C64-2754A90D93F8@mac.com>
References: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com> <00593593-E943-4DA0-AA9B-FDBB866E7EFB@mac.com> <20071110174559.GA2200@old.davidb.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 19:03:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqufU-0000Xn-9j
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 19:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbXKJSB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 13:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbXKJSB5
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 13:01:57 -0500
Received: from smtpoutm.mac.com ([17.148.16.68]:50981 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbXKJSB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 13:01:56 -0500
Received: from mac.com (asmtp008-s [10.150.69.71])
	by smtpoutm.mac.com (Xserve/smtpout005/MantshX 4.0) with ESMTP id lAAI1u3t007381
	for <git@vger.kernel.org>; Sat, 10 Nov 2007 10:01:56 -0800 (PST)
Received: from [192.168.2.23] (c-66-176-54-4.hsd1.fl.comcast.net [66.176.54.4])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp008/MantshX 4.0) with ESMTP id lAAI1s6H029443
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sat, 10 Nov 2007 10:01:55 -0800 (PST)
In-Reply-To: <20071110174559.GA2200@old.davidb.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64363>

It is fairly disappointing as far as indicating the problem.  Here is  
the entire report since it was so short.


============ Begin =================
Process:         git [82703]
Path:            git
Identifier:      git
Version:         ??? (???)
Code Type:       X86-64 (Native)
Parent Process:  bash [261]

Date/Time:       2007-11-10 11:23:33.976 -0500
OS Version:      Mac OS X 10.5 (9A581)
Report Version:  6

Exception Type:  EXC_BAD_ACCESS (SIGBUS)
Exception Codes: KERN_PROTECTION_FAILURE at 0x00007fff5fc00000
Crashed Thread:  Unknown

Error Formulating Crash Report:
*** -[NSCFDictionary setObject:forKey:]: attempt to insert nil value  
(key: VMUSignaturePath)
0x9501626b
0x9586009b
0x9501604b
0x9501608a
0x900d65e8
0x00078308
0x00087eb8
0x0008800e
0x000850a2
0x00002d90
0x000093be
0x0000b57c
0x0000b0c9
0x919f8793
0x0000a7d0
0x919cc075
0x919cbf32

Backtrace not available

Unknown thread crashed with X86 Thread State (64-bit):
   rax: 0x000000000000003b  rbx: 0x00000001191c9338  rcx:  
0x0000000000000392  rdx: 0x00000000aff4bc3b
   rdi: 0x00007fff5fc00000  rsi: 0x0000000040000003  rbp:  
0x00007fff5fbff180  rsp: 0x00007fff5fbff160
    r8: 0x0000000000000000   r9: 0x058487f0858487f0  r10:  
0x000000002cb27436  r11: 0x000000000ee2afe3
   r12: 0x00000000181c84c0  r13: 0x00007fff5fbff1a0  r14:  
0x000000010000000c  r15: 0x0000000101000000
   rip: 0x00007fff80543ca5  rfl: 0x0000000000010202  cr2:  
0x00007fff5fc00000

Binary images description not available
============ end =================

Maybe there was another option to specifiy other than "-m64 -arch  
x86_64".


On Nov 10, 2007, at 12:45 PM, David Brown wrote:

> On Sat, Nov 10, 2007 at 12:40:16PM -0500, bob wrote:
>
>> I am guessing that the "Bus error" is an Apple
>> problem and it did produce a crashreport.  So,
>> I am going to submit it to Apple since it is easily
>> reproducible.
>
> The crash report is probably not all that useful to Apple, since it  
> occurs
> in a program you have built.  Perhaps you should send the stack  
> trace from
> the crash report here and people might have some ideas about what  
> might be
> the problem.
>
> David
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
