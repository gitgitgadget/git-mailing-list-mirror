From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 0/8] Introduce publish tracking branch
Date: Fri, 11 Apr 2014 20:49:39 +0200
Message-ID: <vpqeh13aegs.fsf@anie.imag.fr>
References: <1397239151-2391-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 20:53:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYgZu-0003XS-6g
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 20:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbaDKSxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 14:53:25 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36947 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754630AbaDKSxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 14:53:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3BInbui024339
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Apr 2014 20:49:37 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3BIndHE006890;
	Fri, 11 Apr 2014 20:49:39 +0200
In-Reply-To: <1397239151-2391-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 11 Apr 2014 12:59:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 11 Apr 2014 20:49:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3BInbui024339
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1397846981.10732@jiBhpXudPjN+NCT3n/lHLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246128>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> * Override other configurations (such as push.default)

I think I convinced myself that this is the right way to go since my
last message. After all, "push.default" is, by definition, just a
default.

> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -764,6 +764,13 @@ branch.<name>.mergeoptions::
>  	option values containing whitespace characters are currently not
>  	supported.
>  
> +branch.<name>.push::
> +	Defines, together with branch.<name>.pushremote, the publish branch for
> +	the given branch. It tells 'git push' which branch to push to, and
> +	overrides any other configurations, such as push.default. It also tells
> +	commands such as 'git status' and 'git branch' which remote branch to
> +	use for tracking information (commits ahead and behind).
> +

Good.

I think this text should mention the @{publish} shorthand too. Stg like
"This branch can be refered to as @{publish} when specifying revision
(see linkgit:gitrevisions[7])."

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
