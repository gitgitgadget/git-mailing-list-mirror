From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] send-mail: Add option to sleep between sending each email.
Date: Thu, 08 Sep 2011 11:03:56 +0200
Message-ID: <vpq7h5jtngj.fsf@bauges.imag.fr>
References: <1315428191-9769-1-git-send-email-gf@unixsol.org>
	<CALkWK0kH+pD6ymtt9oWLhT0Bftp4EvtrwTtNVw6mjX0aObb-BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Georgi Chorbadzhiyski <gf@unixsol.org>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 11:04:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1aWv-0003jo-1r
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 11:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384Ab1IHJEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 05:04:10 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41594 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932243Ab1IHJEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 05:04:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p8892twq002190
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Sep 2011 11:02:55 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R1aWa-0007mJ-MT; Thu, 08 Sep 2011 11:03:56 +0200
In-Reply-To: <CALkWK0kH+pD6ymtt9oWLhT0Bftp4EvtrwTtNVw6mjX0aObb-BQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 8 Sep 2011 14:13:49 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 08 Sep 2011 11:02:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8892twq002190
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1316077378.51152@xpF+TIH9FRVooALsJzSIOA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180953>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I'm a little curious about why you want to slow it down- is your SMTP
> server configured to block you because it suspects that you're trying
> to spam?

There have been discussion (and IIRC a patch) proposing this already in
the past. One advantage of sleeping a bit between each email is that it
increase the chances for the receiver to receive the emails in the right
order.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
