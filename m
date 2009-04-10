From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] autoconf: Add limited support for --htmldir
Date: Fri, 10 Apr 2009 09:34:38 +0900
Message-ID: <20090410093438.6117@nanako3.lavabit.com>
References: <9a0027270902272323y44091bfakcb640f168c33a824@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, David Syzdek <david@syzdek.net>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Tim Visher <tim.visher@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 02:37:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls4kY-0007hz-2Y
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 02:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934456AbZDJAfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 20:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765453AbZDJAfa
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 20:35:30 -0400
Received: from karen.lavabit.com ([72.249.41.33]:56669 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765214AbZDJAf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 20:35:27 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id BBBC811B8B7;
	Thu,  9 Apr 2009 19:35:26 -0500 (CDT)
Received: from 1828.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 1O8ZZN8ERO8F; Thu, 09 Apr 2009 19:35:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Bl8H2vRAm7MD0UreDkeihxoA7+KnogqxLnTR5Q+QcfqP4v/IIRV6cG9Pj61B7qUIT34wmpNLV79WPX7uHxrOId1Y65lGjBx66kfQJ5fhbkEmEW/8YiXq9BNhFVen1nqAP0UKLdsom9RtwEnF1oMwlaKvU2JPnzwrC7Ay5whkXlE=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <9a0027270902272323y44091bfakcb640f168c33a824@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116229>

Quoting David Syzdek <david@syzdek.net>

> I tested the below patch using autoconf 2.59 and autoconf 2.62.  If
> the version of autoconf used to create the configure script supports
> the `--htmldir' option then the htmldir is set by either autoconf or
> the user defined value.  If the version of autoconf does not support
> the `--htmldir' option, then htmldir defaults to [DATADIR/doc/git].
> 
> This way a newer version of autoconf is not required for users on
> distros more than a year or so old, however users on newer distros are
> able to use the '--html' flag.
> 
> -- >8 --
> Add support for --htmdir=DIR [DATAROOT/doc/git] if the configure
> script is created with autoconf 2.60 or higher. htmldir defaults to
> [DATADIR/doc/git] if the configure script is created with autoconf
> 2.59 or lower.
> 
> Signed-off-by: David M. Syzdek <david@syzdek.net>

Junio, may I ask what happened to this patch?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
