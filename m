From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2 v2] verify_filename: ask the caller to chose the kind of diagnosis
Date: Tue, 19 Jun 2012 13:17:37 +0200
Message-ID: <vpq1ulbo8j2.fsf@bauges.imag.fr>
References: <7vvcio4mbe.fsf@alter.siamese.dyndns.org>
	<1340043501-6170-1-git-send-email-Matthieu.Moy@imag.fr>
	<1340043501-6170-2-git-send-email-Matthieu.Moy@imag.fr>
	<7vipeo2r7j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 13:17:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgwRP-0002u8-HE
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 13:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab2FSLRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 07:17:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35941 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082Ab2FSLRm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 07:17:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5JBHKih022907
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 19 Jun 2012 13:17:20 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SgwRG-0007BT-0G; Tue, 19 Jun 2012 13:17:38 +0200
In-Reply-To: <7vipeo2r7j.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 18 Jun 2012 15:25:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 19 Jun 2012 13:17:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5JBHKih022907
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340709441.15523@2eqwscuibayGd2Tzut7MTA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200197>

Junio C Hamano <gitster@pobox.com> writes:

>> @@ -80,14 +86,28 @@ static void NORETURN die_verify_filename(const char *prefix, const char *arg)
>>   * as true, because even if such a filename were to exist, we want
>>   * it to be preceded by the "--" marker (or we want the user to
>>   * use a format like "./-filename")
>> + *
>> + * The "diagnose_misspelt_rev" is used to provide a user-friendly
>> + * diagnosis. If 0, the diagnosis will try to diagnose "name" as an
>> + * invalid object name (e.g. HEAD:foo). If non-zero, the diagnosis
>> + * will only complain about an inexisting file.
>
> I have a feeling that "if 0/if non-zero" above are backwards.

Oops, right. Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
