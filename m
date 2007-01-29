From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [PATCH] Replace perl code with pure shell code
Date: Mon, 29 Jan 2007 13:38:31 +0100
Message-ID: <dbfc82860701290438y4e00cc05s5f8c8acdc8022768@mail.gmail.com>
References: <45BDABB5.4070301@fs.ei.tum.de>
	 <86zm82dpql.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Mon Jan 29 13:38:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBVmU-0007SZ-U3
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 13:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbXA2Mid (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 07:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbXA2Mid
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 07:38:33 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:7777 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbXA2Mic (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 07:38:32 -0500
Received: by an-out-0708.google.com with SMTP id b33so651240ana
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 04:38:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=AMQqS+IDvtTnq8G+++HUOqKOkReSDyV5VHBtSnJArkelsIB6wBoaTb8yd+jmq4KgQGaRN4gNBWTrJWxkEShd6fTEP+3QSxvyp+9YqnLJg1rsPD93mZA8OHoY9BmreDxILKf5mdLJtgZOuTdCIO72ZgPlzNWqw8hgU2gN6W6rXlc=
Received: by 10.114.179.1 with SMTP id b1mr258033waf.1170074311790;
        Mon, 29 Jan 2007 04:38:31 -0800 (PST)
Received: by 10.114.199.13 with HTTP; Mon, 29 Jan 2007 04:38:31 -0800 (PST)
In-Reply-To: <86zm82dpql.fsf@blue.stonehenge.com>
Content-Disposition: inline
X-Google-Sender-Auth: 7e083aad351ff19f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38075>

On 1/29/07, Randal L. Schwartz <merlyn@stonehenge.com> wrote:
> >>>>> "Simon" == Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:
>
> Simon> +                        destname="refs/$branch_top/${name#refs/heads/}" ;;
>
> I don't think this is portable shell.  At least Perl is the same everywhere.
> Ignore me if this is a shell syntax on something other than bash.

According to "The Open Group Base Specifications Issue 6" [1]:

${parameter#word}
    Remove Smallest Prefix Pattern. The word shall be expanded to
produce a pattern. The parameter expansion shall then result in
parameter, with the smallest portion of the prefix matched by the
pattern deleted.

We do require a POSIX-compliant version of sh already, right?

  nikolai

[1] http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_06_02
