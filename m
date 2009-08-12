From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Re: [TRIVIAL] Documentation: merge: one <remote> is required
Date: Wed, 12 Aug 2009 03:19:30 -0700 (PDT)
Message-ID: <m31vnhpc5v.fsf@localhost.localdomain>
References: <1249995838.1589.3.camel@localhost.localdomain>
	<20090811144253.GA12956@vidovic>
	<1250002681.2707.2.camel@localhost.localdomain>
	<7vy6ppbvdf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Bolle <pebolle@tiscali.nl>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 12:19:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbAvn-0003Ue-Hz
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 12:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbZHLKTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 06:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbZHLKTc
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 06:19:32 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:59569 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbZHLKTb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 06:19:31 -0400
Received: by fxm28 with SMTP id 28so2028585fxm.17
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 03:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ipMVgtSVhF2eZTqGGXAV3J5H1pKbUHxQlYF6cPVKiqQ=;
        b=IIwP7BDCGPjsHbXy7rTU+x2/uJYY71qCWB4UwFg0olwAOy7GObXJgF8ey7aK9mpQN4
         G8SLDhTgrRZ8YuFzwjzvrU0Ec+qaNY6AWGucOWPSHieqfTZZUdg3ZJ4DiGy+lKE+VZBH
         E4xHbeuwLyHU2NGXSN77Zn+cLMxcJBbDH1LXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=QlD6E0Nqaqo6Dg15KnKhRUYeGxAYjwKhmHx9UloFQtnq+rtUdBebMEYADVaBhajFk2
         TytLs1YIsVTaOVgbozuztS0HciEmMHswuON8RuwF/6qxlaOOHtg1Fj5kkgziv+QerPgG
         smYqC6w2CbevQGMCozTS1DJh3JEHIvYYBWbgE=
Received: by 10.103.160.3 with SMTP id m3mr2798979muo.3.1250072371290;
        Wed, 12 Aug 2009 03:19:31 -0700 (PDT)
Received: from localhost.localdomain (abvv142.neoplus.adsl.tpnet.pl [83.8.219.142])
        by mx.google.com with ESMTPS id 25sm28869542mul.23.2009.08.12.03.19.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 03:19:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7CAJSUD010842;
	Wed, 12 Aug 2009 12:19:28 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7CAJP1m010838;
	Wed, 12 Aug 2009 12:19:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vy6ppbvdf.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125692>

Junio C Hamano <gitster@pobox.com> writes:
> Paul Bolle <pebolle@tiscali.nl> writes:
> 
>>> Shoudn't be 
>>> 
>>>    [-m <msg>] <remote> [<remote>...]
>>
>> No, since "<remote>..." means one or more instances of the "<remote>"
>> option.  
> 
> Does it really?
> 
> After you brought up this "one or more", I re-read the docs your patches
> touched, thinking that the author might have meant 'zero or more of A'
> with these '<A>...'  notation.
> 
> And I realized that they made perfect sense.
> 
> In general, you can write:
> 
> 	<command> ...
> 
> and read this as "The <command> can be followed by nothing or something
> (zero or more) of unspecified kind".  If <command> takes only one type of
> zero or more things, you can _clarify the ellipses_ by prefixing them with
> what kind of "stuff" you are talking about:
> 
> 	<command> <remote>...
> 
> and read this as "The <command> can be followed by nothing or something
> (zero or more) of <remote>s".

I would have thought that it makes more sense to have

  <something>...

for one or more, and

  [<something>... ]

for zero or more (optional one or more).

Documentation/DocumentationLanguage, anyone? ;-))))

-- 
Jakub Narebski
Poland
ShadeHawk on #git
