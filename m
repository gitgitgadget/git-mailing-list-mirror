From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 10/11] branch.c: use 'ref-filter' APIs
Date: Wed, 29 Jul 2015 17:56:27 +0200
Message-ID: <vpq3807gdp0.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438067468-6835-1-git-send-email-Karthik.188@gmail.com>
	<vpqh9oov017.fsf@anie.imag.fr>
	<CAOLa=ZR6Cu_AgB4sOBX3Tf_M0w8XN57ej8d_fZo+h7pwFDZs+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 17:56:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTik-000575-0v
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 17:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbbG2P4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 11:56:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56256 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291AbbG2P4f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 11:56:35 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6TFuPSl010477
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 29 Jul 2015 17:56:25 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TFuRA4021031;
	Wed, 29 Jul 2015 17:56:27 +0200
In-Reply-To: <CAOLa=ZR6Cu_AgB4sOBX3Tf_M0w8XN57ej8d_fZo+h7pwFDZs+A@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 29 Jul 2015 21:07:43 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 29 Jul 2015 17:56:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6TFuPSl010477
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438790189.68923@SJ/UAAWL9qLSvX9jyfHAyQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274910>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Tue, Jul 28, 2015 at 7:47 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>
>> I'm not sure what's the convention, but I think the test description
>> should give the expected behavior even with test_expect_failure.
>>
>> And please help the reviewers by saying what's the status wrt this test
>> (any plan on how to fix it?).
>>
>
> On the other hand I wonder if the test is even needed as, we don't
> really need it
> Cause we remove that ability of branch.c by using filter_refs().

Please read d0f810f (refs.c: allow listing and deleting badly named
refs, 2014-09-03). I think the reasoning makes sense, and we should keep
this ability.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
