From: Thell Fowler <tbfowler4@gmail.com>
Subject: Re: [PATCH] Add --allow-eof-whitelines to git-apply while still
 doing  whitespace trailing-space fixing.
Date: Tue, 04 Aug 2009 19:15:37 -0500
Message-ID: <1249431338.2774.59.camel@GWPortableVCS>
References: <f002290c0908010957pf14d18dv7c80270eb9af3c8@mail.gmail.com>
	 <20090805061519.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 02:17:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYUC8-0005KK-8q
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 02:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933826AbZHEARS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 20:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933812AbZHEARS
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 20:17:18 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:53150 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933338AbZHEARR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 20:17:17 -0400
Received: by an-out-0708.google.com with SMTP id d40so5676156and.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 17:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=yfbMGAL1wB8f70wkGt0beLT+1nBUjYUM0Wxc5/2OKXk=;
        b=d/SQwe5YsQg2SWsMLraYLcEcun81UtPeld9ZIZhQZ0mqLMH7iprHrcplC3Z00BWoka
         6oVWgo2hrn6DlSZeFjSp5EFxcEIOxdI6f88At5E2ErXi3JvNpSaGFfnhlPYCq0yudIFa
         X9KK28C6Lw7Bt5IxW/vqu5Y4aa3w/a+Gn+Xew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=GXpq9tb7HYgOJufBecfNHgiFXaSlqJSrJe6dLdJd9gH/yEczhx0Tb8fEW7YTkeYwc7
         o+xcz+kGhV+ja3S1U07Rrf2uu9ZctF2qAfn7FHpjw5dHV0elbxOrXUxby80ZEwkQWHk1
         QoAR7lTNzCWcDekNSh0BOTDzHYCvMOPA/DHzs=
Received: by 10.101.69.6 with SMTP id w6mr60202ank.61.1249431437852;
        Tue, 04 Aug 2009 17:17:17 -0700 (PDT)
Received: from ?192.168.1.106? (ip70-178-75-143.ks.ks.cox.net [70.178.75.143])
        by mx.google.com with ESMTPS id c29sm225719anc.10.2009.08.04.17.17.15
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 17:17:16 -0700 (PDT)
In-Reply-To: <20090805061519.6117@nanako3.lavabit.com>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124835>

On Wed, 2009-08-05 at 06:15 +0900, Nanako Shiraishi wrote:
> Quoting Thell Fowler <tbfowler4@gmail.com>
> 
> >   - Added --allow-eof-whitelines to git apply to short-circuit removal
> > of new empty lines when tailing-space is set.
> >   - Added pass-through to apply from git-am.sh
> >   - Added pass-through to git-am from git-rebase.sh
> >   - Added the auto-completion entries.
> >
> > Signed-off-by: TBFowler <thell@almostautomated.com>
> 
> I like this new feature. However, this topic came up last week, and Junio said that whitespace checking should be controlled with the attributes mechanism.
> 
> http://thread.gmane.org/gmane.comp.version-control.git/124113/focus=124138
> 
Seemed that the issue/resolution was still open for discussion.
http://thread.gmane.org/gmane.comp.version-control.git/124113/focus=124138

Should this be re-done as a whitespace attribute?


> Please do not talk "I did this, I did that" in your proposed commit log
> message.  From Documentation/SubmittingPatches:
> 
> 	- the body should provide a meaningful commit message, which:
> 		- uses the imperative, present tense: "change",
> 		  not "changed" or "changes".
> 		- includes motivation for the change, and contrasts
> 		  its implementation with previous behaviour
> 
> In other words, the messages are often written as if you are giving an order to the program to correct itself.
> 

Got it. ...'giving an order'...  and the motivation; should be easy to remember.

Thank you for the feedback and instruction.
Thell
