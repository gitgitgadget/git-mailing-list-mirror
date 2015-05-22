From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/4] ref-filter: add ref-filter API
Date: Fri, 22 May 2015 08:44:47 +0200
Message-ID: <vpqbnhd157k.fsf@anie.imag.fr>
References: <555C88C2.8060902@gmail.com>
	<1432127904-21070-2-git-send-email-karthik.188@gmail.com>
	<vpqr3qagvv6.fsf@anie.imag.fr> <555E1CE7.8090507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 08:44:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvghT-0000sM-NP
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 08:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756026AbbEVGov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 02:44:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36171 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbbEVGou (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 02:44:50 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4M6ikba011427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 May 2015 08:44:46 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4M6ilUw018086;
	Fri, 22 May 2015 08:44:47 +0200
In-Reply-To: <555E1CE7.8090507@gmail.com> (karthik nayak's message of "Thu, 21
	May 2015 23:29:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 22 May 2015 08:44:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4M6ikba011427
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1432881888.08906@DVxVRYfHa/JMB2pXsO9/SQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269694>

karthik nayak <karthik.188@gmail.com> writes:

>> I miss a high-level description of what the code is doing. Essentially,
>> there's the complete repository list of refs, and you want to filter
>> only some of them, right?
>>
>>  From the name, I would guess that ref_filter is the structure describing
>> how you are filtering, but from the code it seems to be the list you're
>> filtering, not the filter.
>
> Reading this again, A bit confused by what you're trying to imply.
> Could you rephrase please?

At some point, I'd expect something like

  filtered_list_of_refs = filer(full_list_of_refs, description_of_filter);

That would remove some refs from full_list_of_refs according to
description_of_filter.

(totally invented code, only to show the idea)

If there's a piece of code looking like this, then you need a data
structure to store list of refs (full_list_of_refs and
filtered_list_of_refs) and another to describe what you're doing with it
(description_of_filter).

The name ref_filter implies to me that it contains the description of
the filter, but looking at the code it doesn't seem to be the case.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
