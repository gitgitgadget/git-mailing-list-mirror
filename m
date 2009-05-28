From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Strangely hosed git install
Date: Thu, 28 May 2009 11:39:11 +0200
Message-ID: <46a038f90905280239q5d8777c4t5fae8cec3c5c9814@mail.gmail.com>
References: <46a038f90905280008h5510d03aj5f6e5728ca075027@mail.gmail.com>
	 <7vprdthezg.fsf@alter.siamese.dyndns.org>
	 <46a038f90905280022s1c07565bnf26335fccf7c7e94@mail.gmail.com>
	 <4A1E4B82.9040809@drmicha.warpmail.net>
	 <46a038f90905280234h35b9b90fwfc52434cd056578e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 28 11:39:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9c52-0002V6-BS
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 11:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbZE1JjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 05:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbZE1JjM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 05:39:12 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:35038 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbZE1JjK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 05:39:10 -0400
Received: by bwz22 with SMTP id 22so5299631bwz.37
        for <git@vger.kernel.org>; Thu, 28 May 2009 02:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LjHhOjOakMt5/h/RIANOo0O89cFj/TS3CtjoX4I/8l4=;
        b=nINAq9jePSb6uBaRCY49cOsk1SBC22asaOmoP8YZqAexJR9s49PJuec2a4b0NwhYQF
         I2pcxfFrqWWpKmWnO5VUpBYqqIvs9fxF8GGaJxd7u5431iqBXnoKg9BvXJu0x3wDbH64
         V8j5vozufRryJQe7GqC6eNADL5lrPJ0jApWps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=V7BFBptEEBzCFz4ZbMxXoVDakOwW30kgZBBoV89jmTLzGaTlMqNqgaMUNFQa8iuzxy
         /21Ho66QF4DBEv2OhAMPWZztzd60XUuaN2YMUx2EaU2dMGbF36T+8zy97fwuomToZYTw
         4NofgA4EVNd+/ascnHRlH3RAYInCI1Zz4RNSA=
Received: by 10.223.122.141 with SMTP id l13mr936508far.99.1243503551343; Thu, 
	28 May 2009 02:39:11 -0700 (PDT)
In-Reply-To: <46a038f90905280234h35b9b90fwfc52434cd056578e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120177>

On Thu, May 28, 2009 at 11:34 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> Might be. Maybe ~/bin got cleaned up but not libexec? Or the bisecting
> back-and-forth left stray bits in ~/bin?

The problem was with a polluted libexec. Clearing/reinstalling git in
my ~/bin didn't help, but the same procedure in libexec worked.

Minor note for people bisecting random versions of git :-)




m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
