From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: RFE: "git bisect reverse"
Date: Wed, 27 May 2009 22:26:01 +0200
Message-ID: <vpqprdue1ie.fsf@bauges.imag.fr>
References: <4A1C6B70.4050501@zytor.com>
	<20090527172233.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed May 27 22:28:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Pjj-0001fg-0W
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 22:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbZE0U2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 16:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbZE0U2P
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 16:28:15 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:40500 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405AbZE0U2P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 16:28:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n4RKQ2iq021559;
	Wed, 27 May 2009 22:26:02 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1M9PhJ-0002KX-Si; Wed, 27 May 2009 22:26:01 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1M9PhJ-0000lS-RL; Wed, 27 May 2009 22:26:01 +0200
In-Reply-To: <20090527172233.6117@nanako3.lavabit.com> (Nanako Shiraishi's message of "Wed\, 27 May 2009 17\:22\:33 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 27 May 2009 22:26:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120103>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting "H. Peter Anvin" <hpa@zytor.com>:
>
>> I would like to request the following feature:
>>
>> "git bisect reverse"
>>
>> ... does exactly the same thing as "git bisect start", except that it
>> flips the meaning of "good" and "bad".  It is mentally fairly taxing to
>> do a reverse bisection (looking for an antiregression) when one has to
>> flip the meaning of "good" and "bad" (which are very loaded words to our
>> psyche), and it's even worse to try to get a user to do it...
>
> There was a discussion on "fixed" and "unfixed" aliases to find a commit that fixed an old breakage.
>
>   http://thread.gmane.org/gmane.comp.version-control.git/86063/focus=86563

I think the bzr "bisect" plugin uses "yes" and "no" instead for this
reason. I find it mentally easier to adapt it to both cases ("yes,
it's fixed" or "yes, it's broken" depending on what you search).

-- 
Matthieu
