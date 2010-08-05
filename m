From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/5] diff: parse separate options like -S foo
Date: Thu, 05 Aug 2010 14:24:13 +0200
Message-ID: <vpqfwytxn6a.fsf@bauges.imag.fr>
References: <vpqmxt14gjt.fsf@bauges.imag.fr>
	<1280996576-1165-1-git-send-email-Matthieu.Moy@imag.fr>
	<m3zkx1ntkk.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 14:24:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgzVG-0008U1-Rl
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 14:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760250Ab0HEMYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 08:24:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52029 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755733Ab0HEMYt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 08:24:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o75CDdAw004446
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Aug 2010 14:13:39 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OgzUb-00013F-Fw; Thu, 05 Aug 2010 14:24:13 +0200
In-Reply-To: <m3zkx1ntkk.fsf@localhost.localdomain> (Jakub Narebski's message of "Thu\, 05 Aug 2010 05\:16\:38 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 05 Aug 2010 14:13:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o75CDdAw004446
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281615221.75869@cYHKzWHzGEWGZhVXq1ak4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152652>

Jakub Narebski <jnareb@gmail.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> +static inline int short_opt(char opt, const char **argv,
>> +			    const char **optarg)
> [...]
>> +int parse_long_opt(const char *opt, const char **argv,
>> +		   const char **optarg)
>
> Just a nitpick question: why it is 'parse_long_opt' but just
> 'short_opt'?

I initially made *_long_opt prefixed with something (diff_ in my first
version) because it's global, while short_opt is static.
parse_short_opt is already taken in parse-option.c, so I'd rather
avoid re-using it (it's static there, so technically, we can,
but ...).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
