From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [WIP/PATCH v4 8/8] ref-filter: add 'ref-filter.h'
Date: Mon, 01 Jun 2015 08:47:11 +0200
Message-ID: <vpqiob8hqmo.fsf@anie.imag.fr>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-8-git-send-email-karthik.188@gmail.com>
	<CAPig+cR88O=STcJDrB+96uJ0Y60mO49QxoJfbOY8Xk4hPvNxGA@mail.gmail.com>
	<556AC40C.5020205@gmail.com> <vpqlhg4jx0d.fsf@anie.imag.fr>
	<556B740A.5030404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 08:47:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzJVN-0005c1-Tg
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 08:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbbFAGrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 02:47:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40976 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbbFAGrU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 02:47:20 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t516lBQc019163
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Jun 2015 08:47:11 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t516lBBk006953;
	Mon, 1 Jun 2015 08:47:11 +0200
In-Reply-To: <556B740A.5030404@gmail.com> (Karthik Nayak's message of "Mon, 01
	Jun 2015 02:20:18 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 01 Jun 2015 08:47:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t516lBQc019163
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433746035.33853@ad6f+Kd1AhWW6kHRSk0Zhg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270377>

Karthik Nayak <karthik.188@gmail.com> writes:

> On 06/01/2015 02:16 AM, Matthieu Moy wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>> > That is kind of a problem, If I need to swap those commits also, I'd
>> > have to add the part where ref-filter is added to the Makefile with
>> > the code movement from for-each-ref to ref-filter. This again will not
>> > just be Code movement.
>>
>> You can have a preparatory patch that adds ref-filter.c containing just
>> "#include ref-filter.h" and ref-filter.h with proper content. After this
>> preparatory patch, you're in a rather silly situation because you have
>> an almost empty .c file, but it's still passing all tests and
>> compileable.
>>
>> Then, the next patch can be just code movement.
>>
> Would it be okay, If I just include the Makefile addition along with the code movement
> from 'for-each-ref' to 'ref-filter.c' like Eric suggested?

I prefer pure code movement, but as Eric said it's also OK to have small
other changes as long as they are related (so it makes sense to include
them in the same commit) and separate (in your case, they touch
different files so it's easy to notice the Makefile change in the
patch).

In any case, because I prefer one way doesn't mean it's the only way or
even that it's the right way.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
