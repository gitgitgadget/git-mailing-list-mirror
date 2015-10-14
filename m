From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] Broken links in Git Documentation/user-manual.txt
Date: Wed, 14 Oct 2015 09:37:05 +0200
Message-ID: <vpqk2qp52am.fsf@grenoble-inp.fr>
References: <CAAF+z6F3Yej0ByAL1bGnG7qGRLz_HnpwVRqFVVHiMOebNRmSmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Xue Fuqiao <xfq.free@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 09:37:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmGcb-0006nc-UU
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 09:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbbJNHhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 03:37:09 -0400
Received: from mx1.imag.fr ([129.88.30.5]:32962 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbbJNHhI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 03:37:08 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9E7b4te021767
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 14 Oct 2015 09:37:04 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9E7b5ll020026;
	Wed, 14 Oct 2015 09:37:05 +0200
In-Reply-To: <CAAF+z6F3Yej0ByAL1bGnG7qGRLz_HnpwVRqFVVHiMOebNRmSmA@mail.gmail.com>
	(Xue Fuqiao's message of "Wed, 14 Oct 2015 08:52:36 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 14 Oct 2015 09:37:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9E7b4te021767
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445413025.23651@26U+6KvHigsZ8zAYWMY9Pw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279563>

Xue Fuqiao <xfq.free@gmail.com> writes:

> Hi list,
>
> In https://git-scm.com/docs/user-manual.html , all links to the
> glossary[1] are broken.

Actually, the links themselves are fine, but the destimation is broken.

The doc is supposed to look like this :

  https://www.kernel.org/pub/software/scm/git/docs/user-manual.html#def_head

with the glossary at the end. On
https://git-scm.com/docs/user-manual.html, the glossary is displayed as
verbatim text.

This does not seem to be a bug in our user-manual.txt, but in the way
it's processed by git-scm.com.

I reported the issue there:

https://github.com/git/git-scm.com/issues/605

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
