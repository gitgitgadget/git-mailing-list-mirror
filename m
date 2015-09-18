From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git status -u is mildly astonishing
Date: Fri, 18 Sep 2015 08:52:05 +0200
Message-ID: <vpq6138md7u.fsf@anie.imag.fr>
References: <20150917104430.5dd73ae1@dev-05> <vpqd1xhqfxg.fsf@anie.imag.fr>
	<20150917174306.GA29171@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alastair McGowan-Douglas <altreus@altre.us>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 18 08:52:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcpWw-0004vF-G4
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 08:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbbIRGwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 02:52:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52558 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbbIRGwS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 02:52:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8I6q5or017330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 18 Sep 2015 08:52:05 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8I6q5Oi004492;
	Fri, 18 Sep 2015 08:52:05 +0200
In-Reply-To: <20150917174306.GA29171@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 17 Sep 2015 13:43:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 18 Sep 2015 08:52:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8I6q5or017330
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443163927.30501@TuCGaAj017goYfXFR4LCCw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278179>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 17, 2015 at 04:27:39PM +0200, Matthieu Moy wrote:
>
>> > Therefore I would argue that -u is behaving differently from other
>> > arguments (especially when considered across all git subcommands)
>> 
>> This is because you have options with non-optional argument in mind, or
>> options that have no short version.
>> 
>> If I grep the source correctly, the only options accepting a short
>> version and an optional string argument are "{merge,am,commit,revert}
>> -S", "grep -O" and "status -u", which behave consistantly.
>
> Exactly. This is covered in gitcli(7)*, but I wonder if it is worth
> calling attention to this behavior specifically in the documentation of
> those options.

I think it does make sense to say it explicitly in the doc for each
option. There are not many, and even though I think Git is doing the
right thing, I also have to admit that it's confusing.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
