From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] add: warn when -u or -A is used without filepattern
Date: Fri, 15 Feb 2013 11:00:46 +0100
Message-ID: <vpq4nhd6gmp.fsf@grenoble-inp.fr>
References: <vpqobg966cv.fsf@grenoble-inp.fr>
	<1359364593-10933-1-git-send-email-Matthieu.Moy@imag.fr>
	<51067353.2090006@drmicha.warpmail.net>
	<7v4ni1xjuc.fsf@alter.siamese.dyndns.org>
	<7vr4kiwjqp.fsf@alter.siamese.dyndns.org>
	<7vmwv6wivs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 11:01:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6I6o-0002rR-Uf
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 11:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756296Ab3BOKBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 05:01:11 -0500
Received: from mx1.imag.fr ([129.88.30.5]:48186 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754523Ab3BOKBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 05:01:09 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1FA0j7r006384
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 15 Feb 2013 11:00:45 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U6I62-0006RY-HE; Fri, 15 Feb 2013 11:00:46 +0100
In-Reply-To: <7vmwv6wivs.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 14 Feb 2013 15:55:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 15 Feb 2013 11:00:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1FA0j7r006384
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1361527252.2023@ChqT6lrbpB66fYIXSq/MSA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216344>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>     warning: The behavior of 'git add --update (or -u)' with no path argument from a
>>     subdirectory of the tree will change in Git 2.0 and should not be used anymore.
>>
>> There is a logic gap between "will change" and "should not be used"
>> that is not filled like the text in the manual page does.
>
> I guess it is not so bad after all, if you read the entire message,
> not just the first two lines.

Also, the warning is meant to be read by a user who just typed
"git add -u", so it is expected that the user knows what it does in
current (or past) versions of Git.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
