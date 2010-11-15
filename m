From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] use persistent memory for rejected paths
Date: Mon, 15 Nov 2010 20:03:40 +0100
Message-ID: <vpq62vymmsz.fsf@bauges.imag.fr>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
	<20101114130205.GA27560@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Nov 15 20:04:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI4Le-0000Us-Dy
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 20:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932840Ab0KOTEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 14:04:09 -0500
Received: from mx1.imag.fr ([129.88.30.5]:55936 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932703Ab0KOTEI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 14:04:08 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id oAFIm2dG030228
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Nov 2010 19:48:02 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PI4L6-0003LJ-Eu; Mon, 15 Nov 2010 20:03:40 +0100
In-Reply-To: <20101114130205.GA27560@localhost> (Clemens Buchacher's message of "Sun\, 14 Nov 2010 14\:02\:05 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 15 Nov 2010 19:48:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oAFIm2dG030228
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1290451686.35399@t+xTP/4wfj5jvpoHGUuPsQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161503>

Clemens Buchacher <drizzd@aon.at> writes:

> An aborted merge prints the list of rejected paths as part of the
> error message. Some of those paths do not have static buffers, so
> we have to keep a copy.

Like Junio, I'm surprised by this, but I guess you encountered the
problem.

> Use string_list's to accomplish this.

That seems to be a good thing anyway.

Did you remove all uses of "struct rejected_paths_list"? If so, you
can remove its declaration, if not, why?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
