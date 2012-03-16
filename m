From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase -i: inform the user they can re-order commits
Date: Fri, 16 Mar 2012 15:36:24 +0100
Message-ID: <vpq3998ehp3.fsf@bauges.imag.fr>
References: <4F63205A.6000202@seap.minhap.es> <vpqlin0n8w5.fsf@bauges.imag.fr>
	<7vty1oivub.fsf@alter.siamese.dyndns.org>
	<4F63571D.4070405@seap.minhap.es> <vpqaa3geiso.fsf@bauges.imag.fr>
	<7vpqccipuv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 15:37:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8YHE-0008RX-QC
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 15:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761593Ab2CPOhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 10:37:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45032 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758592Ab2CPOhA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 10:37:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q2GEWDO3006018
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 16 Mar 2012 15:32:13 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S8YGX-0007hm-OD; Fri, 16 Mar 2012 15:36:25 +0100
In-Reply-To: <7vpqccipuv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 16 Mar 2012 07:26:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 16 Mar 2012 15:32:14 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2GEWDO3006018
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332513134.28102@Z5Ytne5kc9lgvVPuShDvUw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193268>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> But if the user sees the help message of "rebase -i", then I don't think
>> we will stop him from breaking anything by not mentionning that
>> reordering commits can work. We already give other commands that rewrite
>> history with more or less danger, so the additional messages isn't
>> really harmful.
>
> I was not questioning that "You can also reorder" is dangerous in any way.
>
> What is dangerous is to give an illusion that it is safe to use "rebase
> -i" without reading a decent documentation that does not even say that
> reordering is one of the primary purpose of the command, and the mindset
> that it is OK to give such an illusion with these reminder lines.

Yes, but my point is that you can already do that. Nelson just gave an
example when explaining how he came out with this patch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
