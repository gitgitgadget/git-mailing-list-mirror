From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Officially start moving to the term 'staging area'
Date: Thu, 29 Aug 2013 23:03:55 +0200
Message-ID: <vpqwqn4nr9g.fsf@anie.imag.fr>
References: <20130829180129.GA4880@nysa> <vpqli3kqqkp.fsf@anie.imag.fr>
	<521f998d25eb4_174378fe7481879@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 23:04:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF9OC-0007fJ-0b
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 23:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021Ab3H2VET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 17:04:19 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59456 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753696Ab3H2VES (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 17:04:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7TL3sTa004934
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 23:03:55 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VF9Nl-0003vv-66; Thu, 29 Aug 2013 23:03:57 +0200
In-Reply-To: <521f998d25eb4_174378fe7481879@nysa.mail> (Felipe Contreras's
	message of "Thu, 29 Aug 2013 13:57:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 29 Aug 2013 23:03:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7TL3sTa004934
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378415036.56227@/HGtor7LGqIhaSqrPxNq9A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233360>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Matthieu Moy wrote:
>
>> --work alone sounds weird. At least to me, it does not immediately imply
>> "working tree". It is tempting to call the option --work-tree, but git
>> already has a global option with that name (git --work-tree=foo bar).
>
> Yes, --work sounds weird, but so does --cherry. I thought about --wt, but I
> felt --work was more understandable, and --work-tree doesn't really give much
> more value,

I think it does: I understand --work as "the verb to work", so 
"git reset --work" sounds like "tell 'git reset' to work", while
"git reset --work-tree" sounds like "tell git to reset the work tree".

> except more characters to type =/

Then, we can have --work-tree and a short version -w.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
