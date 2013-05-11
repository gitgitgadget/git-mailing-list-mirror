From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Fri, 10 May 2013 23:13:22 -0700
Message-ID: <20130511061322.GB3394@elie>
References: <7vipezaaig.fsf@alter.siamese.dyndns.org>
 <1339698851-15428-1-git-send-email-zbyszek@in.waw.pl>
 <CACPiFCKev9uibTa8GSH94ZaH-NaVBAWVempg4xfTdFTThE85Zw@mail.gmail.com>
 <20130511055647.GA3262@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Martin Langhoff <martin@laptop.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat May 11 08:13:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub33l-0006xM-Ir
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 08:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167Ab3EKGN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 02:13:28 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:52836 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848Ab3EKGN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 02:13:28 -0400
Received: by mail-ea0-f180.google.com with SMTP id g10so1224120eak.25
        for <git@vger.kernel.org>; Fri, 10 May 2013 23:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=qoPJpkITttnsLniaTIaf6htzA26p0BUIYrz/bwc2BDo=;
        b=L2g+kGB8e3gDXH/aR7XWqDCBzMxxI1eEfyPKoBDx7BkZe5jPmE1t5fX3gcHDzU5Uky
         9nnmWxscSN2g4YJt6p//NbxgeRoEFOvD4uH+UD083zXSZrcx9j96eYEz//virqWapRXD
         biB8bCaZGFhzHX1qLClVcKeTESAoU5IospaQI2SHzx8yCmh3r8P67ZpDM3x2OwSH6bpj
         r13aTRyTtp77eOishFCcFNV/RNU1jOLKrYGiPE3SK03S0sO5ZrPKJ+K+IfKKwodItX1j
         cYYUh3lfnMkya6+fKNqwft/Jx8W+0UvEOw9u/UQCSfp7QrOpjP3W1eSyUR+f5y6HYc2Z
         1avw==
X-Received: by 10.14.38.198 with SMTP id a46mr50049495eeb.11.1368252807119;
        Fri, 10 May 2013 23:13:27 -0700 (PDT)
Received: from elie ([213.221.117.228])
        by mx.google.com with ESMTPSA id w43sm7882745eeg.14.2013.05.10.23.13.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 23:13:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130511055647.GA3262@iris.ozlabs.ibm.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223931>

Paul Mackerras wrote:

> I thought I had replied to this patch; maybe I only thought about it.
>
> Given that we already have a selector to choose between exact and
> regexp matching, it seems more natural to use that rather than add a
> new selector entry.  Arguably the "IgnCase" option should be disabled
> when "adding/removing string" is selected.

Thanks.  I think I disagree: "log -G" and "log -S" are different
operations, not variations on the same one.  

The description "Find next commit adding/removing string:" very
clearly conveys what "-S" means.  Maybe -G would be more clearly
described as "Find next commit changing line that matches regex:" or
"Find next commit changing line containing:"?

Jonathan
