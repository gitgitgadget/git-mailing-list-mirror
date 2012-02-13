From: =?GB2312?B?0Oy1zw==?= <xudifsd@gmail.com>
Subject: Re: [PATCH] strbuf: move strbuf_readline_fd() from bundle.c to strbuf.{c,h}
Date: Mon, 13 Feb 2012 11:54:13 +0800
Message-ID: <CAMocUqTKCptbn5MRkWKusCvsPJXtd2zOA=nCs_wwuYDT6=-z-Q@mail.gmail.com>
References: <CAMocUqRutwERQ64a=9t36Za6Lm8KxpseS0NYbdGKWbixbsXeyw@mail.gmail.com>
	<CAMocUqSefruci_ueWHUH6rqz8VFcakHErq8QV_bvghWMyHKVJg@mail.gmail.com>
	<7v39agkmjf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?GB2312?B?R2l0INPKvP7B0LHt?= <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 04:54:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwn01-0004ge-BB
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 04:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274Ab2BMDyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 22:54:15 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58214 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367Ab2BMDyO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 22:54:14 -0500
Received: by bkcjm19 with SMTP id jm19so4179309bkc.19
        for <git@vger.kernel.org>; Sun, 12 Feb 2012 19:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tmErBOnJ/K+gjtCZyJ2n2ttxuwtntIjaV3HUcB0xE3s=;
        b=vc5437OZa7wTRhGq8w7BzJujqyiHJ5cPMYUB24jlaxaMkclRPMIz70WnAAiy1Kz4Pw
         h7/AU4+QrgCypz5xLaDUV+TJ4vgFmGRJlSXCfWnLLVbMik+7DPbH+aHQDUqUTZqQVRPC
         N6SUqKs465ezVvy3TIn1PpPKUuMctoXv1h8m0=
Received: by 10.205.129.130 with SMTP id hi2mr6286416bkc.98.1329105253126;
 Sun, 12 Feb 2012 19:54:13 -0800 (PST)
Received: by 10.204.130.72 with HTTP; Sun, 12 Feb 2012 19:54:13 -0800 (PST)
In-Reply-To: <7v39agkmjf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190599>

>> Shouldn't I supposed to receive any information about this patch?
>
> Not necessarily X-<.
>
> Things can get lost in the noise, and sending a reminder message like you
> just did, after waiting for a few to several days, is considered a good
> practice.
>

Ok, excuse me, but this is my first time to make a patch. I'm
desperately want to know its fate :)

>> Has it accepted or not?
>
> Anything and everything being considered for inclusion is reachable from
> the tip of the 'next' branch; other patches that might turn out to be of
> value, or ones that at least deserve more sets of eyeballs, are only in
> the 'pu' branch.
>

Does this mean that we can check 'next' branch to see if any of our
patches being considered for inclusion?
