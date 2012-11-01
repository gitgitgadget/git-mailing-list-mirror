From: kevin molcard <kev2041@gmail.com>
Subject: Re: [git-users] Git clone fails with "bad pack header", how to get
 remote log
Date: Thu, 1 Nov 2012 16:38:02 +0100
Message-ID: <CADjTjYYqYYOOYCC3+fUXLvQieAEEt33x2MfEYobSbETy1PcVFA@mail.gmail.com>
References: <7f498800-ed38-474d-86ad-cb937be68173@googlegroups.com>
	<20121029211854.b58c791d30a6c8d68665e574@domain007.com>
	<508FEAE0.20204@gmail.com>
	<20121031141955.GC24291@sigill.intra.peff.net>
	<509136EE.6040705@gmail.com>
	<20121101111544.GA19996@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 01 16:39:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTwrT-0001UG-ST
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 16:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759994Ab2KAPiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 11:38:07 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57304 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759032Ab2KAPiD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 11:38:03 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3741520iea.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 08:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5CcqM3L4X3S8J5JnU2ahg3c/C+CfvKWDBdY9sJsfwR0=;
        b=xP9NBPRtvny15+YSTaJnIf0X2ztyTakYO9mdUyot7cLLzYt44T24NzTQbraLFwQF8H
         UX7kyUAS7aBFCX6bxtaD+0CNLHlumMZCLG6LygQN4BQ2Vjb6geHQWaADE0vwpKeMA3J6
         P/wPbzonRwhgsyPJVzGfyIc4Jl6whPvuW1owxOPl/ICuWQCJNEDs0JJjwmG56b96VEI2
         TtflwcxEcGL5CMTykVpG0+THY4fBu7+9EaoL47Cao+0hgcawf09t8/+JZQwe+AeIWjeI
         o1TNhEtTH6PD1TnEFEe0yq9YvuplLVpPtS69OY/QCDKUDMm/TB053hl1CddDCDCDEZef
         M/kQ==
Received: by 10.50.37.168 with SMTP id z8mr1727575igj.1.1351784282771; Thu, 01
 Nov 2012 08:38:02 -0700 (PDT)
Received: by 10.64.38.102 with HTTP; Thu, 1 Nov 2012 08:38:02 -0700 (PDT)
In-Reply-To: <20121101111544.GA19996@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208879>

Hi Peff,
thanks for this information.
I will report the issue to scm-manager. In the meantime I will try to
use ssh protocol to connect to my remote server.

Thanks again,
Kevin

2012/11/1 Jeff King <peff@peff.net>:
> On Wed, Oct 31, 2012 at 03:34:22PM +0100, kevin molcard wrote:
>
>> I forgot to mention that I am using scm manager:
>> https://bitbucket.org/sdorra/scm-manager/wiki/Home
>>
>> So that maybe the " custom layer you are talking about.
>
> Yeah, that is very important. If I am reading the scm-manager code right
> (and I might not be, as I only just looked at it), it is built entirely
> around JGit, and is not calling git-core programs at all. So it is
> either an issue in scm-manager, or in JGit.
>
> Your best bet is probably to report the issue to the scm-manager folks,
> who can probably help you dig into the problem further (it may even have
> more detailed logs of what happened, but I don't know).
>
> -Peff
