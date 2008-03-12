From: "Marko Kreen" <markokr@gmail.com>
Subject: Re: [PATCH] gc: call "prune --expire 2.weeks.ago"
Date: Wed, 12 Mar 2008 17:32:47 +0200
Message-ID: <e51f66da0803120832p579d49fdmc4801b004e8cdabb@mail.gmail.com>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site>
	 <7vskywadum.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.1.00.0803112234470.2947@xanadu.home>
	 <7vbq5k77z0.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.1.00.0803121105481.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Mar 12 16:34:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZSxT-0002YB-OT
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 16:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbYCLPcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 11:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbYCLPcu
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 11:32:50 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:4733 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbYCLPct (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 11:32:49 -0400
Received: by mu-out-0910.google.com with SMTP id i10so8351126mue.5
        for <git@vger.kernel.org>; Wed, 12 Mar 2008 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=C1Dl1Lw8yExOU4sIr2DHkqjBxYpRf6WYCGgyiIp4P2c=;
        b=XL0yldw9+FnAoEHEeJsgwg6h+lIKHf1UyuhTJiGsq8hM95B6gJk9hVckDIhI69QnQADy4MIPq29VDJz+diIdYejY7jCVtCuKj/eBXzr2W/Fw1Y76l+eQSAd/jLw9QW/mZwcpx7o4L5qyZ6WE1e7FgS5Tw8Yn3xEhpaZWE/PrQN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dujqlXN9+4GzHyyX5OP93u9sjI6yc+1df54z/fmeacL4qwHInzbwZODDGXjQEsq1+njKgN32aowBdnoeHt2BHyi0m5vix8SFOMjTGvpZKGkCvRzxWOibtvVbRC1MpBAZXcOKltfalhgUrZwAJWvtw6Ajg3/fmKyq8aq3ZbGsQ/Y=
Received: by 10.78.189.5 with SMTP id m5mr21967070huf.74.1205335967982;
        Wed, 12 Mar 2008 08:32:47 -0700 (PDT)
Received: by 10.78.145.9 with HTTP; Wed, 12 Mar 2008 08:32:47 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.00.0803121105481.2947@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76956>

On 3/12/08, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 11 Mar 2008, Junio C Hamano wrote:
> > Nicolas Pitre <nico@cam.org> writes:
>  > >> Can we also have "why this is a good idea", "what problem this solves"?
>  > >
>  > > FWIW, my agreeing with the "why this is a good idea" can be translated
>  > > into:
>  > >
>  > > Acked-by: Nicolas Pitre <nico@cam.org>
>  >
>  > Hmmm.  Is it _that_ obvious?
>
> To the average user, maybe not.  But My ack is orthogonal to that issue.

Well, I'm a newbie user and now I'm trained to always do "gc --prune",
because "gc" itself does not make tree "really" clean.

But this will quite likely bit me in the long run.

So from my newbie perspective, anything that decreases
number of mandatory arguments to commands is good.
*cough* commit -a *cough*

But the difference from 'commit -a' is that its not a style
issue - "gc" without --prune will keep stuff around indefinitely,
which makes occasional --prune usage mandatory.  As its annoying
to memorize when it was last ran, its easier to use it always.

So from my newbie perpective, +1 for making plain "gc" work.

-- 
marko
