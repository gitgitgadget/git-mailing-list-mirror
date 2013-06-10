From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [IGNORE] Implement 'git rebase' in ruby
Date: Mon, 10 Jun 2013 13:18:38 +0530
Message-ID: <CALkWK0=am0kDZWKuvdx9ph+zwtXdjRAbwu3e=GfEYUp+o8oy0g@mail.gmail.com>
References: <1370841722-8059-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 09:49:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulwqx-0007Km-JX
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 09:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951Ab3FJHtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 03:49:20 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:37823 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab3FJHtT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 03:49:19 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so1850632ied.14
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 00:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=e9O/0DTsH9Adg2I4tdp26qu7yuGJaVrA7M9RenRhL7k=;
        b=kZe5Nh4owkLmYdVU7WZGtF2hJF2KkPHoBtt2t305pKORLecWy2NYJ0cyREvAObHUSb
         9MFnwtgd+ZQd33p8JzLBxOFoCgVAJ0piI5F6B8Hc6vv73sFuqAzvOJa5Bv89jJf7Xqlt
         eDvqbF1PPcVcSrToDcBOd5fgGmug6BQTu1n95I9k9Qe6E13dYFaWRIlFlYazzqLFK2JE
         /kwf0qntV/gquo0DJ1JjbgUqJUMWgNzWR5erDajsBTheV3crCfkKRd9FOZzQ44GEnAHe
         EuzydjRr7eWzt/374lCKC0gekjTJvHGAdtwfkNiP8tmO6jm1eaU8QaZXYKp5EbOAGvm0
         y/EA==
X-Received: by 10.50.56.20 with SMTP id w20mr3402667igp.40.1370850558669; Mon,
 10 Jun 2013 00:49:18 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 10 Jun 2013 00:48:38 -0700 (PDT)
In-Reply-To: <1370841722-8059-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227252>

Felipe Contreras wrote:
>  git-rebase.rb | 2056 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 2056 insertions(+)
>  create mode 100755 git-rebase.rb

I suggest putting this in contrib/ and cooking it.  As usual, my
mantra is: let the patches decide what to do.  I'll help review and
improve this soon.

Thanks.
