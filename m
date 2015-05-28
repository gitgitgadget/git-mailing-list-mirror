From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/WIP v3 2/4] for-each-ref: introduce new structures for better organisation
Date: Thu, 28 May 2015 22:41:03 +0200
Message-ID: <vpq8uc8l9k0.fsf@anie.imag.fr>
References: <5567527A.6090607@gmail.com>
	<1432835025-13291-2-git-send-email-karthik.188@gmail.com>
	<vpqegm0o3dx.fsf@anie.imag.fr> <55677C7F.6080400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 22:41:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy4cB-0004UI-Ej
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 22:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbbE1UlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 16:41:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38225 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754781AbbE1UlH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 16:41:07 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SKf0ek013731
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 May 2015 22:41:00 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SKf3UT017985;
	Thu, 28 May 2015 22:41:03 +0200
In-Reply-To: <55677C7F.6080400@gmail.com> (Karthik Nayak's message of "Fri, 29
	May 2015 02:07:19 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 28 May 2015 22:41:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4SKf0ek013731
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433450461.87206@z2S0qxHgkktUE415J42mzw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270195>

Karthik Nayak <karthik.188@gmail.com> writes:

> On 05/29/2015 01:56 AM, Matthieu Moy wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> Rename 'refinfo' to 'ref_array_item' and intoduce 'ref_filter_cbdata'
>>
>> The fact that you need to use "and" to describe your changes is a hint
>> that you can split better.
>>
>
> But the patch alone wouldn't make much sense here, as the whole idea
> is the introduction of the new structures and renaming 'refinfo' to
> ref_array_item' was more of a byproduct to go along with the new
> structures introduced.

The point of separating them is that the rename implies a relatively
long patch (you have 17 occurences of 'refinfo' in the deletion part of
your patch), but it is straightforward to review (apply, run "git diff
--color-words" and press space a few times). But it is no longer so
simple once you mix it with anything else.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
