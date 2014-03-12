From: Shawn Pearce <spearce@spearce.org>
Subject: Re: egit vs. git behaviour (was: [RFC/WIP] Pluggable reference backends)
Date: Wed, 12 Mar 2014 09:48:08 -0700
Message-ID: <CAJo=hJvab468-PRMQJZ690A-ek8p01cwUOCkuy9KOQTRtt0FWQ@mail.gmail.com>
References: <531D9B50.5030404@alum.mit.edu> <CAJo=hJtiPgByhk9M4ZKD98DARzgeU6z2mmw7fcLTEbBza-_h6A@mail.gmail.com>
 <20140310155230.GA29801@sigill.intra.peff.net> <531E2986.8050604@alum.mit.edu>
 <CAJo=hJt6zoJ=53JNUT6fLXM+5_4Af8enE67z3Ozv4DOz1jU1Eg@mail.gmail.com> <20140312102601.GA26257@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git discussion list <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 12 17:48:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNmKZ-0003BY-9O
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 17:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755073AbaCLQsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 12:48:31 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:36993 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667AbaCLQsa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 12:48:30 -0400
Received: by mail-we0-f177.google.com with SMTP id u57so11544405wes.36
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SiJlpO7SE19dtYA84RHKTZiBGsOMpPWkMuZsuAyaHgw=;
        b=I2iEb1+8s8+ur9OED7rJgZbbBTs51Un6XtLefyNW1AJeES8gitwAHBPIxUqhWEP3Lm
         xZPfAevNRuCcivhZ3EnqK0ROvOxt/SICxazKUV9P0VH7LMOcd2clfoTmLS4j9mTHFIhF
         GjhOF5L91u5E734NazZpuoOCDW1QmbcKc/2ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=SiJlpO7SE19dtYA84RHKTZiBGsOMpPWkMuZsuAyaHgw=;
        b=THJ/goM+ugtn2cXadV5PdKWM8+DtdlEudqQC88U0nLyWPJk6kJMc+2HOB4Bkr0DHbu
         gut/aSGhr9+vkotYLkgmdAB01xhjPmH0j/KJZsKhM95nU/zPnVlKJ81vW7OkmRNOUMib
         SAXX7xNsBa4leKSKEOqzUKV2HnmUYW0LoAS3Nn/bUECJiJFwRPBVLTBbZXciXe9PwXZS
         wa5opAFpRpkFu1Zg8TIMKPpKF20+N1qnNYp3uF0fWPvXPDeMYOpNNcPQ3q9K2xSa8PEb
         8HrdUafLt4S2OQUVlx3IQQr/Lj2mDOJ7bdCKwpmORJF/GBTPgpGqMUr0ZVmbfXgEzUmD
         JK0g==
X-Gm-Message-State: ALoCoQkPrjk1Bt/lrfifvnQJn+mt5Nd7G5QQ7MpUyvyae9EI6ypueoGG4SSZCFl6kZpEbqghr0iK
X-Received: by 10.194.206.102 with SMTP id ln6mr19380593wjc.43.1394642908954;
 Wed, 12 Mar 2014 09:48:28 -0700 (PDT)
Received: by 10.227.7.131 with HTTP; Wed, 12 Mar 2014 09:48:08 -0700 (PDT)
In-Reply-To: <20140312102601.GA26257@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243944>

On Wed, Mar 12, 2014 at 3:26 AM, Andreas Krey <a.krey@gmx.de> wrote:
> On Mon, 10 Mar 2014 19:39:00 +0000, Shawn Pearce wrote:
>> Yes, this was my real concern. Eclipse users using EGit expect EGit to
>> be compatible with git-core at the filesystem level so they can do
>> something in EGit then switch to a shell and bang out a command, or
>> run a script provided by their project or co-worker.
>
> A question: Where to ask/report problems with that?

EGit developers have a bug tracker, from:

  http://eclipse.org/egit/support/

We see File a bug with a link to:

  https://bugs.eclipse.org/bugs/enter_bug.cgi?product=EGit&rep_platform=All&op_sys=All

> We're currently running into problems that egit doesn't push to where
> git would when the local and remote branches aren't the same name. It
> seems that egit ignores the branch.*.merge settings. Or push.default?

I think this is just missing code in EGit. Its probable they already
know about it, or many of them don't use these features in .git/config
and thus don't realize they are missing.
