From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Mon, 22 Feb 2016 11:22:48 +0100
Message-ID: <vpqziutkps7.fsf@anie.imag.fr>
References: <vpqoabox66p.fsf@anie.imag.fr>
	<CAP8UFD0UxB6Z1UU=4Bkz0Yt2KE+AkrttQeTx2oY9v9O78f9qow@mail.gmail.com>
	<vpqd1s2e74l.fsf@anie.imag.fr>
	<20160212130446.GB10858@sigill.intra.peff.net>
	<vpqd1s04zzs.fsf@anie.imag.fr>
	<CACsJy8BzkWSc11ODenEuGBBta+dkLS893o7oRS57_ctoB5ie8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 11:23:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXne1-0006Cg-Vy
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 11:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbcBVKXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 05:23:00 -0500
Received: from mx1.imag.fr ([129.88.30.5]:53221 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653AbcBVKW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 05:22:59 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1MAMmrA021003
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 22 Feb 2016 11:22:48 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1MAMmJ1015585;
	Mon, 22 Feb 2016 11:22:48 +0100
In-Reply-To: <CACsJy8BzkWSc11ODenEuGBBta+dkLS893o7oRS57_ctoB5ie8A@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 22 Feb 2016 16:28:32 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 22 Feb 2016 11:22:48 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1MAMmrA021003
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456741369.36766@XRk/MKxd1a6AGeo2LR6v4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286904>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Feb 13, 2016 at 6:21 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Less urgent, but we need to add more stuff to be credible:
>>
>> ...
>>
>> http://git.github.io/SoC-2016-Microprojects/ => I just did s/2015/2016/.
>> I think most projects are not valid anymore, and we need new ones.
>>
>> To all: please contribute to these pages, either by sending patches here
>> (CC: me and peff), pushing directly if you have access, or submitting
>> pull-requests. The repo is https://github.com/git/git.github.io/.
>
> Idea for microprojects. If you compile using gcc with -Wshadow, it
> spots local variables that shadow another local or global variables.
> These are usually bad because it makes it's easy to make mistakes when
> changing the code.

I hade a look an a few instances of the warning, and all of them were
bad (sometimes even suspicious, I wouldn't be surprised if we found real
bugs hunting these down).

> _If_ you agree shadow vars are bad and should be exterminated,
> 'master' has 94 warnings spreading over 49 files. A student can pick
> _one_ file and try to fix all warnings in that file. There are many
> possible approaches (rename, combine vars, change scope, even
> restructure/kill global vars..), plenty of room for discussion.

+1.

Are there counter-arguments to this?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
