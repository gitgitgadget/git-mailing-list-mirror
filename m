From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] \n usage in stderr output
Date: Thu, 15 Dec 2005 09:57:05 +0100
Message-ID: <81b0412b0512150057l6448a5f9x722917a64b0fdc0f@mail.gmail.com>
References: <81b0412b0512142347o6e9aaef8s227ad749f3e2a475@mail.gmail.com>
	 <20051215085242.GO22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 09:58:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmovS-0008Pr-MY
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 09:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbVLOI5J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 03:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbVLOI5J
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 03:57:09 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:17508 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965177AbVLOI5H convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 03:57:07 -0500
Received: by nproxy.gmail.com with SMTP id x29so102257nfb
        for <git@vger.kernel.org>; Thu, 15 Dec 2005 00:57:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q4YPmkvAH+Z/EHxEoImIVEo8r0wmK4msdb3UpUwE3Ct7rTTOPZfT044SD1Qc2/F4BCeDV85bqsTbnHsTFEQyuHDeXAcdlardpJE1ksmpGn58lIfB5dHWIY7vJ1JxEtV31TZsIhsoaQLSAMfQuC9BNNtWEh0L9fxZSMjdSEXCaOo=
Received: by 10.48.235.1 with SMTP id i1mr71500nfh;
        Thu, 15 Dec 2005 00:57:06 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Thu, 15 Dec 2005 00:57:05 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051215085242.GO22159@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13688>

On 12/15/05, Petr Baudis <pasky@suse.cz> wrote:
> > fprintf and die sometimes have missing/excessive "\n" in their arguments,
> > correct the strings where I think it would be appropriate.
>
> Why don't we just error() or die() at those places anyway?
>
I don't know.
