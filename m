From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [WIP/PATCH v5 05/10] for-each-ref: introduce 'ref_array_clear()'
Date: Mon, 08 Jun 2015 18:26:23 +0200
Message-ID: <vpqbngq2mkw.fsf@anie.imag.fr>
References: <55729B78.1070207@gmail.com>
	<1433574581-23980-1-git-send-email-karthik.188@gmail.com>
	<1433574581-23980-5-git-send-email-karthik.188@gmail.com>
	<vpqvbey6yli.fsf@anie.imag.fr> <5575B25A.6020608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:26:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1zsi-0001BM-Qd
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbbFHQ02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 12:26:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39025 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385AbbFHQ00 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 12:26:26 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t58GQMld003186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Jun 2015 18:26:22 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t58GQNk2008625;
	Mon, 8 Jun 2015 18:26:23 +0200
In-Reply-To: <5575B25A.6020608@gmail.com> (Karthik Nayak's message of "Mon, 08
	Jun 2015 20:48:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 08 Jun 2015 18:26:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t58GQMld003186
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434385582.48606@hauWkb6B/P48ShqtJCP9mw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271068>

Karthik Nayak <karthik.188@gmail.com> writes:

> On 06/08/2015 08:23 PM, Matthieu Moy wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>> > +/* Free all memory allocated for ref_array */
>> > +void ref_array_clear(struct ref_array *array)
>>
>> Is this a private function? If so, then add static. If not, you probably
>> want to export it in a .h file.
>>
> It is in ref-filter.h.

Ah, OK. It comes later in the series.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
