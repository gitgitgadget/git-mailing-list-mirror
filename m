From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: gc --aggressive
Date: Tue, 17 Apr 2012 22:52:03 +0200
Message-ID: <vpqbomqqdxo.fsf@bauges.imag.fr>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
	<CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 22:52:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKFO1-0003s7-92
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 22:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab2DQUwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 16:52:24 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59583 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752162Ab2DQUwX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 16:52:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3HKk4tc024550
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Apr 2012 22:46:04 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SKFNc-0005us-Ho; Tue, 17 Apr 2012 22:52:04 +0200
In-Reply-To: <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
	(Jay Soffian's message of "Tue, 17 Apr 2012 13:53:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 17 Apr 2012 22:46:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3HKk4tc024550
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1335300366.65269@wd1QYX3AB9moZ1p8swp7Ng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195806>

Jay Soffian <jaysoffian@gmail.com> writes:

> + 3. `git gc --aggressive`; this is often much slower than (2) because git
> +    throws out all of the existing deltas and recomputes them from
> +    scratch. It uses a higher window parameter meaning it will spend
> +    more time computing, and it may end up with a smaller pack. However,
> +    unless the repository is known to have initially been poorly packed,
> +    this option is not needed and will just cause git to perform
> +    extra work.

I like your patch.

Maybe you should elaborate on "unless the repository is known to have
initially been poorly packed". My understanding is that --aggressive was
implemented to be called after an import from another VCS that would
have computed very poor deltas, but I'm not sure about the details.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
