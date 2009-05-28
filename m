From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Strangely hosed git install
Date: Thu, 28 May 2009 12:11:01 +0200
Message-ID: <46a038f90905280311p406a528atb8d21a30fe53b0e3@mail.gmail.com>
References: <46a038f90905280008h5510d03aj5f6e5728ca075027@mail.gmail.com>
	 <7vprdthezg.fsf@alter.siamese.dyndns.org>
	 <46a038f90905280022s1c07565bnf26335fccf7c7e94@mail.gmail.com>
	 <4A1E4B82.9040809@drmicha.warpmail.net>
	 <46a038f90905280234h35b9b90fwfc52434cd056578e@mail.gmail.com>
	 <4A1E5DBC.2090908@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 28 12:11:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9cZs-0006lM-JG
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 12:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbZE1KLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 06:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbZE1KLD
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 06:11:03 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:56334 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbZE1KLB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 06:11:01 -0400
Received: by bwz22 with SMTP id 22so5317518bwz.37
        for <git@vger.kernel.org>; Thu, 28 May 2009 03:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P9N0ny3WIjyPkPGkdHvQzVaP4Ja0PP3Ec+mzeEvT8fs=;
        b=oQ/AdSMZ3eLRXnsxo7QCFPKYkOoTU4QC3TT+f+pehWZ4yQj3ZxxvtsXknb8SvkbfRI
         Nzvx8uTOeuqgmOICdvS2AdGJVRe8Y7LjLGtPMBuMMzUUSQNQyzzngAoVbHSOBgKcsfCl
         zIEmLIyxyQVklz/ckaZ+s1tOx3rLpSANsBlo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sZgbq1IwkIFOlzdj/Nw85V6ubJHmxX6PtvE0Y16GXbjiRukLAmY2FNXw7zif0Ihq+Y
         yrx4xA+UhZTMt+l0YUvkWHIj6gMba0MItGLxdoDrIOdPJNMkhWVHc1k506G7OrIuD4CY
         9Gx9AsETWTXfcJcPHCkRfs8e1wiz5FpeRvocM=
Received: by 10.223.114.74 with SMTP id d10mr941518faq.87.1243505461748; Thu, 
	28 May 2009 03:11:01 -0700 (PDT)
In-Reply-To: <4A1E5DBC.2090908@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120182>

On Thu, May 28, 2009 at 11:47 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> This is insane. Don't they even distinguish between an interactive shell
> and a non-interactive one?

Yes they do. I mentioned it but I didn't think it was the reason
behind the problem.

> Well, I would say go "find / git-diff-index", or simply nuke anything
> git you find and do a clean install... "find"ing the left over bits
> would help making sure that git's own search path is OK.

well, that's not what happens when people bisect back and forth. It
used to be reasonably safe, it got unsafe when we moved lots of things
to libexec (and therefore the make install target got a nice warning
message about it). Now there might something acting up again.

Alas, I didn't keep a backup of my libexec :-/




m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
