From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: PostScript files: textconv and "git add -p"
Date: Sun, 09 Jan 2011 19:55:43 +0100
Message-ID: <vpqr5clsy8g.fsf@bauges.imag.fr>
References: <vpqy670brcb.fsf@bauges.imag.fr>
	<20110105051807.GB5884@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 09 19:56:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pc0Qq-0005Rq-9m
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 19:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176Ab1AISzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jan 2011 13:55:52 -0500
Received: from mx2.imag.fr ([129.88.30.17]:39655 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751990Ab1AISzw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jan 2011 13:55:52 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p09Itg6V021887
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 9 Jan 2011 19:55:42 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Pc0QZ-0000KP-Si; Sun, 09 Jan 2011 19:55:43 +0100
In-Reply-To: <20110105051807.GB5884@sigill.intra.peff.net> (Jeff King's message of "Wed\, 5 Jan 2011 00\:18\:07 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 09 Jan 2011 19:55:42 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p09Itg6V021887
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1295204144.60111@lgg1NCI4/wfNNs/7Sw9qBQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164858>

Jeff King <peff@peff.net> writes:

> you can get what you want with:
>
>   echo '*.ps diff=ps' >.gitattributes
>   git config diff.ps.textconv ps2ascii
>   git config diff.ps.binary true

Yes, this works great. Thanks.

Did I miss something, or is this undocumented? I can't find that in
either man gitattributes or man git-config.

> PS Your question made me very happy. I implemented "diff.*.binary" the
>    way I did out of a vague sense of orthogonality, but I never quite
>    came up with a concrete example where it was useful to set both.
>    Thanks for providing one. :)

I vaguely remember such discussions, and may well have thought "hmm,
yet another overkill stuff that nobody'll ever use" at that time ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
