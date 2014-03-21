From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [GSOC 2014]idea:Git Configuration API Improvement
Date: Fri, 21 Mar 2014 09:23:54 +0100
Message-ID: <vpqob10dko5.fsf@anie.imag.fr>
References: <vpqd2hh5j7k.fsf@anie.imag.fr>
	<1395350103-4899-1-git-send-email-zhaox383@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: mhagger@alum.mit.edu, peff@peff.net, git@vger.kernel.org
To: Yao Zhao <zhaox383@umn.edu>
X-From: git-owner@vger.kernel.org Fri Mar 21 09:24:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQuke-0005ap-NA
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 09:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760157AbaCUIYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 04:24:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53662 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759849AbaCUIYT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 04:24:19 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2L8NrvN021041
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 21 Mar 2014 09:23:53 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2L8NsGN031742;
	Fri, 21 Mar 2014 09:23:54 +0100
In-Reply-To: <1395350103-4899-1-git-send-email-zhaox383@umn.edu> (Yao Zhao's
	message of "Thu, 20 Mar 2014 16:15:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 21 Mar 2014 09:23:54 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2L8NrvN021041
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1395995037.38333@k0JiMj5f5JwWlJ2JL3A3rw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244681>

Yao Zhao <zhaox383@umn.edu> writes:

> Moy, thanks for explaining. You said API should be hided. Is that
> means I should indicate an arbitary feature in old version or new
> feature we added should be linked to a manipulation of inner
> structure? And I need to find the connection to make this abstraction?

Sorry, I do not understand what you mean.

The new code should be backward compatible with the old one, that is:
existing code using git_config() should continue working. There are a
lot of git_config() calls in the codebase, and a GSoC won't have time to
change them all into something new.

This does not mean we can't add new features, both on the file parsing
side (add the ability to unset a key) and on the user API side (allow
getting the value of a key more easily).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
