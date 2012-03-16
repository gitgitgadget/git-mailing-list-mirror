From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Fri, 16 Mar 2012 13:42:36 +0100
Message-ID: <vpqhaxohg3n.fsf@bauges.imag.fr>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
	<1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
	<20120316085152.GA22273@ecki> <vpq1uosswwz.fsf@bauges.imag.fr>
	<7vy5r0iwdb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 13:43:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8WUn-0000Bu-T9
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 13:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759223Ab2CPMmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 08:42:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60935 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab2CPMmv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 08:42:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q2GCcQXu016982
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 16 Mar 2012 13:38:26 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S8WUP-0004gx-PQ; Fri, 16 Mar 2012 13:42:37 +0100
In-Reply-To: <7vy5r0iwdb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 16 Mar 2012 05:05:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 16 Mar 2012 13:38:26 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2GCcQXu016982
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332506308.46268@79oh892rB1NwsQxM1yrOUA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193258>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> I'd count "upstream is not set" as "current and upstream agree on
>> 'current'". IOW, use "current", but error out if there's a configured
>> upstream that is different.
>
> And if there is no configured upstream, should it error out, or should it
> just push the current one to its own name?

I meant just push the current one to its own name.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
