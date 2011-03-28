From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 14:58:01 +0200
Message-ID: <vpqy63ztnae.fsf@bauges.imag.fr>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
	<1871454323-1301314947-cardhu_decombobulator_blackberry.rim.net-1749053087-@bda570.bisx.prod.on.blackberry>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git-owner@vger.kernel.org, "Git Mailing List" <git@vger.kernel.org>
To: code.sculptor@gmail.com
X-From: git-owner@vger.kernel.org Mon Mar 28 14:58:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4C1R-0000Wn-PZ
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 14:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956Ab1C1M6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 08:58:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44098 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224Ab1C1M6K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 08:58:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p2SCw0lv014850
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Mar 2011 14:58:00 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Q4C1B-0003Fv-Cq; Mon, 28 Mar 2011 14:58:01 +0200
In-Reply-To: <1871454323-1301314947-cardhu_decombobulator_blackberry.rim.net-1749053087-@bda570.bisx.prod.on.blackberry>
	(code sculptor's message of "Mon, 28 Mar 2011 12:22:32 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Mar 2011 14:58:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p2SCw0lv014850
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1301921883.07875@w1zMfpriyZg2uUivj9ufyg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170123>

code.sculptor@gmail.com writes:

> That's a really good point! Perhaps we should have a --invert flag?

IIRC, bzr uses "yes" and "no" instead of "good" and "bad" for this
reason: "yes/no the code works" or "yes/no the code is broken" depending
on what you're looking for.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
