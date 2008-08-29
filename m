From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Fri, 29 Aug 2008 11:02:58 +0200
Message-ID: <vpqhc945h31.fsf@bauges.imag.fr>
References: <20080828090421.GQ10360@machine.or.cz>
	<20080828195211.GA3545@mithlond.arda.local>
	<4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu>
	<20080828212346.GA27867@coredump.intra.peff.net>
	<1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu>
	<20080828215907.GE27867@coredump.intra.peff.net>
	<3DE083DB-ADFF-45E7-B3EB-A76985941271@cs.indiana.edu>
	<20080828230401.GC29609@coredump.intra.peff.net>
	<48B7AA67.4040400@op5.se> <vpqvdxk5jrl.fsf@bauges.imag.fr>
	<1f6632e50808290127x2ec1ee6am90639b35aba5b764@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Matthias Kestenholz" <mk@spinlock.ch>
X-From: git-owner@vger.kernel.org Fri Aug 29 11:05:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYzvK-0005r3-BS
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 11:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbYH2JEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 05:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbYH2JEi
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 05:04:38 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:51800 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbYH2JEh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 05:04:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m7T931P9005478;
	Fri, 29 Aug 2008 11:03:01 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KYzsg-0001e7-Hi; Fri, 29 Aug 2008 11:02:58 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KYzsg-0000zr-FT; Fri, 29 Aug 2008 11:02:58 +0200
In-Reply-To: <1f6632e50808290127x2ec1ee6am90639b35aba5b764@mail.gmail.com> (Matthias Kestenholz's message of "Fri\, 29 Aug 2008 10\:27\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Fri, 29 Aug 2008 11:03:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthias Kestenholz" <mk@spinlock.ch> writes:

>> AAUI, the pack itself is sent over the network, but the index is
>> generated locally when receiving the pack, so this shouldn't be a
>> problem.
>
> If you use the git or ssh protocol, then yes. If you use dumb protocols such as
> HTTP or rsync, no.

Thanks for the clarification, and sorry for the noise then ;-).

-- 
Matthieu
