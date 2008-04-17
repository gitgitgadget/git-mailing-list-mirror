From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Intricacies of submodules
Date: Thu, 17 Apr 2008 23:27:32 +0200
Message-ID: <bd6139dc0804171427i6bf2813at719c8dec13bc225c@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu>
	 <1208202740.25663.69.camel@work.sfbay.sun.com>
	 <7vd4or7wdt.fsf@gitster.siamese.dyndns.org>
	 <1208317795.26863.91.camel@goose.sun.com>
	 <87lk3c4ali.fsf@jeremyms.com>
	 <1208461808.26863.129.camel@goose.sun.com>
	 <46a038f90804171306t22491685p87d7445d44f00879@mail.gmail.com>
	 <7vabjsnrda.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0804171400x515b3c8br3cb1501cca8a6d0a@mail.gmail.com>
	 <46a038f90804171425q1cc4cff4m6b783252040a3b26@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Roman V. Shaposhnik" <rvs@sun.com>,
	"Jeremy Maitin-Shepard" <jbms@cmu.edu>,
	"Ping Yin" <pkufranky@gmail.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:40:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jmbeb-0001eI-1d
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 23:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997AbYDQV1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 17:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755979AbYDQV1f
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 17:27:35 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:49388 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755969AbYDQV1e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 17:27:34 -0400
Received: by wf-out-1314.google.com with SMTP id 28so181093wff.4
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 14:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ckzbeUWlbpq5Fj2wKz5EOZOmBRW1vRzRyYBb4afGTSQ=;
        b=RyjmFU9LG6P4JZ+mi3bUIZ1qTs1OPBhBTKACmuWrQR+Pof0Z9YkBfJ5kGipEqUv2Bd5Tovel+poVfGFOwNjqiohDX+lkk17aunxVB4Px0rdK+tSOjM7ZCm57OEoM1BurhKwaW8clq154p2KiGvjhYqgqp+BaYH1iQeKJE5lX6GE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cL2iPLJjHHuJAdJ+WCnQwOC75cD35ttxPk6LRlSK8eukMiaJT8wtcvjR3SMTpXrTDzs0yhgB+vMpQaTUKW2FGpwrfnaPWgF2nXfMTqBPSIksxpbNvnGhGwoG59fundO6RMEg8qAdhKIgsfgackCbHLPDuQ36Kju9ZFsM4Gad/DI=
Received: by 10.142.221.19 with SMTP id t19mr538230wfg.100.1208467652201;
        Thu, 17 Apr 2008 14:27:32 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Thu, 17 Apr 2008 14:27:32 -0700 (PDT)
In-Reply-To: <46a038f90804171425q1cc4cff4m6b783252040a3b26@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79835>

On Thu, Apr 17, 2008 at 11:25 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Thu, Apr 17, 2008 at 6:00 PM, Sverre Rabbelier <alturin@gmail.com> wrote:
>  >  provide any hooks to execute things (which of course includes changing
>  >  the environment) it should be fine, but if it is, it should be ignored
>  >  till after clone has finished.
>
>  It should not be allowed at all. After the clone is the review, and
>  that has to be safe too.

I reckon review is done without using git, I don't see how it would
pose a security risk.

>  >  Because of that an in-tree '.gitconfig' would have no security risks
>  >  as long as it is not 'used' until after the clone.
>
>  This is not true. A pre-commit hook or pre-checkout hook could be destructive.

But, those won't be executed till after the review, so everything
would be good still, wouldn't it?

Cheers,

Sverre Rabbelier
