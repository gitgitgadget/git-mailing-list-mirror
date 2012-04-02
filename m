From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: push.default: current vs upstream
Date: Mon, 02 Apr 2012 09:40:22 +0200
Message-ID: <vpqty12h995.fsf@bauges.imag.fr>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
	<20120329095236.GA11911@sigill.intra.peff.net>
	<7vbonfqezs.fsf@alter.siamese.dyndns.org>
	<20120329221154.GA1413@sigill.intra.peff.net>
	<7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
	<20120330071358.GB30656@sigill.intra.peff.net>
	<7vty15ltuo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 09:40:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEbsl-0000yJ-6a
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 09:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295Ab2DBHkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 03:40:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49312 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040Ab2DBHkk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 03:40:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q327ZGF8014899
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 Apr 2012 09:35:16 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SEbsF-0007rh-OG; Mon, 02 Apr 2012 09:40:23 +0200
In-Reply-To: <7vty15ltuo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 30 Mar 2012 13:25:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 02 Apr 2012 09:35:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q327ZGF8014899
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1333956918.56902@HhXsc70vU8FP90swZvvrCw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194500>

Junio C Hamano <gitster@pobox.com> writes:

> Obviously the
> former is much simpler to explain and understand, as people do not have to
> learn upstream tracking before doing their first "push".

Again, this is simple only for people who never run "git pull" without
argument.

For the others, they already have to learn about the "upstream"
semantics. And making argumentless "git pull" and "git push" purposely
asymetric to make it simple for the user sounds like an oxymoron to me.

The discussion seems to focuse on 'let's make "git push" easy to
explain', but I think the right thing to do is to make _Git_ easy to
explain. With "push.default = current", we'll have a hard time
explaining how "git pull" works.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
