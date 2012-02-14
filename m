From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] column: Fix an incorrect parse of the 'nodense' option
 token
Date: Tue, 14 Feb 2012 18:28:34 +0000
Message-ID: <4F3AA7D2.9040702@ramsay1.demon.co.uk>
References: <4F36B64D.4030000@ramsay1.demon.co.uk> <CACsJy8B7=6OYBV-HVK3Cq4_cTdPvm_1MvVv=U2R=4yQw9t5X9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 19:30:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxN94-0008S8-Hs
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 19:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759364Ab2BNSaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 13:30:18 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:37619 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757964Ab2BNSaM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 13:30:12 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1RxN8k-0002tS-XA; Tue, 14 Feb 2012 18:30:10 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <CACsJy8B7=6OYBV-HVK3Cq4_cTdPvm_1MvVv=U2R=4yQw9t5X9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190730>

Nguyen Thai Ngoc Duy wrote:
> It's about overriding config. If you set "dense" by default in
> column.ui but do not want it in this particular run, you can say
> --column=nodense.

Ah, OK, I missed that (obvious in retrospect!). Thanks.

> The [no]color is for plumbing only. If a command produces colored
> output, "color" is required to calculate text length correctly.
> Overriding it with "nocolor" would break the layout badly so it's no
> use there. It does not make sense (to me) for users to put "color" in
> column.ui. Which is why it's not mentioned in document.

Er... but 'color' is documented with column.ui in config.txt.
I'm obviously (still) being dense! :-D

ATB,
Ramsay Jones
