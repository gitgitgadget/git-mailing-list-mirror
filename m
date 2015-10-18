From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: How to rebase when some commit hashes are in some commit messages
Date: Sun, 18 Oct 2015 18:23:39 +0200
Message-ID: <CACBZZX5K775B=w_RtwCowPoK54ZcL43WO5gTLrmAc8p8=D7Jxg@mail.gmail.com>
References: <561C1132.3090606@orange.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Francois-Xavier Le Bail <devel.fx.lebail@orange.fr>
X-From: git-owner@vger.kernel.org Sun Oct 18 18:24:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Znqkh-0007ko-3R
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 18:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbbJRQYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 12:24:00 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33257 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbbJRQX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 12:23:59 -0400
Received: by qgeo38 with SMTP id o38so95140003qge.0
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 09:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FU73B8DWlmha0pth4nheun4kKmWkqCK/r8dhfSA45q8=;
        b=0XRaJozHmIsPK0p8PMel+PjcAbhD9G56nfdl+Go3nWUZiiYGGiKx/pKglT3NNuMgn+
         oN8S32P+Ljju01j0CtHKyemDFL0PPZk1fumuM9Q6KuwvAmtQXEyi8sk003xEZr9iaNG/
         kUDBGS34EDi4Y2INPyoH3JtHWKZ1YDbbRxy0xbM0FUPNa1eshHx78rCBUbbZAqJOsneJ
         JMO27aXMB/zh7ckfwU2X6g8y+MgfcOQVl8tMKZwnXMAKKo5Wg9V2nF0CLD6iLZUAYlNi
         hAd+i75SP+IATq//up/Yqk77692uThHXc8xZSEJLY5r5U2+8dvTSRtwNKvmGkWvdd3Zo
         F/1w==
X-Received: by 10.140.135.202 with SMTP id 193mr33310274qhh.3.1445185439102;
 Sun, 18 Oct 2015 09:23:59 -0700 (PDT)
Received: by 10.55.31.136 with HTTP; Sun, 18 Oct 2015 09:23:39 -0700 (PDT)
In-Reply-To: <561C1132.3090606@orange.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279813>

On Mon, Oct 12, 2015 at 9:59 PM, Francois-Xavier Le Bail
<devel.fx.lebail@orange.fr> wrote:
> Hello,
>
> [I try some search engines without success, perhaps I have missed something].
>
> For example, if I rebase the following commits, I would want that if
> the commit hash 2222222... become 7777777...,
> the message
> "Update test output for 2222222222222222222222222222222222222222"
> become
> "Update test output for 7777777..."
>
> Is it possible currently? And if yes how?

This isn't strictly speaking an answer to your question (others have
done that), but in my workflow if I have a patch series where I want
to refer to commits inside the series, and I know I'm going to rebase
it I work around this by just using the subject line of the commit as
an ID.

E.g. in the message I'll say something like "See my 'commit.c: Avoid
segfaults on OSX' commit for details". Then I can just find that with
git log --grep.
