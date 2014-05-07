From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Standardize python shebangs
Date: Wed, 07 May 2014 22:57:13 +0200
Message-ID: <vpq1tw5nw7q.fsf@anie.imag.fr>
References: <1399456987-24156-1-git-send-email-felipe.contreras@gmail.com>
	<vpqy4ydpiog.fsf@anie.imag.fr>
	<536a842838fbb_76ff7a52ec5d@nysa.notmuch>
	<vpqr445nxrw.fsf@anie.imag.fr>
	<536a9a34e8194_76ff7a52ec7f@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 22:57:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8u6-0001Dj-LL
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbaEGU5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:57:23 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49925 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbaEGU5W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:57:22 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s47KvBkb022323
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 May 2014 22:57:11 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s47KvDxY000534;
	Wed, 7 May 2014 22:57:13 +0200
In-Reply-To: <536a9a34e8194_76ff7a52ec7f@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 07 May 2014 15:40:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 07 May 2014 22:57:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s47KvBkb022323
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1400101036.1368@qZeNJOo+UOqTB4PIHfFNFQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248374>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Matthieu Moy wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> > If you want to use python2, then use '/usr/bin/env python2'.
>> 
>> Err, yes, this is what the code does before your patch.
>
> Not for all the instances.

Well, I guess not all scripts require python2, hence not all scripts
declare that they depend on python2.

And anyway, I don't see how changing python2 to python in git-multimail
solves any problem.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
