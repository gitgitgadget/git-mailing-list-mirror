From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Query: Failed to suppress CC while sending patchset
Date: Wed, 17 Sep 2014 13:31:46 +0200
Message-ID: <vpqd2aumqjh.fsf@anie.imag.fr>
References: <CAMf-jSkjYFEsN01DZc=Xc6qb037zeVeo4cUKDJJN-Q0Z4f6B9Q@mail.gmail.com>
	<vpqd2au20md.fsf@anie.imag.fr>
	<CAMf-jSnx_NphQ5XR5eY6B9cFLbWPhh1vJtFw5=2jXt7-30VW=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pramod Gurav <pramod.gurav.etc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 13:31:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUDSl-0007pC-Na
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 13:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbaIQLbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 07:31:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57479 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107AbaIQLbv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 07:31:51 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s8HBVjPd024901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Sep 2014 13:31:46 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s8HBVkio003358;
	Wed, 17 Sep 2014 13:31:46 +0200
In-Reply-To: <CAMf-jSnx_NphQ5XR5eY6B9cFLbWPhh1vJtFw5=2jXt7-30VW=A@mail.gmail.com>
	(Pramod Gurav's message of "Wed, 17 Sep 2014 16:59:35 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 17 Sep 2014 13:31:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s8HBVjPd024901
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1411558307.6528@MW88ypm4eMd4DrDypn+1XQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257220>

Pramod Gurav <pramod.gurav.etc@gmail.com> writes:

> Thanks Matthieu for suggestion.
>
> On Wed, Sep 17, 2014 at 12:29 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Pramod Gurav <pramod.gurav.etc@gmail.com> writes:
>>
>>> gpramod:linux-next$ git send-email --to=pramod.gurav.etc@gmail.com
>>> --suppress-cc=cc --suppress-cc=self --suppress-cc=author 000*
>>
>> I guess you lacked the --suppress-cc=bodycc.
>
> how does it differ from --suppress-cc=cc? from help I understand cc
> avoids people in Cc lines in the patch header and bodycc avoids people
> in Cc lines in the patch body?
>
> Patch body is commit message, right? What is patch header?

I don't use these options, but I would guess the "header" are the
email-like headers at the top of the generated patch, and the body is
the part after the blank lines.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
