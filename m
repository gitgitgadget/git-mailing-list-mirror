From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: [PUB]corrupt repos does not return error with `git fsck`
Date: Wed, 20 May 2015 23:03:17 +0200 (CEST)
Message-ID: <938467222.2099913.1432155797402.JavaMail.zimbra@imag.fr>
References: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org> <vpq382rkvzf.fsf@anie.imag.fr> <d21002e0fa92b03c3d417c8996328563@www.dscho.org> <CAGZ79kZY68HFDipxLVas9Dg9+NfpOGmywpWfwFL31A0EpLmJFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Faheem Mitha <faheem@faheem.info>, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 20 23:03:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvB9S-0007LE-LH
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 23:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197AbbETVD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 17:03:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39125 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060AbbETVDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 17:03:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4KL3Fcr032690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 20 May 2015 23:03:15 +0200
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4KL3HpJ022656;
	Wed, 20 May 2015 23:03:17 +0200
In-Reply-To: <CAGZ79kZY68HFDipxLVas9Dg9+NfpOGmywpWfwFL31A0EpLmJFw@mail.gmail.com>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF31 (Linux)/8.0.6_GA_5922)
Thread-Topic: corrupt repos does not return error with `git fsck`
Thread-Index: /qdosXot/GNCsBibS4JuWqH0DKNy+w==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 20 May 2015 23:03:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4KL3Fcr032690
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1432760597.28782@2l+mhuTTnkon0RhopW0FiQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269524>

sbeller@google.com writes:
> $ git clone https://github.com/fmitha/SICL
> cd SICL
> $ git show 280c12ab49223c64c6f914944287a7d049cf4dd0
> fatal: bad object 280c12ab49223c64c6f914944287a7d049cf4dd0
> $ git show 12323213123 # just to be sure to have a different error message for non existing objects.

I did the same, but the error message is different if you provide an abreviated sha1 or a full 40-chars sha1.

Any full sha1 I tried gave the same error message.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
