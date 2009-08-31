From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: clong an empty repo over ssh causes (harmless) fatal
Date: Mon, 31 Aug 2009 19:25:22 +0200
Message-ID: <vpqocpvevzx.fsf@bauges.imag.fr>
References: <slrnh9nc4e.6bn.sitaramc@sitaramc.homelinux.net>
	<vpqskf8z0rj.fsf@bauges.imag.fr>
	<2e24e5b90908310730u53ee27d3nd2b66c1f58202e7@mail.gmail.com>
	<20090831164146.GA23245@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 31 19:25:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiAdT-0007mZ-OG
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 19:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbZHaRZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 13:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbZHaRZe
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 13:25:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50092 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753301AbZHaRZd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 13:25:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n7VHNK26004790
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 31 Aug 2009 19:23:21 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MiAd8-0002DQ-K6; Mon, 31 Aug 2009 19:25:22 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MiAd8-0003Fg-In; Mon, 31 Aug 2009 19:25:22 +0200
In-Reply-To: <20090831164146.GA23245@coredump.intra.peff.net> (Jeff King's message of "Mon\, 31 Aug 2009 12\:41\:46 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 31 Aug 2009 19:23:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7VHNK26004790
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1252344202.58947@9UdxYBCmqlBgbwyQuNJk1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127489>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 31, 2009 at 08:00:41PM +0530, Sitaram Chamarty wrote:
>
>> > Maybe you have an older version of Git?
>> 
>> Had 1.6.4, just tried with 1.6.4.2 -- the error is still there, exactly so.
>> 
>> Anything I can do to provide more info?
>
> IIRC, the message you are seeing comes when the _server_ is an older
> version of git. It is harmless, though.

Since the client and server are the same machine:

    $ git clone ssh://sitaram@localhost/home/sitaram/t/a b

I'd bet Sitaram has two installations of git, and plain ssh to the
machine points to the old one (like a $PATH set in ~/.login and not
~/.profile or something like that).

-- 
Matthieu
