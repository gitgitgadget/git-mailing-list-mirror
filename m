From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/5] Documentation: explain how to check for patch
 corruption
Date: Fri, 15 Apr 2011 01:17:58 -0500
Message-ID: <20110415061758.GA20441@elie>
References: <87d3kq6tz7.fsf@rho.meyering.net>
 <1302719749.21047.6.camel@drew-northup.unet.maine.edu>
 <87mxjtn8x7.fsf@rho.meyering.net>
 <20110413221736.GA773@elie>
 <7vzkntkc9d.fsf@alter.siamese.dyndns.org>
 <20110414211125.GA15277@elie>
 <7vlizcfpz8.fsf@alter.siamese.dyndns.org>
 <20110415021100.GA19829@elie>
 <20110415022401.GC19829@elie>
 <7vsjtkdsij.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>,
	Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 08:18:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAcMB-0005T7-Qt
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 08:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab1DOGSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 02:18:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65116 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab1DOGSI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 02:18:08 -0400
Received: by iwn34 with SMTP id 34so1984372iwn.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 23:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=DIXXO47b03GrFKauW5mNzz4eYsBZFW+bMJCqp5IAn0U=;
        b=v9vPq8xllWYgMX+kh2QHS+QcFYtdUthlYWA0MGQlZf1wqsZWv6BVGSpW/kUTKJCCPo
         2TELFNjjwsjWeLjfv3A3ScMkfgFrwcVMapZRkC26ZIwQXyqh5WIOIpL08BqWT1D5BwPQ
         f7iiJa9+ph/u4Q6hHc1frnRk+WMwuYHWilbi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=okcTmtn+59xBjizyUpfEn2eVwMFFTEywkcp6nJUwY2p0Lsf+1AKf1tbcqsZXVBsJ2o
         EruZYh+Bg3abozg2awgYYVepMFKi2WdFO734wDWc62xIB0FBETwAp8nRO4Drrf+nbWCZ
         Z9mjTFRdaBfPp43BrIGt9VnMyISr+5LiuBazY=
Received: by 10.43.46.138 with SMTP id uo10mr2258353icb.319.1302848287649;
        Thu, 14 Apr 2011 23:18:07 -0700 (PDT)
Received: from elie (adsl-69-209-64-230.dsl.chcgil.ameritech.net [69.209.64.230])
        by mx.google.com with ESMTPS id e9sm1605577ibb.15.2011.04.14.23.18.03
        (version=SSLv3 cipher=OTHER);
        Thu, 14 Apr 2011 23:18:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsjtkdsij.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171588>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> +++ b/Documentation/SubmittingPatches
[...]
>> +While you are at it, check the resulting commit log message from
>> +a trial run of applying the patch.  If what is in the resulting
[...]
> Perhaps the last paragraph can also go, as a copy of it now is in git-am(1)?

Yes, good idea.  I wanted to keep a reminder to look over the
resulting commit (and especially its log message), but this section is
definitely not the place.

>> +++ b/Documentation/git-format-patch.txt
>> @@ -286,6 +286,52 @@ title is likely to be different from the subject
>> +One way to test if your MUA is set up correctly is:
>> +
>> +* Send the patch to yourself, exactly the way you would, except
>> +  with To: and Cc: lines that do not contain the list and
>> +  maintainer address.
>
> ... "except for removing other people from To: and Cc: lines to avoid
> spamming them with your test"?

Yes, that is much clearer.  If you'd like, I can collect other
corrections and read it over again myself to resend tomorrow.
