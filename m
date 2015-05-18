From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Documentation/log: clarify what --raw means
Date: Mon, 18 May 2015 19:51:35 +0200
Message-ID: <vpqmw11vkns.fsf@anie.imag.fr>
References: <297757279.1883703.1431704571028.JavaMail.zimbra@imag.fr>
	<1431704674-18595-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqtwvdhhb2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, eda@waniasset.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 18 19:51:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuPCd-0003hA-WE
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 19:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbbERRvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 13:51:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41245 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057AbbERRvm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 13:51:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4IHpX7X014680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 18 May 2015 19:51:33 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4IHpZkq001141;
	Mon, 18 May 2015 19:51:35 +0200
In-Reply-To: <xmqqtwvdhhb2.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 15 May 2015 10:38:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 18 May 2015 19:51:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4IHpX7X014680
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1432576294.10519@Vu84Ke1pP0algmY7Y0CGww
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269284>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> There are several "raw formats", and describing --raw as "Generate the
>> raw format" in the documentation for git-log seems to imply that it
>> generates the raw *log* format.
>>
>> Clarify the wording by saying "raw diff format" explicitely, and make a
>> special-case for "git log": "git log --raw" does not just change the
>> format, it shows something which is not shown by default.
>
> Being a pedant, I find "generate the raw diff format" somewhat a
> strange wording.  Aren't we generating a diff in the raw format (as
> opposed to in other format like the textual patch format),
> generating a diff using the raw format, etc.?

I think I chose this wording because I didn't want to say "raw format"
for git-log(1), but then I added more special-cases for git-log.

I changed it to

ifndef::git-log[]
	Generate the diff in raw format.
	{git-diff-core? This is the default.}

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
