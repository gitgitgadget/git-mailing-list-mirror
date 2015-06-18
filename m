From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-checkout.txt: Document "git checkout <pathspec>" better
Date: Wed, 17 Jun 2015 18:07:52 -0700
Message-ID: <xmqqy4jh4ydz.fsf@gitster.dls.corp.google.com>
References: <558127CB.70603@web.de>
	<CACsJy8CuRcV2Rxaz8Ut4ayW-Hyd8Aao5W4JMc20jcfggOG3d4g@mail.gmail.com>
	<vpq8ubiwqo9.fsf@anie.imag.fr> <mlrmnt$te5$1@ger.gmane.org>
	<vpqoaketusa.fsf@anie.imag.fr> <mlrn9r$9ho$1@ger.gmane.org>
	<vpqtwu6sf4r.fsf@anie.imag.fr>
	<xmqqoake4akt.fsf@gitster.dls.corp.google.com>
	<xmqqd20u48at.fsf@gitster.dls.corp.google.com>
	<5581A3A3.1070908@web.de> <vpqh9q6gsdt.fsf@anie.imag.fr>
	<xmqqpp4u6swo.fsf@gitster.dls.corp.google.com>
	<5581CAA6.5080306@web.de>
	<xmqq8ubi6rap.fsf@gitster.dls.corp.google.com>
	<CACsJy8COWS+LoVOxKmAdMhk8FPEnOZpJ1mesJr0orOD7wN2Qsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"Andres G. Aragoneses" <knocte@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 03:08:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5OJD-0005w0-Be
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 03:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbbFRBH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 21:07:56 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34267 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbbFRBHy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 21:07:54 -0400
Received: by iebmu5 with SMTP id mu5so45327406ieb.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 18:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oj2R2A1AEwmVo6pEwEzYBRcOoNAub2OHHBM/JVSKZNU=;
        b=Q2ZGHBc5zxb5TXnHSVqn67EkFopXXLDVykpYXDXL4eD3y4y28KTXTHk/RixLJTMMv3
         a3X6iJ/FOAR+Jhmjf/11ztBrP0oaavXU2Z6qH3xgxAM8dBiNvAqNkEdHp1VIhoCsY1z3
         /9LnCtbqIXuc5nadRhm0N04IoKePgKQlrhf2nqNN6tQ+J37Tni4Z4hBXzNnoYdpl9M6y
         erLZaxKbvVKt4lxyNKxGlUEC5KQI3ISuy+xT41R1ZmWCgLuQpOwf7NBI9JXQoQ9/eWnU
         klsrJBdgWSHIXpT3GJAMamylCDDx4TQS/mASUtO1JgfBxAzqM6LHFw0mN06toeuaRrSw
         RHLA==
X-Received: by 10.43.96.5 with SMTP id ce5mr3163524icc.96.1434589673909;
        Wed, 17 Jun 2015 18:07:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id e10sm4380270igy.11.2015.06.17.18.07.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 18:07:53 -0700 (PDT)
In-Reply-To: <CACsJy8COWS+LoVOxKmAdMhk8FPEnOZpJ1mesJr0orOD7wN2Qsg@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 18 Jun 2015 07:37:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271933>

Duy Nguyen <pclouds@gmail.com> writes:

>>> How about this:
>>>
>>> git-checkout - Switch branches or restore changes to the working tree
>>
>> Gahh.  We are NOT restoring CHANGES.  We are restoring the whole
>> contents to a path.
>
> "the whole contents" is only true when --patch is not used, I think.

I've seen that people repeat this "patch is not the whole" and have
ignored that comment; you really need to think if that nitpick adds
anything of value to the description before repeating it.

The "patch" interface of course allows you to pick and choose.  You
have some contents (call it W) in the working tree.  You have
different contents (call it X) somewhere else.  Being able to do
that is the whole point of the feature.

But what is presented you as the choice to pick or ignore?  It is
the difference between W and X.  If you take none from what is
offered, you won't check out anything.  If you take all of them, you
check out the whole of X.  The result is somewhere in between.  

An important point that everybody who repeats "patch is not the
whole" seems to be missing is that it will never be somewhere
between W and Y (the latter of which is different from X).

Now, what is the X in this operation?

It is either what is registered in the index, or in the tree-ish
specified on the command line.

So I'd say that the right mental model to understand the "--patch"
feature is that it allows you to check out the whole contents from
elsewhere; after the command line argument selects from where, i.e.
either from the index or from a tree-ish, you _additionally_ have a
choice to pick which part of that whole to use.  The diff between W
and HEAD or W and index, i.e. "CHANGES", does not play any part of
this selection process.
