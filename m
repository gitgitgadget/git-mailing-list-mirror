From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout message
Date: Thu, 08 Aug 2013 18:48:25 +0200
Message-ID: <vpqob98cena.fsf@anie.imag.fr>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de>
	<f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost>
	<877gfw4byx.fsf@linux-k42r.v.cablecom.net>
	<262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost>
	<87fvuk2wl0.fsf@linux-k42r.v.cablecom.net>
	<9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost>
	<vpqli4cfhhe.fsf@anie.imag.fr>
	<813506281f7a4d3a8af650c5f8ee33dd7224f193@localhost>
	<vpqfvukfgr5.fsf@anie.imag.fr>
	<edc9f41b4ffca9ce36dc50e749de7a86e4618a0e@localhost>
	<87fvuk1cyl.fsf@linux-k42r.v.cablecom.net> <5203B100.30008@gmail.com>
	<87txj0i4mc.fsf@inf.ethz.ch> <5203C923.8060905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Stefan Beller <stefanbeller@googlemail.com>
To: Ben Tebulin <tebulin@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 18:48:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7TOD-0006cT-MD
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 18:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213Ab3HHQsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 12:48:37 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49051 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934235Ab3HHQsh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 12:48:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r78GmN9w027510
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Aug 2013 18:48:23 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V7TNy-0007hK-0u; Thu, 08 Aug 2013 18:48:26 +0200
In-Reply-To: <5203C923.8060905@gmail.com> (Ben Tebulin's message of "Thu, 08
	Aug 2013 18:36:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 08 Aug 2013 18:48:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r78GmN9w027510
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376585308.99292@3+gzdEWIdJcGUp/jRe7cYA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231901>

Ben Tebulin <tebulin@googlemail.com> writes:

> c) or defect/buggy Hardware (CPU, Memory)

You may want to try a memcheck86 on your machine for a few hours, in
case ... (if your RAM is broken, you do want to know it!).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
