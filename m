From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 20:23:59 +0200
Message-ID: <vpqvcz35cjk.fsf@bauges.imag.fr>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
	<AANLkTin1QCda9BV+gND1kcXRTZBF7hj3Chce5OkLX2a9@mail.gmail.com>
	<4D909DD1.2050904@viscovery.net>
	<AANLkTinC9Lr9uCTUZSVxVR56+FQm2NGRpPu90fm9OHF5@mail.gmail.com>
	<vpq62r3i1z4.fsf@bauges.imag.fr>
	<AANLkTimT+WN2F-BmQzQrAs3uizHig9cCXDUdc7nQ-vC5@mail.gmail.com>
	<vpqr59r6sg5.fsf@bauges.imag.fr>
	<AANLkTinuH4Ut+jtdqRfFrNeXA6JmBK2i0ddCcz4vV6JC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r?= =?iso-8859-1?Q?=F0?= 
	<avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Andrew Garber <andrew@andrewgarber.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 20:24:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4H6q-0002uL-Bd
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 20:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab1C1SYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 14:24:05 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41627 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237Ab1C1SYE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 14:24:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p2SINvSm020881
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Mar 2011 20:23:57 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Q4H6d-0002Qu-QW; Mon, 28 Mar 2011 20:23:59 +0200
In-Reply-To: <AANLkTinuH4Ut+jtdqRfFrNeXA6JmBK2i0ddCcz4vV6JC@mail.gmail.com>
	(Andrew Garber's message of "Mon, 28 Mar 2011 14:12:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Mar 2011 20:23:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p2SINvSm020881
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1301941438.88841@brAtboW8VPZ/VfFJqSjvRA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170173>

Andrew Garber <andrew@andrewgarber.com> writes:

> On Mon, Mar 28, 2011 at 1:55 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>
>> Then which commit do you specify as "good"?
>
> Any ancestral commit *on the same branch* which is know to be working.

What is the point is finding manually a commit *on the same branch* when
the tool can do that for you? You don't know how old the breakage is, so
finding the first good commit will take some time. Knowing that the
other branch is good gives you a hint that the common ancestor between
branches should be good, so a good start would be to find the common
ancestor.

But again, why would you insist in doing that manually?

> Isn't the whole point of git bisect is to do binary search through
> time?

No. Bisect does a search through a DAG. And that is the whole point of
bisect: doing a binary search through time is something you could do
manually. That would be less convenient, but still workable. git bisect
is far more clever, and does something you could hardly do manually, or
at least not without getting headaches.

> Perhaps you could give a concrete example of where you could use it
> for multiple branches simultaneously?

Well, see my previous email.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
