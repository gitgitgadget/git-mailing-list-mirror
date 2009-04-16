From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: how to check what your pulling down?
Date: Thu, 16 Apr 2009 19:03:31 +0200
Message-ID: <vpq7i1kttss.fsf@bauges.imag.fr>
References: <23075475.post@talk.nabble.com>
	<7vfxg8k0mk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cantona <adam@dwpub.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 19:10:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuV4v-00064L-RS
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 19:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259AbZDPRHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 13:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754737AbZDPRHJ
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 13:07:09 -0400
Received: from imag.imag.fr ([129.88.30.1]:41050 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753591AbZDPRHH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 13:07:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3GH3a8V001820
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 16 Apr 2009 19:03:36 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LuUzr-0005BZ-Jw; Thu, 16 Apr 2009 19:03:31 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LuUzr-0007qM-HS; Thu, 16 Apr 2009 19:03:31 +0200
In-Reply-To: <7vfxg8k0mk.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 16 Apr 2009 09\:46\:11 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 16 Apr 2009 19:03:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116714>

Junio C Hamano <gitster@pobox.com> writes:

> cantona <adam@dwpub.com> writes:
>
>> I've been using basic git for a while (add,comit,push,pull) and have
>> recently discovered stash,merge,branch :)
>>
>> My question: before I pull down I always get that bad feeling... "what am i
>> gunna get? will there be a conflict?".
>
> "will there be a conflict?" is an unfounded fear people seem to be unable
> to shake off from their old scm days.

But still, if you want to know what's new without touching your work
at all, "git fetch" is your friend: it fetches new commits from
another repository, without merging them with your branches. Running
"gitk --all" right after a "git fetch" should help understanding what
it did.

-- 
Matthieu
