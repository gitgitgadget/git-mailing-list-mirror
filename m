From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] Add 'git credential' plumbing command
Date: Tue, 12 Jun 2012 16:36:03 +0200
Message-ID: <vpqy5nsppgs.fsf@bauges.imag.fr>
References: <1339511044-29977-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
	<vpq3960r48q.fsf@bauges.imag.fr>
	<20120612143411.GA7524@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Javier.Roucher-Iglesias@ensimag.imag.fr, git@vger.kernel.org,
	Javier Roucher <jroucher@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 16:36:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeSCe-0006QA-3t
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 16:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217Ab2FLOgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 10:36:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59110 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306Ab2FLOgK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 10:36:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5CER7k9028628
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2012 16:27:07 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SeSCS-0006yA-9h; Tue, 12 Jun 2012 16:36:04 +0200
In-Reply-To: <20120612143411.GA7524@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 12 Jun 2012 10:34:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 12 Jun 2012 16:27:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5CER7k9028628
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340116028.57441@ECxA6ZpogB25MNAdLm/Pkg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199793>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 12, 2012 at 04:31:33PM +0200, Matthieu Moy wrote:
>
>> Javier.Roucher-Iglesias@ensimag.imag.fr writes:
>> 
>> > +git credential <fill|approve|reject>
>> 
>> You didn't take Jeff's suggestions into account:
>> 
>> http://thread.gmane.org/gmane.comp.version-control.git/199552/focus=199591
>> 
>> It's clearly too late to implement the whole suggested API, but I do
>> like the suggestion of allowing either a URL as argument or individual
>> fields on stdin, or both combined, by using the --stdin argument.
>> 
>> To allow further patches to implement this without breaking backward
>> compatibility, your implementation could require the use of --stdin on
>> the command-line.
>
> Actually, after further discussion, I think that --stdin is unnecessary.
> If you are providing a URL, you should always provide it via stdin
> because of the password-disclosure issue. It's tempting to provide a
> command-line alternative because it's easier, but I think it would just
> encourage lazy developers to do the wrong thing.

OK, that makes sense.

> I do still think respecting "url=" when reading a credential makes
> sense, but that is easy to add later.

OK, so in short: Javier, you can ignore my comment.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
