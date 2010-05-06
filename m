From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] An alias that starts with "!!" runs in the current directory.
Date: Thu, 06 May 2010 09:02:35 +0200
Message-ID: <vpqfx25a4xg.fsf@bauges.imag.fr>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
	<20100505005153.GC25390@coredump.intra.peff.net>
	<4BE115EF.8010306@viscovery.net>
	<20100505070131.GA11265@coredump.intra.peff.net>
	<19425.9169.537598.876589@winooski.ccs.neu.edu>
	<7v1vdql4c9.fsf@alter.siamese.dyndns.org>
	<19425.54504.163875.379151@winooski.ccs.neu.edu>
	<19425.58290.42871.986460@winooski.ccs.neu.edu>
	<1273098179.723.10.camel@dreddbeard>
	<7vpr19j4ng.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: wmpalmer@gmail.com, Eli Barzilay <eli@barzilay.org>,
	Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 06 09:03:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9v73-0002c4-4N
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 09:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242Ab0EFHDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 03:03:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44754 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab0EFHDF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 03:03:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o466uaEX030783
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 6 May 2010 08:56:36 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O9v6S-0001yj-0q; Thu, 06 May 2010 09:02:36 +0200
In-Reply-To: <7vpr19j4ng.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 05 May 2010 16\:43\:47 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 06 May 2010 08:56:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o466uaEX030783
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1273733797.38406@0eK+6SDG0lipFhCxJWqk3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146450>

Junio C Hamano <gitster@pobox.com> writes:

> It probably is a good idea to switch aliases to start at the $cwd in 1.8.0
> (or perhaps one major release after it), and using a notation that is more
> descriptive, something like "!(cwd)" vs "!(root)", may give us a better
> transtion strategy than casting cryptic "!!" in the stone.

I like this: Allow !(cwd) and !(root) today, with !(root) being just
like "!", and change plain "!" to mean !(cwd) in a future major
release.

If other people have ideas for other features, the syntax can also be
extended to !(cwd,some-option) or so.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
