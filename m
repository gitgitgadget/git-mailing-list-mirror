From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] diff --no-index: support more than one file pair
Date: Thu, 12 Jan 2012 10:30:36 +0100
Message-ID: <vpqmx9te08z.fsf@bauges.imag.fr>
References: <1326359371-13528-1-git-send-email-pclouds@gmail.com>
	<vpq39bll1ua.fsf@bauges.imag.fr>
	<CACsJy8BvA_o1+xrOx4hYhmwNWpsRnh5+mftb471h3yFW2b6vhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 10:30:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlGzg-0001zd-1j
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 10:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204Ab2ALJan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 04:30:43 -0500
Received: from mx1.imag.fr ([129.88.30.5]:44542 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715Ab2ALJak (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 04:30:40 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q0C9TGUV011975
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 12 Jan 2012 10:29:16 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RlGzU-0003qj-NG; Thu, 12 Jan 2012 10:30:36 +0100
In-Reply-To: <CACsJy8BvA_o1+xrOx4hYhmwNWpsRnh5+mftb471h3yFW2b6vhA@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Thu, 12 Jan 2012 16:17:57 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 12 Jan 2012 10:29:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q0C9TGUV011975
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1326965358.27742@B99buVWh7hl/i2us0RyKPw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188440>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Single operation has its advantages:
>
>  - one pager
>  - one stat and summary

I buy these, and I understand why they apply to "git diff" and not GNU
diff.

>  - might be easier to script (just throw them all to xargs)

I don't see a use-case where a command produces old1 new1 old2 new2, but
if there is one, then "| xargs -n 2 diff" is the solution. You don't
need your patch.

>  - hell, i might even benefit from git copy/modify detection

I don't see how, if you specify explicitely the pairs (old, new). You
may have such benefit if you let the command-line express "here's a
bunch of old files, and a bunch of new ones", but not with your proposed
syntax.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
