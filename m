From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Reinstate the helpful message when `git pull
 --rebase` fails
Date: Tue, 13 Oct 2015 13:48:16 +0200
Organization: gmx
Message-ID: <0d0983480d85118291a058dcd3ef727d@dscho.org>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
 <xmqq612grhg7.fsf@gitster.mtv.corp.google.com>
 <CACRoPnSPVMt+FtK6bwfa7Z3jBheTEkBnhU+B7qL8JrAsSmAmkQ@mail.gmail.com>
 <xmqqk2qvq570.fsf@gitster.mtv.corp.google.com>
 <xmqq4mhzq41e.fsf@gitster.mtv.corp.google.com>
 <ed70803ecd73415f1bbafb68502fbbda@dscho.org>
 <xmqqio6bltkq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Paul Tan <pyokagan@gmail.com>,
	Brendan Forster <shiftkey@github.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 13:48:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zly4I-0004gt-1V
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 13:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbbJMLsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 07:48:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:59325 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752768AbbJMLsW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 07:48:22 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MY7dI-1a7sg50aem-00UuDs; Tue, 13 Oct 2015 13:48:17
 +0200
In-Reply-To: <xmqqio6bltkq.fsf@gitster.mtv.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:UEy6571sJP8CEuWpHVXu/2oXBNqX9HlBkq20e8vaQ7tbBA0Mj4f
 AFhe6r9JOMIK620kzmr3Ecvi0e2IMl4fbij1yv4FgsolVxWytoJIZTAQ584vntQuGLmLry3
 hmxQI5rixgjDMtRq+FT92MeKMjrVH1YiHxFDSDvj6cueHa8Rjr7cjWhenRx0NONeUVpPHaM
 JszEMdu2cIXu9DfL/nb2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dEkDtq0bXVU=:OD28hcjhWmhWUQXlHTycDh
 c9vNud9rfWul9n8AmNG+JC5XiTZm8mzflw51+ni+py28Btifh639cTzM16Xdh7dch5wdy8TK+
 UmkEyVWwTUku4jSSQLsBP60apyfnfWaePsmFOtBgvUl32E+9i6S76tQ3JL9ZzMJ3oZOnxPboY
 Oa56qic6A2sC1FzDxKYMEFT/hppzMXFkjBZpOhblf53KxGl+wQmjIlPM2tjM4Uqd7Of1ryCLB
 boioBXec4MeJa7AAQKvFmfhHSh5F0Ewf/4ngCEOrWVD/Qx29QUw/qB06Elx+BrATU8cKrgwUK
 L1thBHHmwRlN9iwuTJ7osLR9VWG4CVAVSJeyIA+3ghXSxyE0mI9rCsPKtfKlGhvBcT9KwwDmK
 8udCzbxTSWEWwwybsT+STS23FW+FVKnceMMKlVy2m692NfInAkGPnu7laiRzEg3cK90Nt4wn3
 aw5w3v0EoK9XhMp7BPnUp1rOWeoWLwiVCwZOxpE5CPHgZ3oGfiD567CUfKewJ6sTm8g2sAzVg
 +IB1C4lrKimsbLLkkt8TqdwttNdWLDsNprGMrxuy3l9njEC0nobT9I/1GD5uPGFrMwM5YtYx1
 YHdHe18Eo5gW5hkUmZyR+ZMB46NMKKJ/Ak7JeTZQ3RdI2w4tfAdUqidwFH/Kre2Fli3Kik6sM
 I7GzlGjkyg4Gg06RRh9v4ic3wcdVQpSMdZmGjyA2+WmAT7Et5kpvFXM3hFi/ujCxlLwmXYQQU
 gDVfWM+njSWSCZCyVNunvZ0NvNgyT/HNsW4nPYHoIjRt9zIuRltOXFNa3ReXJBhRhxOtrcx3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279498>

Hi Junio,

On 2015-10-12 22:28, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>>> I think the most sensible regression fix as the first step at this
>>> point is to call it as a separate process, just like the code calls
>>> "apply" as a separate process for each patch.  Optimization can come
>>> later when it is shown that it matters---we need to regain
>>> correctness first.
>>
>> I fear that you might underestimate the finality of this "first
>> step". If you reintroduce that separate process, not only is it a
>> performance regression, but could we really realistically expect any
>> further steps to happen after that? I do not think so.
>> ...
>> For the above reasons, I respectfully remain convinced that
>> reintroducing the separate process would be a mistake.
> 
> I am not saying we should forever do run_command() going forward.

Fine, I will stop arguing about this and go back grumble in my corner.

Ciao,
Dscho
