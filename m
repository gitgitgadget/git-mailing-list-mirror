From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Officially start moving to the term 'staging area'
Date: Thu, 29 Aug 2013 21:15:03 +0200
Message-ID: <vpqli3kpavc.fsf@anie.imag.fr>
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
X-From: git-owner@vger.kernel.org Thu Aug 29 21:15:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF7hB-000298-HD
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 21:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756894Ab3H2TPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 15:15:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41155 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756353Ab3H2TPK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 15:15:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7TJF1Jt012913
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 21:15:01 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VF7gO-0003Ie-4i; Thu, 29 Aug 2013 21:15:04 +0200
In-Reply-To: <521f998d25eb4_174378fe7481879@nysa.mail> (Felipe Contreras's
	message of "Thu, 29 Aug 2013 13:57:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 29 Aug 2013 21:15:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7TJF1Jt012913
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378408502.45423@0nb6YDGr697UCR3nB9nsSw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233345>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Matthieu Moy wrote:
>> These explanations make sense. I think it would be better to put part of
>> it in commit messages, so that future contributors can "git blame" the
>> doc/implem of these --stage and find them (i.e. avoid the
>> misunderstanding that occured with "git stage" command which was
>> proposed for removal).
>
> Yes, but which commit? All of them? Perhaps it would make sense to add a link
> to the cover e-mail, or add an explanation in Documentation/gitstagingarea.txt
> or something.

Putting the explanation about --stage in the first commit about it, and
then saying something like "continue the work on --stage" in the next
messages would make sense to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
