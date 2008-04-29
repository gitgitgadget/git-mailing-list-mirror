From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 20:17:51 +0200
Message-ID: <vpqwsmg7cfk.fsf@bauges.imag.fr>
References: <200804281829.11866.henrikau@orakel.ntnu.no>
	<20080429124152.GB6160@dpotapov.dyndns.org> <481733A3.4010802@op5.se>
	<alpine.LFD.1.10.0804291132060.23581@xanadu.home>
	<7f9d599f0804290859y6a579302m5db9f7f827b320a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nicolas Pitre" <nico@cam.org>, "Andreas Ericsson" <ae@op5.se>,
	"Dmitry Potapov" <dpotapov@gmail.com>,
	"Henrik Austad" <henrikau@orakel.ntnu.no>, git@vger.kernel.org
To: "Geoffrey Irving" <irving@naml.us>
X-From: git-owner@vger.kernel.org Tue Apr 29 20:20:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JquR6-0008HD-46
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 20:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758405AbYD2STX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 14:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758924AbYD2STV
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 14:19:21 -0400
Received: from imag.imag.fr ([129.88.30.1]:41303 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760803AbYD2STT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 14:19:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m3TII06D005506
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 29 Apr 2008 20:18:00 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JquOl-000327-IM; Tue, 29 Apr 2008 20:17:51 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JquOl-00088B-Fw; Tue, 29 Apr 2008 20:17:51 +0200
In-Reply-To: <7f9d599f0804290859y6a579302m5db9f7f827b320a4@mail.gmail.com> (Geoffrey Irving's message of "Tue\, 29 Apr 2008 08\:59\:29 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 29 Apr 2008 20:18:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80715>

"Geoffrey Irving" <irving@naml.us> writes:

> Here's the standard scenario for a hash collision attack, with
> parties, A, B, and C:
>
> 1. C, the malicious one, computes the standard two pdfs with matching
> sha1 hashes.
> 2. C sends the valid pdf to B through a git commit, and B signs it with a tag.
> 3. C grabs the signature, and then forwards the "signed" commit to A,
> but substitutes the invalid pdf with the same hash.

Just to add my 2 cents, examples of this are available on the web,
like:

http://th.informatik.uni-mannheim.de/People/Lucks/HashCollisions/

Same size, same hash. But that's with md5, not sha1.

-- 
Matthieu
