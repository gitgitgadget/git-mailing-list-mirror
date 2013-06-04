From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/6] prompt: don't scream continuation state
Date: Tue, 4 Jun 2013 09:14:23 +0530
Message-ID: <CALkWK0=5XecaMpPPQgvJZTwR2QUUWVqbZK5p7af9R1HjA0U=OQ@mail.gmail.com>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
 <1370181822-23450-2-git-send-email-artagnon@gmail.com> <87r4gjzi3d.fsf@linux-k42r.v.cablecom.net>
 <CALkWK0=LzUe0k7rWcrbiiTZNOOGg+=SsQB3u2F2ysjb5AJ=qZw@mail.gmail.com> <20130603211556.GB23224@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 04 05:45:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjiBi-0001Tu-Ob
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 05:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757129Ab3FDDpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 23:45:06 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:56083 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756130Ab3FDDpE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 23:45:04 -0400
Received: by mail-ie0-f182.google.com with SMTP id 9so7303525iec.13
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 20:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=x15aCOuHfkXYVuR4DCoD43cw++1wzqu0QbJuXtOjCLU=;
        b=cHjDd/jq0nPENRn/jOH6kyUXnKkDvB7LJQHyxIlmmJgvy3j7H0SxBBeVjUMwq0KYxC
         Fq2N+cgeVTn46ppaN8GKi9hzpvEnSOD/lVYidiwrGZ6EsKtBKwAVbjcntqKI3toyDyX7
         q0i+x1O+Nszkg0aUkjfr/RXgeqF+XREKD20Opckzd/WP7MG1px+Qk9Je7NfkUfIEsup4
         ArEP+IDsarW/PajlvcYuzdjjw6CZSFxAXua8o9mrcbpucBzDkG9DiP3l3sbcoxED/iha
         bYpLnVm4KHi3CCruFA+N2V0ls+XHSbNxtwJbshesqVgeubWgt84+yTMJ3rNreLDD/JJR
         OOzw==
X-Received: by 10.50.70.101 with SMTP id l5mr26401igu.104.1370317503734; Mon,
 03 Jun 2013 20:45:03 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Mon, 3 Jun 2013 20:44:23 -0700 (PDT)
In-Reply-To: <20130603211556.GB23224@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226308>

Jeff King wrote:
> It seems silly to argue about output formats when we are writing a
> prompt in a convenient Turing-complete scripting language already.
> What about something like:

Could you have a look at __git_ps1_colorize_gitstring from
rr/zsh-color-prompt in pu?  In the general case, wouldn't the user
need to re-implement this entire function (with so many variables) in
her ~/.zshrc?  Isn't it horribly painful for too little gain?
