From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 28 Nov 2012 01:16:17 +0100
Message-ID: <CAMP44s27gdDJGNx-UTe1rdQZFpn3M60L=nMyd69gAFo15VnMAA@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<50B1F684.5020805@alum.mit.edu>
	<CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
	<20121127143510.GA15831@google.com>
	<20121127183530.GB11845@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?TWFnbnVzIELDpGNr?= <baeck@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Wed Nov 28 01:16:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdVKK-0005sA-1W
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 01:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217Ab2K1AQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 19:16:18 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55146 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab2K1AQS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 19:16:18 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so11522537obb.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 16:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KBF57B2M+wWuod4q9TDtiaLBva9xCae5w8jcen++/IQ=;
        b=zi1/b1SwopIYUeb2QP6jZabT6JFLZSnEvJ434FJtZVwSxrd1ClUm3BiwL0O5OqYir8
         IILlAJaYOKC8AmHsgaLunIGKCnbzNpDmjt8LKSSv67ZUIKwMLElSOOqfJ40ziUsseJpw
         wUcXGHW9QSUKL6aOlO01bXAk5bvN/jBVGyM7T6OrP5umqZxeKx7tnTuwTwgw1MTWswt9
         EuE3BBeMa3CXfCvj3RzPAuZ7o40gsXq9nIA2HVk4gep+fdIzwuP8EHNSEiXB5CKEZPHe
         KRBalCwTAoDqexKldzSGZUfkly/8Ie4hawCt54UKM/uvB5A3//0dRYmxapBzR/VhID6b
         ukNg==
Received: by 10.182.21.135 with SMTP id v7mr1390973obe.101.1354061777369; Tue,
 27 Nov 2012 16:16:17 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 16:16:17 -0800 (PST)
In-Reply-To: <20121127183530.GB11845@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210638>

On Tue, Nov 27, 2012 at 7:35 PM, Eric S. Raymond <esr@thyrsus.com> wrote:

> As a general scripting language shell sucks *really badly* compared to
> anything new-school. Performance, portability, you name it, it's a
> mess.  It's not so much the shell interpreters itself that are the
> portabilty problem, but (as Magnus implicitly points out) all those
> userland dependencies on sed and tr and awk and even variants of
> expr(!) that get dragged in the second you try to get any actual work
> done.

Somehow it has worked perfectly fine for us.

Also, you are ignoring all the advantages that shell has and python does not.

> Can we cease behaving like we're still pounding keys on 110-baud
> teletypes now?  Some old-school Unix habits have persisted long past
> the point that they're even remotely sane.  Shell programming at any
> volume above a few lines of throwaway code is one of them - it's
> *nuts* and we should *stop doing it*.

Yes, let's all switch to ruby! Nah, everybody is still using Unix and
shells, they work. If they didn't, we wouldn't be having this
conversation.

What is the big problem? Somebody said we hit a few issues per year?
I've already hit more than that writing code for python just the last
month.

Cheers.

-- 
Felipe Contreras
