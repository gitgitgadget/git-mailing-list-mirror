From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [PATCH] l10n: de.po: translate 265 new messages
Date: Mon, 21 May 2012 20:02:26 +0200
Message-ID: <CAN0XMOKsKRwsrHv=FNKtzydf8_sW6nM7bw2HJu6wT4reR=jujg@mail.gmail.com>
References: <1337533755-29399-1-git-send-email-ralf.thielow@googlemail.com>
	<1825828.hnjW9vybBO@cs-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: trast@student.ethz.ch, jk@jk.gs, worldhello.net@gmail.com,
	git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Mon May 21 20:03:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWWwn-0004WQ-Vo
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 20:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758309Ab2EUSDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 14:03:06 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:44593 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758225Ab2EUSC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 14:02:27 -0400
Received: by weyu7 with SMTP id u7so3358016wey.19
        for <git@vger.kernel.org>; Mon, 21 May 2012 11:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IYie4NpVmmQsEK+RyRMw2RmkKfMCAjBow6woWOyhaPc=;
        b=OElxgb0IRIvvKkduz5f8Ol3LZKAXT/aDJ12XzKrSPgFDLima7uk47q55XJCaBWdmYB
         XWopyMucEhADKR+p5KLdPzgRVJlwJpYjvz7OXUEVNG9JiZxBpC15lvRoo/o1ud/g22H7
         mI3I61qXZXL6G/umh/w3TzxRWJuM1J3RFb0vvXcarNeuMMGipj6VjpGhcnfXKI4CgdSI
         eZVMZZOK9WCF5SP79u1rptxEpErRaIkzlcum8pVZhurgv+add5rXjm4K/fOw5u3f3xjx
         wp5GQkcXVOPV1+Q2c4DWoX0b8PRff6Fkt8ABHP4CyXsaQZk/zmARdXSYOfAgH17LUnsx
         Lktg==
Received: by 10.180.78.105 with SMTP id a9mr13095745wix.14.1337623346335; Mon,
 21 May 2012 11:02:26 -0700 (PDT)
Received: by 10.194.0.132 with HTTP; Mon, 21 May 2012 11:02:26 -0700 (PDT)
In-Reply-To: <1825828.hnjW9vybBO@cs-pc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198120>

>
> The translation (both in the existing strings and in your newly added ones)
> addresses the user as "du" instead of "Sie" (for the non-German-speaking: "du"
> is the informal addressing, "Sie" is the formal addressing). However, in
> German software there are two main rules on this: 1. Don't address the user
> directly. Rather prefer passive forms over directly addressing the person. I
> know English software is much more permissive of this one. Hence, occasionally
> the German translator should take the freedom to change the wording so that
> the addressing of the user is replaced in the translation by some passive
> wording without the addressing of the user. 2. If the addressing of the user
> is unavoidable, the text should use "Sie" instead of "du". Addressing the user
> as "du" should be constrained to audiences which for sure always address each
> other as "du", such as certain educational settings and/or games and such (and
> maybe in the Ikea-Katalog, but even there they switched from Du to Sie and
> back again several times). Please try to avoid using "du" in developer tools'
> user-visible strings. Thanks a lot!
>

Hi Christian,

thanks for your review. I agree with you that using a formal addressing
is better and probably sounds a bit more serious than an informal. However,
I would put that change in another commit to make it through the whole
translation,
because it's probably not a good idea to mix them. This also includes the last
git.pot update on master. I don't expect big updates on git.pot after 1.7.11-rc0
was tagged, so afterwards I start working on this.

Thanks

Ralf
