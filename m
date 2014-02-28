From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] t3200-branch: test setting branch as own upstream
Date: Fri, 28 Feb 2014 15:57:14 +0100
Message-ID: <vpqa9db1e0l.fsf@anie.imag.fr>
References: <1393556659-32717-1-git-send-email-modocache@gmail.com>
	<20140228053703.GA32556@sigill.intra.peff.net>
	<531032DD.9000904@viscovery.net>
	<20140228071401.GA1229@sigill.intra.peff.net>
	<20140228072606.GA622@sigill.intra.peff.net>
	<CAN7MxmXOvkrWPDEUH_Bqz5RVZUS7kuWkwi9kWmdwuwySszd=YA@mail.gmail.com>
	<20140228083718.GA11480@sigill.intra.peff.net>
	<CAN7MxmUUoz-HGFiTfgpvLpkXhvjBn_dYje7unoHE-Y=k3A0aqg@mail.gmail.com>
	<20140228105929.GA18960@sigill.intra.peff.net>
	<CAN7MxmVxYhF1VXWZNAXyfF8iBNQaqqwoyjmDAP_9_bc5NUUU6A@mail.gmail.com>
	<20140228130340.GB23448@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 28 15:57:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJOsY-0007FF-Ih
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 15:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbaB1O5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 09:57:30 -0500
Received: from mx2.imag.fr ([129.88.30.17]:48022 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586AbaB1O5a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 09:57:30 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s1SEvCfP017462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 28 Feb 2014 15:57:12 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s1SEvEMa021058;
	Fri, 28 Feb 2014 15:57:14 +0100
In-Reply-To: <20140228130340.GB23448@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 28 Feb 2014 08:03:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 28 Feb 2014 15:57:12 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s1SEvCfP017462
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1394204236.75277@DvKbsz13RJVZlIb/YCGYfA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242972>

Jeff King <peff@peff.net> writes:

>   Don't die to let the caller finish its
>   job in such case.

[...]

> Matthieu, can you remember anything else that
> led to that decision?

Not at all, unfortunately. I don't remember if I did that "in case
there's something like some cleanup to do" or because I had something
more precise in mind.

A case to be carefull about is if you're using the same "git branch"
command for multiple actions (trying --set-upstream in combination with
other options). But I do not see a case where this would be possible.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
