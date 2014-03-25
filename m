From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: [PATCH 7/8] ls-files: support --max-depth
Date: Tue, 25 Mar 2014 09:55:58 +0100 (CET)
Message-ID: <1457323768.788823.1395737758945.JavaMail.zimbra@imag.fr>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com> <1395310551-23201-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 09:57:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSNAS-0000An-Io
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944AbaCYI5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 04:57:01 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58693 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753049AbaCYI43 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:56:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2P8uOPU016515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Mar 2014 09:56:24 +0100
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2P8uORJ023083;
	Tue, 25 Mar 2014 09:56:25 +0100
In-Reply-To: <1395310551-23201-8-git-send-email-pclouds@gmail.com>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF28 (Linux)/8.0.6_GA_5922)
Thread-Topic: ls-files: support --max-depth
Thread-Index: dWwSJP39oN1PeFOgLK9McO3tTx0wig==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 25 Mar 2014 09:56:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2P8uOPU016515
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1396342584.68446@tTgTPqrXg47rqDICusjVVQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245018>

----- Original Message -----
> The use case in mind is --max-depth=0 to stop recursion. With this we can do
> 
> git config --global alias.ls 'ls-files --column --color --max-depth=0'
> 
> and have "git ls" with an output very similar to GNU ls.

One big difference though: your "git ls" does not show directories. I understand that this is easier to implement, but from the user point of view it resulted in a "wtf" from me running "git ls" in a repository containing essentially directories, and seeing just a README file in the output.

Ideally (for me), directories should be shown with a trailing / like "ls -F" does.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
