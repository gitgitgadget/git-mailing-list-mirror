From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 0/4] stripspace: Implement and use --count-lines option
Date: Fri, 16 Oct 2015 18:54:45 +0200
Message-ID: <vpqsi5a69ey.fsf@grenoble-inp.fr>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 16 18:55:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn8He-0006d7-2m
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 18:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbbJPQzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 12:55:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57597 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932101AbbJPQzA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 12:55:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9GGsiiP021099
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 16 Oct 2015 18:54:44 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9GGsj2n014136;
	Fri, 16 Oct 2015 18:54:45 +0200
In-Reply-To: <1445008605-16534-1-git-send-email-tklauser@distanz.ch> (Tobias
	Klauser's message of "Fri, 16 Oct 2015 17:16:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 16 Oct 2015 18:54:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9GGsiiP021099
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445619285.99974@UiYVcy0kJnXPO59qdVRYqw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279752>

Tobias Klauser <tklauser@distanz.ch> writes:

>   - Split patch 2/3 into two patches: patch 2/4 switches git stripspace
>     to use parse-options and patch 3/4 introduces the new option.

Much better now.

>   - Implement line counting in cmd_stripbuf() instead of (ab-)using
>     strbuf_stripspace() for it.

Also short and sweet, I like it.

>   - Drop -C short option
>   - Correct example command output in documentation.
>   - Adjust commit messages to not include links to the wiki, fully
>     describe the motivation in the commit message instead.

Good.

I read the patches again, and the whole series is now

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
