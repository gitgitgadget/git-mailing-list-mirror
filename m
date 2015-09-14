From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git configure/make does not honor ARFLAGS
Date: Sun, 13 Sep 2015 22:52:36 -0700
Message-ID: <CAPc5daXjnLduFOD5au+wV0AN6EXTUWTM6JQ66U+0DwzVhk3YcA@mail.gmail.com>
References: <CAH8yC8kV77h8cRA9Qo_1FYe9sv0zgsE7yKxaX+OtpRfj9+7wog@mail.gmail.com>
 <20150913101727.GB26562@sigill.intra.peff.net> <CAPig+cQV-kaDDdBH+QZXsSjDHjP2CUYDXp3WKSBtgguVmLvofg@mail.gmail.com>
 <20150914043016.GA10167@sigill.intra.peff.net> <CAPc5daUBBPRxaaptTS9xyr+pJ6Fgt4XXi+MU=DSZeoQ6uHCHvg@mail.gmail.com>
 <20150914045953.GA11039@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeffrey Walton <noloader@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 07:53:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbMhK-0001nf-GH
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 07:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbbINFw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 01:52:57 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37066 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbbINFw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 01:52:56 -0400
Received: by igbni9 with SMTP id ni9so74688281igb.0
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 22:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=GzuWP+sG+scrDR6VqwW+/d3XyPLA3vzTBeSNo2v+hxE=;
        b=lk5yIXTk1Keiu7XJ6urB42dt5CmotVpwI8BQyckH+ADtTa3gjlegMBj7lk2eK8+7ZS
         wnptRe1X9rtEyhnNrOf8VSTuZZnTVFLczNZz1814u8WX1/cDkL/K0hj5j7vdbfAdO17U
         qH/Q35yrGGkMcSrQk4tWwj1CfXCQ8t1fW9GqE0Lkb1bJsNftMiEI5KCPuu6Q+Oibt31M
         9CU/c4G4b33mbH/P47CaUmrJ1W+j8wR6uqAY+AUcrb4JAcqV045f5RQPui+QiDUNUtl1
         dE+OCInnCleMPHMAoNJWR/HHNkz6tnVyZB9s7vMwphC4kkLyo8DdWXcwfyqMCtTsZMWE
         wZrA==
X-Received: by 10.50.122.42 with SMTP id lp10mr13959916igb.75.1442209976299;
 Sun, 13 Sep 2015 22:52:56 -0700 (PDT)
Received: by 10.36.79.69 with HTTP; Sun, 13 Sep 2015 22:52:36 -0700 (PDT)
In-Reply-To: <20150914045953.GA11039@sigill.intra.peff.net>
X-Google-Sender-Auth: LhbVkf5MZ8BZeAXnn0aGCrsLZUM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277807>

On Sun, Sep 13, 2015 at 9:59 PM, Jeff King <peff@peff.net> wrote:
>
> My follow-up question was going to be: is this something we should be
> setting in config.mak.uname for appropriate versions of Darwin? It
> wasn't clear to me from Eric's description if this is something that
> particular versions need, or just something that people who want to
> build Universal binaries would choose to use.

My preference is not to worry anything about config.mak.uname
ourselves, until somebody who does work on the ports proposes
to do something concrete.
