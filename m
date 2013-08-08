From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout message
Date: Thu, 08 Aug 2013 15:34:38 +0200
Message-ID: <vpqfvukfgr5.fsf@anie.imag.fr>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de>
	<f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost>
	<877gfw4byx.fsf@linux-k42r.v.cablecom.net>
	<262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost>
	<87fvuk2wl0.fsf@linux-k42r.v.cablecom.net>
	<9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost>
	<vpqli4cfhhe.fsf@anie.imag.fr>
	<813506281f7a4d3a8af650c5f8ee33dd7224f193@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: gitml.jexpert@recursor.net
X-From: git-owner@vger.kernel.org Thu Aug 08 15:35:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7QMt-0004E2-R8
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 15:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003Ab3HHNfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 09:35:01 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44833 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964957Ab3HHNep (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 09:34:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r78DYbGD028824
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Aug 2013 15:34:37 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V7QMQ-0006GF-UZ; Thu, 08 Aug 2013 15:34:38 +0200
In-Reply-To: <813506281f7a4d3a8af650c5f8ee33dd7224f193@localhost> (gitml
	jexpert's message of "Thu, 08 Aug 2013 15:27:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 08 Aug 2013 15:34:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r78DYbGD028824
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376573679.36125@TdE8AcH9GY29xSmnuURKjQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231886>

gitml.jexpert@recursor.net writes:

> /lib/x86_64-linux-gnu/libc.so.6(+0x7eb96)[0x7fe162d3eb96]
> [0x51e401]
> [0x51e53c]
> [0x51ecc3]
> [0x4e707b]
> [0x4e7485]
> [0x43d433]
> [0x405158]
> [0x4052ee]
> [0x4054ba]

Using

  addr2line -e ~/projects/git.git/git-fsck

on these addresses may help a little, but not sure it's going to be
sufficient :-(.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
