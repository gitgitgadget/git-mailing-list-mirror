From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] Add userdiff built-in pattern for CSS code
Date: Thu, 19 May 2016 16:45:01 +0200 (CEST)
Message-ID: <840800650.10903639.1463669101272.JavaMail.zimbra@imag.fr>
References: <20160519100625.7945-1-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	matthieu moy <matthieu.moy@grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 19 16:45:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3PCU-0006Pj-G5
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 16:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbcESOpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 10:45:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50882 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754264AbcESOpO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 10:45:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4JEixcU028906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 19 May 2016 16:45:00 +0200
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4JEj1Xc032530;
	Thu, 19 May 2016 16:45:01 +0200
In-Reply-To: <20160519100625.7945-1-william.duclot@ensimag.grenoble-inp.fr>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF45 (Linux)/8.0.9_GA_6191)
Thread-Topic: Add userdiff built-in pattern for CSS code
Thread-Index: 6zqOwcFLhhP2rUyr6nc5O6VmlUkAxw==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 19 May 2016 16:45:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4JEixcU028906
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1464273904.19535@WLFPUF5TLQFlYS/A1yvO4g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295065>

> Subject: [PATCH/RFC] Add userdiff built-in pattern for CSS code

We normally write subject lines as "<subsystem>: <description",
hence that would be:

userdiff: add built-in pattern for CSS

william.duclot@ensimag.grenoble-inp.fr wrote:
> CSS is widely used, motivating it being included as a built-in pattern.
> It must be noted that the word_regex for CSS (i.e. the regex defining what is
> a word in the language) does not consider '.' and '#' characters (in CSS
> selectors) to be part of the word. This behavior is documented by the test
> t/t4018/css-rule.

This text wasn't properly wrapped. Please wrap around 72 columns (M-q on Emacs,
or google "text wrap $youreditor" for others).

Also, saying _what_ your patch does is not the most important question here.
Focus on the _why_ in the commit message.

(We had a real-life off-list discussion about this and I agree that it's a
sensible behavior, but others may disagree)

> Add the info in documentation that CSS is now built-in.

This doesn't add much to the patch (we can already see that from the patch
itself). I'd remove it.

Missing sign-off (yours, and you can add mine to mark the fact that I allow
you to contribute to Git as part of your student project).

> +PATTERNS("css",
> +	 "^([^,{}]+)((,[^}]*\\{)|([ \t]*\\{))$",
> +	 /* -- */
> +	 /* This regex comes from W3C CSS specs. Should theorically also allow ISO

s/theorically/theoretically/

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
