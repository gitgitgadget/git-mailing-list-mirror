From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git
Date: Thu, 06 Aug 2015 12:19:23 +0200
Organization: gmx
Message-ID: <26ccdd486c6749c51dea41aa31428d63@www.dscho.org>
References: <xmqqoail1h2c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 12:19:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNIGs-0008MS-Do
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 12:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbbHFKT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 06:19:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:53296 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754644AbbHFKT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 06:19:28 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LZmd6-1Z0Im848NQ-00lUsa; Thu, 06 Aug 2015 12:19:25
 +0200
In-Reply-To: <xmqqoail1h2c.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:3H1aTyxXDGpgnNB+pfS9QL1IWHBs5ooqxHf/TE9Jsh8ulpdArSv
 kef+X8KcWdIGRNP6r7j4xT3AXgIpY4hHTUk5DkRtPgLpzQv6Jpxhaus7THvY8Xe09pDg8mR
 3QoPqzvFvvPx2wgblJvUgRp40cu4u0BUDrTudGvaISDK1Akio1o0CS37qr5jll+o971UsTO
 PYeL7tGYDYlbx8XSFwefQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8DuAqgv01VI=:vGBYIt0K0tx8t/71bj8wmH
 tI8H/KgifHI2srwdo2Y47WDJJ5az0sBPWyL1fSlP4sDY461RhZ8HpQeIf9+fBglqZEJTHAqq/
 X9R525QFTsoT+v/kYjy0u0Se9ZvBQhr/QOeH9kbBCmXZYF7lm3ngKwnoaWo/1ZORZSw9Jrdvw
 tnecug1HAJlPRMb8X6/UkJFZxLwwychRszR3x+whWZ+FaqSxnVvDoHCflSVY6xTdA3DIhUDwt
 eEUoRw3mhKrRoQFdG0/ZzSNx2UaLs4/WpPHZAgQEDIfVszvP2TMCklaseLN+M+x8VFCYSg7ts
 G8y+hnKg7Qu5By/i6pNfnbiXSkczmfB43EDS4OQA7AaXeQlC5z3nmdHmdsHQBKuyVPhUWfOOo
 mobtBkfkQYraaPxYHCsyCJpaYv+koPqADPwNfEN6Vx2cKyLsYwDNOGtwOVlLC8Own6ZrO0XLI
 kYxGBFx0o9jtEfbivIXenbY6emLGTJrtQGvGH0yEPNE662QmYmyL6h1fwT7u1iKReuaweRLyf
 ohQ33+emPmnXaEyrU2CrA5VhQIogK2g3axo95R379w/9NTwoZLaH2g3hmLVhlHkEGM+gzvsl4
 ykjun4fKOIMaalZFU8qTSmQOLwarvAUfTIh6KLRnAA5QEskYXAcTctbygb88L5Jw9S0Eky74e
 Hw9bovmB6DHRbHqAEfleHLWzz0KZymgeS0Bj1apAzNvbxft2wJF7mlVHnlGsM7gPFqxI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275424>

Hi Junio,

On 2015-08-06 00:55, Junio C Hamano wrote:

> * sb/submodule-helper (2015-08-05) 1 commit
>  - submodule: implement `module_list` as a builtin helper
> 
>  The beginning of "git submodule" rewritten in C.

I am really looking forward to that, with my Windows performance hat firmly on my head.

> * tb/complete-rebase-i-edit-todo (2015-08-05) 1 commit
>  - completion: offer '--edit-todo' during interactive rebase
> 
>  Comments?

The problem fixed by this one has bugged me plenty of times. I often need to edit the TODO e.g. when I managed to get the reordering wrong and want to insert a `pick <commit>` later in the `git-rebase-todo` and then call `git rebase --skip`.

Read: I am very much in favor of fast-tracking this topic.

Thanks,
Dscho
