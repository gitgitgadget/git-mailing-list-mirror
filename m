From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 4/4] Makefile: Don't pass $(ALL_CFLAGS) to the linker
Date: Wed, 30 Jun 2010 20:52:37 +0100
Message-ID: <4C2BA085.3060601@ramsay1.demon.co.uk>
References: <4C226520.5080009@ramsay1.demon.co.uk>	<AANLkTinmGOSwNzLBngXHOU-pxNTbHFJQyCLIHQWFW6Eo@mail.gmail.com>	<4C251062.8040507@ramsay1.demon.co.uk> <AANLkTilvV9Lty6jciIvASrRrzZ5rf9s2zmgulxuyM1hE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Peter Harris <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Wed Jun 30 22:33:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU3yb-0007p6-Gw
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 22:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755566Ab0F3Udm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 16:33:42 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:61438 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754947Ab0F3Udl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jun 2010 16:33:41 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1OU3yV-0006AM-be; Wed, 30 Jun 2010 20:33:40 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <AANLkTilvV9Lty6jciIvASrRrzZ5rf9s2zmgulxuyM1hE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149989>

Peter Harris wrote:
> The vast majority of git devs work in an environment where compiler
> flags and linker flags aren't completely disjoint, and it's not very
> polite of us to rework their makefile to fit our view of the world.
> Especially when we already have a wrapper that fits their world to
> ours.

Yep, good point.

>> Also, are you correctly filtering *all* possible inappropriate options?
>> For example, the very next patch on my branch (not sent to list) adds
>> a -W3 option ... ;-)
> 
> Heck no. This only filters the options that are used by the git makefile.
> But adding a filter for -W* is a trivial one liner (one character-er, even).

Your patch fixes my problem, and is *much* better than my patch, so could
you send a formal patch to the list (with W added to the the regex as well
as Z)?

Thanks.

ATB,
Ramsay Jones
