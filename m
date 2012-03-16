From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase -i: inform the user they can re-order commits
Date: Fri, 16 Mar 2012 15:12:39 +0100
Message-ID: <vpqaa3geiso.fsf@bauges.imag.fr>
References: <4F63205A.6000202@seap.minhap.es> <vpqlin0n8w5.fsf@bauges.imag.fr>
	<7vty1oivub.fsf@alter.siamese.dyndns.org>
	<4F63571D.4070405@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri Mar 16 15:13:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8Xue-0004WH-Dy
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 15:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422752Ab2CPONn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 10:13:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40993 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161140Ab2CPONm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 10:13:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q2GE8SVF001351
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 16 Mar 2012 15:08:30 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S8XtX-0006wz-V3; Fri, 16 Mar 2012 15:12:40 +0100
In-Reply-To: <4F63571D.4070405@seap.minhap.es> (Nelson Benitez Leon's message
	of "Fri, 16 Mar 2012 16:07:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 16 Mar 2012 15:08:30 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2GE8SVF001351
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332511711.40074@zPkTpsl3L5/Z0bPDDCyQbQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193266>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> On 03/16/2012 01:17 PM, Junio C Hamano wrote:
>> If the user does not even know that one of the primary use of the command
>> is to reorder, isn't he playing with fire?
>
> In an ideal world everybody should study the manpages and documentation of
> a program prior to using it, unfortunately most people often start with an
> easy-to-follow tutorial where there are commands to type in, the user
> will type them (confident in the tutorial reputation) and try to learn along
> the way, in this case giving the user more indications about what he can 
> do in any moment is, in my opinion, a good thing (as git already does). 

The case of "rebase" is a bit different, since "rebase" is potentially
dangerous.

But if the user sees the help message of "rebase -i", then I don't think
we will stop him from breaking anything by not mentionning that
reordering commits can work. We already give other commands that rewrite
history with more or less danger, so the additional messages isn't
really harmful.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
