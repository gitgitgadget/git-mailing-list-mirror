From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 0/4] make helpful messages optional
Date: Sun, 06 Sep 2009 13:53:26 +0200
Message-ID: <vpq7hwcthl5.fsf@bauges.imag.fr>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
	<1249717868-10946-1-git-send-email-Matthieu.Moy@imag.fr>
	<87prb6r9d1.fsf@iki.fi> <vpqab2aqqia.fsf@bauges.imag.fr>
	<7vy6pujmsc.fsf@alter.siamese.dyndns.org>
	<20090811120313.6117@nanako3.lavabit.com>
	<20090906064454.GA1643@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 06 14:04:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkGTW-0001KO-0Q
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 14:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956AbZIFL47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 07:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754070AbZIFL46
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 07:56:58 -0400
Received: from imag.imag.fr ([129.88.30.1]:52063 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629AbZIFL45 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 07:56:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n86BrQnv029234
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 Sep 2009 13:53:26 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MkGJC-00044k-LS; Sun, 06 Sep 2009 13:53:26 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MkGJC-0008W1-Iu; Sun, 06 Sep 2009 13:53:26 +0200
In-Reply-To: <20090906064454.GA1643@coredump.intra.peff.net> (Jeff King's message of "Sun\, 6 Sep 2009 02\:44\:54 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 06 Sep 2009 13:53:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127852>

Jeff King <peff@peff.net> writes:

>   [1/4]: push: fix english in non-fast-forward message
>   [2/4]: push: re-flow non-fast-forward message

Sounds OK to me.

>   [3/4]: push: make non-fast-forward help message configurable
>   [4/4]: status: make "how to stage" messages optional

I didn't review the code in details, but I like the direction where
it's going. I'm not sure what's the best name for the configuration
option, but probably your proposal of "message" is good because it can
encompass many different cases (very detailed error messages, advices,
informative messages, ...).

And BTW, as the initial author of the push help message, I fully agree
that it is unnecessarily eating 3 lines of my terminal ;-). The
message is clearly targeted to newbies (but I do think it's very
helpfull to them).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
