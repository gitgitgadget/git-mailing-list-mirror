From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v16 00/14] port tag.c to use ref-filter APIs
Date: Mon, 07 Sep 2015 08:42:32 +0200
Message-ID: <vpqfv2q91d3.fsf@anie.imag.fr>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
	<xmqqh9n6agcf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 08:42:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYq8m-0003sV-T6
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 08:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbbIGGmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 02:42:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37244 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbbIGGmm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 02:42:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t876gVth015392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 7 Sep 2015 08:42:31 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t876gWe7006553;
	Mon, 7 Sep 2015 08:42:32 +0200
In-Reply-To: <xmqqh9n6agcf.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sun, 06 Sep 2015 23:33:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 07 Sep 2015 08:42:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t876gVth015392
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1442212956.52675@fyOdTwmdF8Z0n9pldMs7Aw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277446>

Junio C Hamano <gitster@pobox.com> writes:

> I am flexible with the terminology, but the point is that I think
> the quoting rules are better be specified _outside_ the description
> of a particular atom, but as a general rule.

I agree, but for now we have only one %($open) ... %(end) pair, so it
makes sense to me to leave the series as-is and to move some of the
explanations in a general section in the next series (that will
introduce %(if) or another opening atom).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
