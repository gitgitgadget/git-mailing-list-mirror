From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] sample pre-commit hook: Use --bool when retrieving config var
Date: Wed, 25 Sep 2013 12:10:58 +0200
Message-ID: <CALKQrgc_5PhN-PsnCPnxcoN+zNKGo1CEJZw0CZzPXvu6aG23uA@mail.gmail.com>
References: <1380009176-10490-1-git-send-email-johan@herland.net>
	<20130924192259.GN9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 12:11:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOm3q-0002hB-Gw
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 12:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755157Ab3IYKLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 06:11:06 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:38706 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831Ab3IYKLF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 06:11:05 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VOm3j-0007lm-2L
	for git@vger.kernel.org; Wed, 25 Sep 2013 12:11:03 +0200
Received: from mail-pd0-f172.google.com ([209.85.192.172])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VOm3i-0001Yd-Ls
	for git@vger.kernel.org; Wed, 25 Sep 2013 12:11:02 +0200
Received: by mail-pd0-f172.google.com with SMTP id z10so5883680pdj.3
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 03:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z10Rn/txqar5F0O/RR5C0gfTXTLBQD8zJ2HhtuMxuKQ=;
        b=TqfxoNs1tZiDmrzQNMVmCV9AjORM0nxEi1UE3ADnsmy5EnB4mMCKFFo8pfveesnpnF
         /i7lk3q/8K2gG8JVbBSwS0ZLkqYS8NlGHCtGFxiY7g7+h0ckU7ZBe6c5JV0DSL90iFVw
         vd+nrUDfztFRJsNqKHLs84qd1C4TEQFZ62/b4h3CVXo5oacGG4fqZqaYd0zqA6ySRNRK
         xU9D7Om4+Xyy+rAyIfowZNL+44v0f6MMUXPiyM8iK8z8uiwlg20G240Xr4/YjcsTlO6o
         emFgu2coNcRka3vC1PSFw8fXCOucy3a2VhQTjHhyV284FvoXNb8/smpeYLVIh6yosRMp
         10wA==
X-Received: by 10.68.211.73 with SMTP id na9mr22563124pbc.92.1380103858554;
 Wed, 25 Sep 2013 03:10:58 -0700 (PDT)
Received: by 10.70.24.226 with HTTP; Wed, 25 Sep 2013 03:10:58 -0700 (PDT)
In-Reply-To: <20130924192259.GN9464@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235340>

On Tue, Sep 24, 2013 at 9:22 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Johan Herland wrote:
>> Signed-off-by: Johan Herland <johan@herland.net>
>
> Thanks.
>
> What symptoms does this alleviate?  Is this to allow configurations like
>
>         [hooks]
>                 allowNonAscii = 1
>
> and
>
>         [hooks]
>                 allowNonAscii
>
> to do the expected thing, or is it something more subtle than that?

Nothing subtle. Just what you list. And for consistency with the other
sample hooks' use of "git config".

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
