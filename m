From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 1/2] add `config_set` API for caching config-like files
Date: Thu, 10 Jul 2014 13:23:09 +0200
Message-ID: <vpq1tttwj8i.fsf@anie.imag.fr>
References: <1404903454-10154-1-git-send-email-tanayabh@gmail.com>
	<1404903454-10154-2-git-send-email-tanayabh@gmail.com>
	<vpq61j6d92z.fsf@anie.imag.fr> <53BD3805.40504@gmail.com>
	<vpqion68viq.fsf@anie.imag.fr> <53BD68D5.7000503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 13:23:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5CRa-000499-0R
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 13:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbaGJLXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 07:23:14 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35826 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbaGJLXN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 07:23:13 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6ABN8WR029953
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Jul 2014 13:23:08 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6ABN9pb005504;
	Thu, 10 Jul 2014 13:23:09 +0200
In-Reply-To: <53BD68D5.7000503@gmail.com> (Tanay Abhra's message of "Wed, 09
	Jul 2014 21:37:49 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 10 Jul 2014 13:23:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6ABN8WR029953
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1405596189.61174@+tkomDWIEC63xQ244wOD9g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253185>

Tanay Abhra <tanayabh@gmail.com> writes:

> Noted, still I want to add that even when GSoC finishes, I won't leave the
> work unfinished. I had said that I wanted to continue being part of the Git
> community and I mean that. :)

This is a good thing, but you shouldn't rely on it for your GSoC. After
the GSoC finishes, you will have much less time for Git.

> I have to decide on what to do next on moving the contents to config.c or not.
> Seeing Junio's comments on the topic seems that he wasn't convinced in the
> first place that we needed a new file. What should we do, as I am sending the
> revised patch tomorrow? The move will be trivial, just cutting and pasting the
> contents. Other approaches you mentioned are also doable but, after a certain
> amount of retooling. I am open to any method you think would be best.

No strong opinion from me here. I like splitting stuff into relatively
small files, and to me it makes sense to keep the parsing code and the
caching code separate (although config-hash.c is no longer a good name,
config-set.c or config-cache.c would be better). But I can for sure live
with both in the same file.

I guess you'll have to make the decision if others don't give better
argument ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
