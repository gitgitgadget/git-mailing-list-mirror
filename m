From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 03/12] struct ref_update: move "have_old" into "flags"
Date: Tue, 17 Feb 2015 15:37:20 +0100
Message-ID: <54E35220.3010302@alum.mit.edu>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>	<1423739543-1025-4-git-send-email-mhagger@alum.mit.edu>	<CAGZ79kYqx8s8Cz29Qn1aBtCnDOkR-Guk4RM-_KQeO+nHWv=r8w@mail.gmail.com> <xmqqsiebrlez.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 15:37:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNjHS-0004GT-Nk
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 15:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbbBQOhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 09:37:38 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61619 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750807AbbBQOhh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 09:37:37 -0500
X-AuditID: 12074413-f79f26d0000030e7-f7-54e35223a82f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id F6.85.12519.32253E45; Tue, 17 Feb 2015 09:37:23 -0500 (EST)
Received: from [192.168.69.130] (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HEbL1h025919
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 09:37:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <xmqqsiebrlez.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqKsc9DjE4MJvZYuuK91MFg29V5gt
	3t5cwmjRPeUto0Vv3ydWi82b21kc2Dx2zrrL7rFgU6nHxUvKHp83yQWwRHHbJCWWlAVnpufp
	2yVwZ8yf2c9ecISvYv2D26wNjE+5uhg5OSQETCQ2XrzCBmGLSVy4tx7I5uIQErjMKNF1ahsr
	hHOOSeLz88ssIFW8AtoSLRfPMYHYLAKqEhsnd4PZbAK6Eot6msFsUYEgiUOnH0PVC0qcnPkE
	yObgEBHwkmibWQwSZhZ4xCix6F0uSFhYwFfi7tsqkLCQwHtGicUL2EFsTgFridZNs1lBSpgF
	1CXWzxOC6JSXaN46m3kCo8AsJPNnIVTNQlK1gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGu
	uV5uZoleakrpJkZIaAvvYNx1Uu4QowAHoxIPr8WERyFCrIllxZW5hxglOZiURHmdAx6HCPEl
	5adUZiQWZ8QXleakFh9ilOBgVhLhrfMDyvGmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqem
	FqQWwWRlODiUJHjvgwwVLEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VofDEwSkFS
	PEB7/QJB9hYXJOYCRSFaTzEqSgFtBUkIgCQySvPgxsIS1itGcaAvhXmzQap4gMkOrvsV0GAm
	oMHz/zwCGVySiJCSamCMKL21wNj7SP2521737zYevLNzgU6YSO0kGZVgt7c/qs4bB/yXmyRp
	l3p043Phbw4/FivPLOi50nFX/9ndl//3e5070Wpn+OCbQt8BTr9HTAdXvhTO63SZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263945>

On 02/12/2015 08:15 PM, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
>> On Thu, Feb 12, 2015 at 3:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> -       int flags; /* REF_NODEREF? */
>>> -       int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
>>> +       /*
>>> +        * One or more of REF_HAVE_OLD, REF_NODEREF,
>>> +        * REF_DELETING, and REF_IS_PRUNING:
>>> +        */
>>> +       int flags;
>>
>> Nit:
>> I'd find it more readable if it would be:
>>     /*
>>      * One or more of
>>      * REF_HAVE_OLD,
>>      * REF_NODEREF,
>>      * REF_DELETING,
>>      * REF_IS_PRUNING:
>>      * whose definition is found at the top of this file.
>>      */
> 
> I wouldn't do either, though, as you would have to keep repeating
> yourself here and over there.  Wouldn't it be sufficient to:
> 
>  - Have a header that says "these are bits meant to go to struct
>    ref_update.flags" at the beginning of series of #define's;
> 
>  - Say "ref_update.flags bits are defined above" here.  The phrasing
>    can be "One or more of REF_HAVE_OLD, etc. defined above." as long
>    as it is clear that this is not meant to be an exhausitive list.

This would be an easy change but for the fact that REF_NODEREF is
defined in refs.h whereas the other constants are internal to refs.c. If
it's OK with you guys, I'd rather leave it the way it is for now and
come back to it later.

For example I want to rename the constants to REF_NODEREF ->
REF_NO_DEREF and REF_ISPRUNING -> REF_IS_PRUNING [1], but am leaving
that for when the refs code is not in so much flux. I can reorganize the
constants and docs then.

Michael

[1] As I type this I realize that the comment misspells the name of
REF_ISPRUNING. I'll fix that, too.

-- 
Michael Haggerty
mhagger@alum.mit.edu
