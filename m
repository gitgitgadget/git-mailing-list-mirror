From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: fix warnings in PATH_INFO code and add export_ok/strict_export
Date: Sun, 17 Sep 2006 16:10:52 -0700
Message-ID: <7vzmcy143n.fsf@assigned-by-dhcp.cox.net>
References: <20060916192750.GA27008@moooo.ath.cx>
	<20060916223027.GA32679@moooo.ath.cx>
	<20060916223101.GB32679@moooo.ath.cx>
	<7v64fm7u2q.fsf@assigned-by-dhcp.cox.net>
	<20060917090710.GA18153@moooo.ath.cx>
	<7vodte4w9w.fsf@assigned-by-dhcp.cox.net>
	<20060917132948.GA976@moooo.ath.cx>
	<7v4pv62lni.fsf@assigned-by-dhcp.cox.net> <eekj5b$rlc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jnareb@gmail.com
X-From: git-owner@vger.kernel.org Mon Sep 18 01:11:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP5mr-0003xu-Ol
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 01:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWIQXKy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 19:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbWIQXKy
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 19:10:54 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:63361 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965149AbWIQXKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 19:10:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917231053.COKQ2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 19:10:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PbAg1V00C1kojtg0000000
	Sun, 17 Sep 2006 19:10:40 -0400
To: git@vger.kernel.org
In-Reply-To: <eekj5b$rlc$1@sea.gmane.org> (Jakub Narebski's message of "Mon,
	18 Sep 2006 00:45:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27212>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Matthias Lederhofer <matled@gmx.net> writes:
>> 
>>> This patch replaces the other two warning fixes by Jakub and me.  I've
>>> put the whole thing in a sub-routine to keep the indentation level
>>> low.
>> 
>> Looks much cleaner with this extra sub.
>> 
>> This does not seem have the "colon as a cue that the URL is also
>> talking about a branch", Jakub's summary of the discussion
>> between you two on #git channel.  I think that proposal makes
>> sense as well.
>
> Well, that is because this patch _predates_ the discussion 
> (and proposal/conclusions). 

Yup, I know, I was not complaining.

I was saying that I do not oppose to a follow-up patch to add
that "colon" stuff.
