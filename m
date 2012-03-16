From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward errors
Date: Fri, 16 Mar 2012 09:19:54 +0100
Message-ID: <vpqzkbh555h.fsf@bauges.imag.fr>
References: <20120313232256.GA49626@democracyinaction.org>
	<7vobrzst7n.fsf@alter.siamese.dyndns.org>
	<20120314121434.GB28595@in.waw.pl> <vpqobrzgww9.fsf@bauges.imag.fr>
	<20120314142752.GD28595@in.waw.pl> <20120315085426.GA11003@ecki>
	<7vfwd9kacd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Clemens Buchacher <drizzd@aon.at>,
	Zbigniew =?utf-8?Q?J=C4=99drzejews?= =?utf-8?Q?ki-Szmek?= 
	<zbyszek@in.waw.pl>, Christopher Tiwald <christiwald@gmail.com>,
	git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 09:20:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8SOz-0001H3-16
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 09:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647Ab2CPIUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 04:20:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40507 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759576Ab2CPIUc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 04:20:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q2G8FNoS026928
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 16 Mar 2012 09:15:23 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S8SOB-0006Dj-4D; Fri, 16 Mar 2012 09:19:55 +0100
In-Reply-To: <7vfwd9kacd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 15 Mar 2012 11:06:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 16 Mar 2012 09:15:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2G8FNoS026928
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332490527.38514@wbI7O1FKSxMhjfMa8KpWnA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193244>

Junio C Hamano <gitster@pobox.com> writes:

> Oh, wait.  Perhaps the advice messages are designed to be declined only by
> the user who do understand, so perhaps it is a *good* think that we do not
> mention how to squelch in the message.  In a twisted way, the logic sort
> of makes sense.

I'd be against having a detailed message with the cut-and-paste ready
command to decline the message, as the messages would become long and
annoying, so people would disable it too early.

But having a short mention like "(to squelch this message, set
advice.bla)", short enough not to be disturbing, and vague enough to
force people to read the docs.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
