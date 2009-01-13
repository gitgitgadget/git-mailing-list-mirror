From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: how to combine 2 commits?
Date: Tue, 13 Jan 2009 11:32:05 +0600
Message-ID: <7bfdc29a0901122132l38837b37h188a8f5dd5ccbbd7@mail.gmail.com>
References: <20090113045422.GA6940@b2j>
	 <200901122327.21102.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, "bill lam" <cbill.lam@gmail.com>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Jan 13 06:33:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMbuN-00076K-1L
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 06:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbZAMFcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 00:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbZAMFcJ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 00:32:09 -0500
Received: from rn-out-0910.google.com ([64.233.170.190]:59879 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbZAMFcI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 00:32:08 -0500
Received: by rn-out-0910.google.com with SMTP id k40so7534388rnd.17
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 21:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=coqvvkPB1w4uqN0W0Ri4FnHc6xndhP9ZbfSnkFx81pY=;
        b=PvPS8ZRVB+5C7a8ZhAdpzvlJAllJCf8Wd7yZcVIwtcIVe6GN51T5IumwL7ngreG9Gv
         j+mbnJH+p1NyzF+lGdCS2xzUluDiutoLRTmkx1QbNsmdIFLMebia+Z9Z+Ve86Z5NqL15
         EYjYGMu1qyl5KloZ7SFNdu6oQQ12COJnvFkrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=P8E4YKe9RssWKXtpa8bYmcVsXvLaOdluO/3vqifqo46Dyhgz6SHxpaXOPIX/jnKDih
         LluEV5muImgkfXdbzFqwCJ55oeZ8T63xq0qrA43vmeiLpNjGLEjhv5L4mg+PM1Bcrp1M
         C/6yoGwAu7Hfq2N+qRvdBGhheBJukLcF6mD78=
Received: by 10.150.135.2 with SMTP id i2mr1447881ybd.97.1231824725718;
        Mon, 12 Jan 2009 21:32:05 -0800 (PST)
Received: by 10.150.219.1 with HTTP; Mon, 12 Jan 2009 21:32:05 -0800 (PST)
In-Reply-To: <200901122327.21102.bss@iguanasuicide.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105458>

On Tue, Jan 13, 2009 at 11:27 AM, Boyd Stephen Smith Jr.
<bss@iguanasuicide.net> wrote:
> On Monday 12 January 2009, bill lam <cbill.lam@gmail.com> wrote about 'how
> to combine 2 commits?':
>>How to combine these 2 commits so that the changes of linefeed cancel
>>out each other and the history only shows the intended changes of the
>>few scripts.
>
> Two ways I can think of:
> git rebase --interactive (read "git help rebase" first)
> git merge --squash (read "git help merge" first)
>
> The rebase is probably semantically closer to how you are thinking about
> things right now.

Another way I can think of is - git format-patch + git apply, i.e.
first generate 2 patches for the 2 commits and then apply them one on
top of another.

Best regards,

Imran

> --
> Boyd Stephen Smith Jr.                     ,= ,-_-. =.
> bss@iguanasuicide.net                     ((_/)o o(\_))
> ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'
> http://iguanasuicide.net/                      \_/
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
