From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Aug 2010, #01; Wed, 4)
Date: Thu, 05 Aug 2010 10:20:06 +0200
Message-ID: <vpqmxt14gjt.fsf@bauges.imag.fr>
References: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 10:20:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogvgb-0003X3-VM
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 10:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759920Ab0HEIUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 04:20:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49532 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754858Ab0HEIUO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 04:20:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o758HvhM013672
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Aug 2010 10:17:57 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OgvgM-0005UU-T6; Thu, 05 Aug 2010 10:20:06 +0200
In-Reply-To: <7v62zqf23s.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 04 Aug 2010 15\:24\:23 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 05 Aug 2010 10:17:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o758HvhM013672
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281601078.08035@f1RqS650589piuAAssFuNA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152620>

Junio C Hamano <gitster@pobox.com> writes:

> * mm/shortopt-detached (2010-07-30) 5 commits
>  - log: parse detached option for --glob
>  - log: parse detached options like git log --grep foo
>  - diff: parse detached options --stat-width n, --stat-name-width n
>  - diff: split off a function for --stat-* option parsing
>  - diff: parse detached options like -S foo

I'm pretty sure I had send a new version of this one, but judging from
the mailing list's archive, I guess I mis-sent it and it never went
through ;-).

Here's a new one, with very minor revisions :

* diff_long_opt renamed to parse_long_opt

* Use the same wording as api-parse-options.txt : separate/sticked
  forms (essentially in commit messages and comments).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
