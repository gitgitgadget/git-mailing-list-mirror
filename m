From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [PATCH] Replace perl code with pure shell code
Date: Mon, 29 Jan 2007 14:17:43 +0100
Message-ID: <dbfc82860701290517p739c78a1td05fd0900e280515@mail.gmail.com>
References: <45BDABB5.4070301@fs.ei.tum.de>
	 <86zm82dpql.fsf@blue.stonehenge.com>
	 <dbfc82860701290438y4e00cc05s5f8c8acdc8022768@mail.gmail.com>
	 <86fy9udmf6.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Mon Jan 29 14:17:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBWOO-0002N2-2a
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 14:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbXA2NRp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 08:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbXA2NRp
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 08:17:45 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:32897 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbXA2NRo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 08:17:44 -0500
Received: by an-out-0708.google.com with SMTP id b33so658919ana
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 05:17:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=IUqD38PYfyzjNWlNiKjC3ffUPwFIzgt2qmNZ4Ipf/xU50wuxcM92J8WGPjEUa36v1SHFnoOW8QWmYdR/nDN7i0GAriCWMvRVR2Q+CMTpLr+gYkqF+DEkp+x4kfbhr/X2VerJRcU116b2xD9jCGsytYiI9DDzGNcMChOqGF2cjRM=
Received: by 10.114.126.1 with SMTP id y1mr270282wac.1170076663645;
        Mon, 29 Jan 2007 05:17:43 -0800 (PST)
Received: by 10.114.199.13 with HTTP; Mon, 29 Jan 2007 05:17:43 -0800 (PST)
In-Reply-To: <86fy9udmf6.fsf@blue.stonehenge.com>
Content-Disposition: inline
X-Google-Sender-Auth: c6e69c605fce9d12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38079>

On 1/29/07, Randal L. Schwartz <merlyn@stonehenge.com> wrote:
> >>>>> "Nikolai" == Nikolai Weibull <now@bitwi.se> writes:
>
> Nikolai> We do require a POSIX-compliant version of sh already, right?
>
> OK, sorry for raising the flag.  I just know that writing portable shell
> is far trickier than writing portable Perl, so I get overly cautious
> on anything that wasn't in Unix V7.

No problem; I wasn't sure on the current requirements myself :-).
It's too bad that not all the great stuff one can find in Bash and Zsh
were in the original...

  nikolai
