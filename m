From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/4] for-each-ref: rename refinfo members to match similar structures
Date: Wed, 20 May 2015 18:57:45 +0200
Message-ID: <vpqtwv7qj92.fsf@anie.imag.fr>
References: <555C88C2.8060902@gmail.com>
	<1432127904-21070-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 18:58:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv7Jp-0005pX-N7
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 18:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbbETQ6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 12:58:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35301 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754466AbbETQ6B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 12:58:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4KGvi0a021593
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 20 May 2015 18:57:44 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4KGvjl2019759;
	Wed, 20 May 2015 18:57:45 +0200
In-Reply-To: <1432127904-21070-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Wed, 20 May 2015 18:48:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 20 May 2015 18:57:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4KGvi0a021593
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1432745866.32217@wS+1AFQr726d3teQH743Dg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269471>

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Jeff King <peff@peff.net>

This means that "git am" will consider Peff as the author ...

> Written-by: Jeff King <peff@peff.net>

... hence this is not needed: in the final history, it will appear as if
Peff wrote this Written-by: himself, which would be weird.

If it is the case, you should add in the commit message that there's no
actual changs, and perhaps which renames were done. This makes the
review straightforward.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
