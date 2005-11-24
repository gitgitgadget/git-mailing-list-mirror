From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/9] remove git wrapper dependency
Date: Thu, 24 Nov 2005 00:35:30 -0800
Message-ID: <7voe4awii5.fsf@assigned-by-dhcp.cox.net>
References: <20051112092336.GA16218@Muzzle>
	<46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com>
	<20051124074605.GA4789@mail.yhbt.net>
	<20051124074739.GB4789@mail.yhbt.net>
	<20051124074857.GC4789@mail.yhbt.net>
	<20051124075027.GD4789@mail.yhbt.net>
	<20051124075133.GE4789@mail.yhbt.net> <438577E0.30109@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 24 09:37:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfCZr-0004A5-Ru
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 09:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030624AbVKXIfc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 03:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030620AbVKXIfc
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 03:35:32 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:44263 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030624AbVKXIfb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 03:35:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051124083405.HVCZ20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 24 Nov 2005 03:34:05 -0500
To: git@vger.kernel.org
In-Reply-To: <438577E0.30109@op5.se> (Andreas Ericsson's message of "Thu, 24
	Nov 2005 09:20:48 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12695>

Andreas Ericsson <ae@op5.se> writes:

> Eric Wong wrote:
>> use git-diff-files instead of git diff-files so we don't rely on the
>> wrapper being installed (some people may have git as GNU interactive
>> tools :)
>>
>
> This one should do
> 	git --exec-path
>
> first to get the proper path to git-diff-files. Fall back to it being in 
> the path if finding out fails.

Eric is worried about the case where git on your PATH is GNU
interactive tools, so "git --exec-path" would not give you what
you want ;-).
