From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 05/12] for-each-ref: introduce new structures for better organisation
Date: Thu, 11 Jun 2015 21:47:30 +0200
Message-ID: <vpqbngmni25.fsf@anie.imag.fr>
References: <5579B253.4020804@gmail.com>
	<1434039003-10928-1-git-send-email-karthik.188@gmail.com>
	<1434039003-10928-5-git-send-email-karthik.188@gmail.com>
	<vpqwpzarvl6.fsf@anie.imag.fr> <5579CBE0.3050301@gmail.com>
	<vpq4mmeqcrr.fsf@anie.imag.fr> <5579DFC0.6030002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 21:47:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z38S1-0000Fs-U9
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 21:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165AbbFKTrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 15:47:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53745 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754658AbbFKTri (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 15:47:38 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5BJlSEZ025419
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Jun 2015 21:47:28 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5BJlUdB018308;
	Thu, 11 Jun 2015 21:47:30 +0200
In-Reply-To: <5579DFC0.6030002@gmail.com> (Karthik Nayak's message of "Fri, 12
	Jun 2015 00:51:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 11 Jun 2015 21:47:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5BJlSEZ025419
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434656850.70839@PNRHXzF/HDWagYGrKFCmHA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271458>

Karthik Nayak <karthik.188@gmail.com> writes:

>> ... but after PATCH 7, filter and array are passed to ref_filter so you
>> don't have this overhead anyway. Makes sense.
>>
> Yes, there we wouldn't have a ref_cbdata in 'for-each-ref'.
> But this would be taken care of in 'filter_refs()'.
> "Makes sense." Not sure if you're agreeing with me or you want me to
> re-roll.

I'm agreeing with you.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
