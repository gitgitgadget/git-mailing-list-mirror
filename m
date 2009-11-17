From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Expand ~ and ~user in core.excludesfile, commit.template
Date: Tue, 17 Nov 2009 09:53:52 +0100
Message-ID: <vpqpr7hpm5b.fsf@bauges.imag.fr>
References: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
	<20091117073426.GB4007@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Karl Chen <quarl@quarl.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 17 09:54:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAJpm-0004Ey-Sh
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 09:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbZKQIyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 03:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbZKQIyS
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 03:54:18 -0500
Received: from mx1.imag.fr ([129.88.30.5]:37093 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824AbZKQIyR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 03:54:17 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nAH8qYfE011342
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Nov 2009 09:52:34 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NAJou-0003IH-PC; Tue, 17 Nov 2009 09:53:52 +0100
In-Reply-To: <20091117073426.GB4007@coredump.intra.peff.net> (Jeff King's message of "Tue\, 17 Nov 2009 02\:34\:26 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 17 Nov 2009 09:52:34 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nAH8qYfE011342
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1259052755.42151@G42YE22Df5Sq2aFAtlGaWw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133079>

Jeff King <peff@peff.net> writes:

> On Mon, Nov 16, 2009 at 11:07:40AM +0100, Matthieu Moy wrote:
>
>> +	of files which are not meant to be tracked.  "~" and "~user"
>> +	are expanded to the user's home directory.  See
>>  	linkgit:gitignore[5].
>
> Reading this, it is not clear to me if:
>
>   1. "~" and "~user" are expanded to the home directory of "user", where
>      "user" is the user running git
>
> or
>
>   2. "~" is expanded to the home directory of the user running git, and
>      an arbitrary "~user" is expanded to that user's home directory.
>
> I would expect (2), since that is how everything else works.

Yes. "user" in the sentence is either the user running Git or the same
string as "user" in "~user". I'm not against your proposal, but I'm
afraid we're making the sentence uselessly heavy, since, as you say,
this ~ and ~user convention is widely spread, and I hardly imagine
someone interpreting the sentence as "if you say ~foo, it will expand
to the home directory of bar".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
