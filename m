From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Replace "echo -n" with printf in shell scripts.
Date: Wed, 17 Jan 2007 09:33:43 -0800
Message-ID: <7vk5zlsglk.fsf@assigned-by-dhcp.cox.net>
References: <17437.1168911089@lotus.CS.Berkeley.EDU>
	<7v1wlv1yeh.fsf@assigned-by-dhcp.cox.net>
	<200701171629.l0HGTCE3019292@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 18:33:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7EfX-0003ul-Ax
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 18:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbXAQRdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 12:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbXAQRdr
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 12:33:47 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:56710 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932590AbXAQRdq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 12:33:46 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070117173345.XNDH20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Wed, 17 Jan 2007 12:33:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CHa11W00F1kojtg0000000; Wed, 17 Jan 2007 12:34:01 -0500
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37019>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Jason Riedy <ejr@EECS.Berkeley.EDU> writes:
>> > Not all echos know -n.  This was causing a test failure in
>> > t5401-update-hooks.sh, but not t3800-mktag.sh for some reason.
>> 
>> We have done this already so it might be too late to raise this
>> question, but does everybody have printf?
>
> Here (Fedora rawhide) /usr/bin/printf is part of coreutils.

I am reasonably sure people on Linux land would be fine
regardless of distros, but thanks anyway.

The problematic are less common ones, ranging from (not so less
common) OSX, Solaris to (much less common) AIX that some people
seem to run git on (or at least compile git for).
