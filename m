From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Comments pack protocol description in "Git Community Book"  (second round)
Date: Sun, 7 Jun 2009 10:21:07 +0200
Message-ID: <200906071021.08922.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <200906062338.02451.jnareb@gmail.com> <d411cc4a0906061458g494d80dbwe3a5358edfd1d49e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Tony Finch <dot@dotat.at>,
	Johannes Sixt <j6t@kdbg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 10:21:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDDdF-0004DN-HO
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 10:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008AbZFGIVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 04:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752793AbZFGIVW
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 04:21:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:32478 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbZFGIVR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 04:21:17 -0400
Received: by fg-out-1718.google.com with SMTP id 16so874037fgg.17
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 01:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=uc91KzSN2iHq23Ss9H6pQyejm/Gin6BH9HbrRUCEblg=;
        b=T9tZB1H6B9HFC4x+ZPH8pEGHVr0h1qUG9vO12Tk3fHe1aHQjnMmbqEoG2PUeLvPjbm
         PRFlsfmLtkWpJQMxg/QyGEee60LOkroR2wsB+w5vMArhZomixOaa177n+DMnBb5pGBO9
         IWkWDtqu9v63M/J2gJmUTTaVG0MYe+zoeLBHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IyOS5cKCLteCzFw27AURW5BUQEDhFQ4UEhFEWfUGAhp+NRtX5V5nTNgVGNowzubdAd
         aNYaNVTn4MIM7qsO5wgqCDTxQ2JnbWW1NFrvxjnkchfdHVGvEyFXJ+jIWSnIZJTyfQNY
         X5gXBTgstsf9F7PJ1dlXqu8bxhniqXp7ZWD50=
Received: by 10.86.59.18 with SMTP id h18mr5768171fga.71.1244362877598;
        Sun, 07 Jun 2009 01:21:17 -0700 (PDT)
Received: from ?192.168.1.13? (abwd54.neoplus.adsl.tpnet.pl [83.8.227.54])
        by mx.google.com with ESMTPS id e20sm2101387fga.20.2009.06.07.01.21.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Jun 2009 01:21:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <d411cc4a0906061458g494d80dbwe3a5358edfd1d49e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120957>

On Sat, 6 June 2009, Scott Chacon wrote:

> In addition to that, I started taking a shot at putting together an
> RFC formatted documentation of this protocol as was requested.  I may
> have _way_ missed the mark on what you were looking for originally,
> it's hard to say, not having read a lot of RFC documents - I probably
> ended up writing in a more bookish format rather than a technical
> spec, but whatever - maybe you'll find it helpful or can fix it up to
> more what you were expecting.  I'm not done with it - some of it is
> still basically unformatted comments from this previous thread, but at
> least it's laid out roughly how I thought it might be useful and I
> have fleshed out a lot of it.  You can find the RFC text output
> document here:
> 
> http://git-scm.com/gitserver.txt

[...]
> Thoughts?

Those are only preliminary thoughts; more detailed analysis is to follow 
(hopefully).

Usually RFC documents refer to RFC 2119 (Key words for use in RFCs to 
Indicate Requirement Levels) for definitions of words such as MUST, 
SHOULD, MAY in the following way:

   The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL
   NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED",  "MAY", and
   "OPTIONAL" in this document are to be interpreted as described in
   [RFC 2119][1].

 [1]: http://tools.ietf.org/html/rfc2119

Definitions are done using RFC 5234 (Augmented BNF for Syntax 
Specifications: ABNF), referring to it for example in the following 
way:

   All the mechanisms specified in this document are described in both
   prose and an augmented Backus-Naur form (ABNF).  It is described in
   detail in [RFC 4234][2].

 [2]: http://tools.ietf.org/html/rfc5234


The description of pkt-line and pkt-line-sb formats is wrong: length
includes the header. It is IMHO more natural to define it from 
generality to detail, and not in reverse direction; instead of this:

   pkt-length = 4HEXDIGIT   ; length of pkt-payload
   pkt-line   = pkt-length pkt-payload [ LF / CR ]

for example like this:

   pkt-line   = pkt-length pkt-payload [ LF ]
   pkt-length = 4HEXDIGIT   ; length of pkt-line (including pkt-length)

By the way, we probably accept any terminator, but I'd rather standarize 
on LF ("\n").


In description of sideband:

>  When a sideband is used, 2 means "progress messages, most likely
>  suitable for stderr". 1 means "pack data". 3 means "fatal error
>  message, and we're dead now".  No other channels are used or valid.

it is true that no other channels are used, but it is not true that 
other channels are invalid. If they are not supported by client, there 
are simply dropped. This opens possibility of future extension. I guess 
that channel 0 is invalid, because it would be understood as _input_ 
channel (for sending data from client to server), though.

Please correct me if I am wrong here...


P.S. Could you please try to not quote large fragments of email which
you do not refer to in your reply, and which are not relevant to given 
post, like the long quoting at the end of your email without any word 
from you? Thanks in advance.
-- 
Jakub Narebski
Poland
