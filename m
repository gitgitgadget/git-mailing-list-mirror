From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 3/4] docs/git-credential-store: document XDG file and precedence
Date: Wed, 18 Mar 2015 17:23:36 +0100
Message-ID: <vpq3852ff5j.fsf@anie.imag.fr>
References: <1426662276-8728-1-git-send-email-pyokagan@gmail.com>
	<1426662276-8728-3-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 17:23:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYGlC-00061h-R5
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 17:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958AbbCRQXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 12:23:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52641 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755364AbbCRQXx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 12:23:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t2IGNYql002834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Mar 2015 17:23:34 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t2IGNaed016368;
	Wed, 18 Mar 2015 17:23:36 +0100
In-Reply-To: <1426662276-8728-3-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Wed, 18 Mar 2015 15:04:35 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 18 Mar 2015 17:23:35 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t2IGNYql002834
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1427300615.57822@NgMM3cEIT5Y6iytWV+an0Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265740>

I would personnally prefer to see this squashed with PATCH 2/4: pushing
the "bisectable history" principle a bit, the state between patches 2
and 3 could be considered broken because the code does not do what the
documentation says. And as a reviewer, I like having pieces of docs
linked to the patch they document.

Paul Tan <pyokagan@gmail.com> writes:

> +Credential storage will per default

Not a native, but "per default" sounds weird and "by default" seems far
more common.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
