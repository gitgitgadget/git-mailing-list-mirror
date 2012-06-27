From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/5] git-remote-mediawiki: don't compute the diff when getting commit message
Date: Wed, 27 Jun 2012 10:32:43 +0200
Message-ID: <vpqfw9h9mtw.fsf@bauges.imag.fr>
References: <1340726673-25496-1-git-send-email-Matthieu.Moy@imag.fr>
	<1340726673-25496-2-git-send-email-Matthieu.Moy@imag.fr>
	<7v8vfac6dn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Pavel.Volek@ensimag.imag.fr,
	Kim-Thuat.Nguyen@ensimag.imag.fr, roucherj@ensimag.imag.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 10:33:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjngV-0006sh-1P
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 10:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab2F0IdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 04:33:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40534 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168Ab2F0Icz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 04:32:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5R8W0nK012697
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 27 Jun 2012 10:32:00 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sjng4-0002Nu-Aj; Wed, 27 Jun 2012 10:32:44 +0200
In-Reply-To: <7v8vfac6dn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 26 Jun 2012 10:47:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 27 Jun 2012 10:32:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5R8W0nK012697
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1341390726.54641@4ixSacuIl6oqifZN3DHBNg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200704>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> ---
>
> Not signed off yet?

My bad, I broke my email-sending alias.

>>  contrib/mw-to-git/git-remote-mediawiki | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
>> index a34f53f..a8e6287 100755
>> --- a/contrib/mw-to-git/git-remote-mediawiki
>> +++ b/contrib/mw-to-git/git-remote-mediawiki
>> @@ -874,8 +874,7 @@ sub mw_push_revision {
>
> Curious.  The hunk replaces an old line with a new one, but somehow
> claims to reduce 8 to 7 by one???

I (mis-)tweaked the patch manually. Anyway, a better/simpler one is
comming ;-).

Sorry for the noise.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
