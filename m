From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] expand_user_path: expand ~ to $HOME, not to the actual homedir.
Date: Thu, 19 Nov 2009 17:32:56 +0100
Message-ID: <vpq7htma30n.fsf@bauges.imag.fr>
References: <1258534693-7220-1-git-send-email-Matthieu.Moy@imag.fr>
	<1258644075-16191-1-git-send-email-Matthieu.Moy@imag.fr>
	<20091119152359.GB6877@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 19 17:33:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NB9we-0002Bx-SR
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 17:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865AbZKSQdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 11:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754080AbZKSQdI
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 11:33:08 -0500
Received: from mx2.imag.fr ([129.88.30.17]:38700 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770AbZKSQdH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 11:33:07 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nAJGVofF028684
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 19 Nov 2009 17:31:50 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NB9wH-0000hn-6T; Thu, 19 Nov 2009 17:32:57 +0100
In-Reply-To: <20091119152359.GB6877@coredump.intra.peff.net> (Jeff King's message of "Thu\, 19 Nov 2009 10\:23\:59 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 19 Nov 2009 17:31:50 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nAJGVofF028684
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1259253111.12502@iYefU07cylRhdCILZjg7Yg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133236>

Jeff King <peff@peff.net> writes:

> On Thu, Nov 19, 2009 at 04:21:15PM +0100, Matthieu Moy wrote:
>
>> -	of files which are not meant to be tracked.  "~/" and "~user/"
>> -	are expanded to the specified user's home directory.  See
>> -	linkgit:gitignore[5].
>> +	of files which are not meant to be tracked.  "~/" is expanded
>> +	to the value of `$HOME` and "~user/" to the specified user's
>> +	home directory.  See linkgit:gitignore[5].
>
> Thanks. As a side effect, this wording change addresses my original
> ambiguity concern (and I also think using $HOME is the right thing to
> do).

Not a pure coincidence indeed ;-). In this new version, ~ and ~foo do
actually different things so they definitely deserve the heaviness of
a few extra words.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
