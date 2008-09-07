From: Pieter de Bie <pieter@frim.nl>
Subject: Re: [RFC PATCH 0/2] Teach how to discard changes in the working directory
Date: Mon, 8 Sep 2008 01:09:05 +0200
Message-ID: <B391BF4E-22D3-4083-8DDC-CF5823467813@frim.nl>
References: <1220825103-19599-1-git-send-email-mail@cup.kalibalik.dk> <7vtzcrk1wt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 01:10:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcTOl-0003L6-9o
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 01:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbYIGXJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 19:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbYIGXJV
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 19:09:21 -0400
Received: from frim.nl ([87.230.85.232]:40370 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750910AbYIGXJU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Sep 2008 19:09:20 -0400
Received: from s5591931c.adsl.wanadoo.nl ([85.145.147.28] helo=[192.168.1.11])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pieter@frim.nl>)
	id 1KcTNc-0003Au-7n; Mon, 08 Sep 2008 01:09:16 +0200
In-Reply-To: <7vtzcrk1wt.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95190>


On 8 sep 2008, at 00:48, Junio C Hamano wrote:

> I would agree that "hint is often given in #git" is an indication that
> people do not know "git checkout" to check out the path from the  
> index to
> get rid of the change.  I further suspect that "I modified my file  
> and git
> status says 'Changed but not updated'; what should I do" may not be  
> asked
> often anymore, which might owe the hint we have in status output.   
> Even
> then, I do not necessarily agree that the status output (yes, I am  
> also
> questioning the existing hints as well) is the best place to teach  
> these
> people.

Yes, this seems unclear to a lot of people. How about a small and  
focused
man-page or similar to help people explain the differences between the
working directory, the index and HEAD? Then we can just add something
like

	If you are unsure what to do, run `git help stage-changes`

or so. This would differ from the git-commit man-page in that there is
less clutter and most likely contains the information the user needs
at the top of the page.

- Pieter
