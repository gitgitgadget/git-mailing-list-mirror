From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Commits gone AWOL, but not reported by git-fsck --unreachable
Date: Sat, 19 May 2007 18:55:39 +0200
Message-ID: <vpq8xbkoir8.fsf@bauges.imag.fr>
References: <20070519103011.GU17511@curie-int.orbis-terrarum.net>
	<20070519115245.GA10035@coredump.intra.peff.net>
	<20070519120933.GW17511@curie-int.orbis-terrarum.net>
	<20070519121154.GA10268@coredump.intra.peff.net>
	<pan.2007.05.19.15.45.46@progsoc.org> <vpq646opzio.fsf@bauges.imag.fr>
	<A04FB6C2-20B2-4263-9D58-6C281C04C6C4@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sat May 19 18:59:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpSHV-0007BH-4V
	for gcvg-git@gmane.org; Sat, 19 May 2007 18:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518AbXESQ7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 12:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754746AbXESQ7n
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 12:59:43 -0400
Received: from imag.imag.fr ([129.88.30.1]:50213 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754518AbXESQ7m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 12:59:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4JGte62005226
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 19 May 2007 18:55:40 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HpSDU-0000iH-4i; Sat, 19 May 2007 18:55:40 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HpSDU-0007ER-0G; Sat, 19 May 2007 18:55:40 +0200
Mail-Followup-To: Brian Gernhardt <benji@silverinsanity.com>, Anand Kumria <wildfire@progsoc.org>,  git@vger.kernel.org
In-Reply-To: <A04FB6C2-20B2-4263-9D58-6C281C04C6C4@silverinsanity.com> (Brian Gernhardt's message of "Sat\, 19 May 2007 12\:20\:56 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 19 May 2007 18:55:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47758>

Brian Gernhardt <benji@silverinsanity.com> writes:

> On May 19, 2007, at 12:08 PM, Matthieu Moy wrote:
>
>> The commit introducing it is 566842f62bdf1f16c2e94fb431445d2e6c0f3f0b,
>> and I'd say it's in git 1.5.1:
>>
>> $ git-describe --tags 566842f62bdf1f16c2e94fb431445d2e6c0f3f0b
>> v1.5.1-34-g566842f
>
> Actually, I think that means it's 34 commits *after* v1.5.1, not
> before.  It's in 1.5.2-rc0, but none of the 1.5.1.* series.

You're right. Then, is there any easy way to ask git the oldest tag(s)
that a commit is an ancestor of? In other words, which command should
I have typed above?

-- 
Matthieu
