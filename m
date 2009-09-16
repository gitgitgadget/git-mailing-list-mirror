From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] archive: Refuse to write the archive to a terminal.
Date: Wed, 16 Sep 2009 14:57:39 +0200
Message-ID: <vpq8wgfm4ho.fsf@bauges.imag.fr>
References: <20090916103129.GA21430@feather> <4AB0C7DE.7030109@viscovery.net>
	<237967ef0909160427m4d7de120tf5ef3176f75123ad@mail.gmail.com>
	<3f4fd2640909160448x1fbb7a64s1ce0adca2af5010@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 14:58:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnu5I-00008J-QE
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 14:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbZIPM5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 08:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426AbZIPM5s
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 08:57:48 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48084 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787AbZIPM5s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 08:57:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n8GCrVhY030444
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Sep 2009 14:53:31 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mnu4p-0004tX-UJ; Wed, 16 Sep 2009 14:57:39 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mnu4p-0005dW-Sg; Wed, 16 Sep 2009 14:57:39 +0200
In-Reply-To: <3f4fd2640909160448x1fbb7a64s1ce0adca2af5010@mail.gmail.com> (Reece Dunn's message of "Wed\, 16 Sep 2009 12\:48\:15 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 16 Sep 2009 14:53:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8GCrVhY030444
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1253710413.55145@wa37iZl6MmPCMP4/ss5Qag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128650>

Reece Dunn <msclrhd@googlemail.com> writes:

> 2009/9/16 Mikael Magnusson <mikachu@gmail.com>:
>> 2009/9/16 Johannes Sixt <j.sixt@viscovery.net>:
>>> Josh Triplett schrieb:
>>>> I considered adding a -f/--force option, like gzip has, but writing an
>>>> archive to a tty seems like a sufficiently insane use case that I'll let
>>>> whoever actually needs that write the patch for it. ;)
>>>
>>> How about '--output -' instead?
>>
>> You could always just add '|cat'.
>
> Except when running on Windows. Yes MSYS and cygwin provide a version
> of cat, but this cannot be guaranteed (e.g. with the series to support
> building with MSVC).

In general, autodectection features sometimes fail, so it's good to
have an explicit override option.

> The `--output -` / `-o -` syntax looks reasonable

I like this too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
