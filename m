From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: jk/tag-contains (Re: What's cooking in git.git (Jul 2010, #05; Wed, 28))
Date: Mon, 02 Aug 2010 22:08:18 +0200
Message-ID: <vpqk4o8bwwd.fsf@bauges.imag.fr>
References: <7vvd7zuecv.fsf@alter.siamese.dyndns.org>
	<20100730183709.GC18544@coredump.intra.peff.net>
	<20100731060703.GA21207@burratino>
	<20100731123328.GA5273@coredump.intra.peff.net>
	<7vocdlpsmw.fsf@alter.siamese.dyndns.org>
	<20100802200209.GD2180@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 22:09:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og1KS-0003MC-FE
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 22:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182Ab0HBUJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 16:09:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50756 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753955Ab0HBUJi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 16:09:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o72K6GOo016991
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 Aug 2010 22:06:17 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Og1J4-0002B2-Oy; Mon, 02 Aug 2010 22:08:18 +0200
In-Reply-To: <20100802200209.GD2180@burratino> (Jonathan Nieder's message of "Mon\, 2 Aug 2010 15\:02\:09 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 02 Aug 2010 22:06:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o72K6GOo016991
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281384378.7536@vRcEx3sXfS+kTn2dnn3ZAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152449>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> You need to be careful here, though.  What if you pulled from somebody
>> whose clock is set grossly in the future?
>
> We could check for that and give relevant advice:
>
>  fatal: committer date <date> precedes parent date <date>
>  hint: It looks like you are trying to commit on top of a commit
>  hint: from 5 years into the future.
>  hint: Use "git rebase -f" to rewrite the commit with a more
>  hint: sensible date, and please, fix your clocks!

If the problem is the commit you've just pulled, I'd advise against
re-writing it: it's published, it's too late.

Be careful also: Git can hardly guess whether your clock is late, or
whether your co-worker's clock is in the future.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
