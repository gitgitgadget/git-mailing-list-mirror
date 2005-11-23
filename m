From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-mv is not able to handle big directories
Date: Wed, 23 Nov 2005 10:53:15 -0800
Message-ID: <7vpsor5h7o.fsf@assigned-by-dhcp.cox.net>
References: <200511231141.57683.lan@ac-sw.com>
	<7voe4b7uw7.fsf@assigned-by-dhcp.cox.net>
	<7vk6ez7u1y.fsf@assigned-by-dhcp.cox.net>
	<867jazre78.fsf@blue.stonehenge.com>
	<7vu0e369p4.fsf@assigned-by-dhcp.cox.net>
	<20051123135604.GB16995@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 19:55:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EezkO-0000LH-2o
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 19:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVKWSxT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 13:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVKWSxT
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 13:53:19 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:31136 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932169AbVKWSxS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 13:53:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051123185243.SMNG20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Nov 2005 13:52:43 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20051123135604.GB16995@mythryan2.michonline.com> (Ryan
	Anderson's message of "Wed, 23 Nov 2005 08:56:04 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12642>

Ryan Anderson <ryan@michonline.com> writes:

> On Wed, Nov 23, 2005 at 12:37:59AM -0800, Junio C Hamano wrote:
>> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>> 
>> >>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
>> >
>> > Junio>             open my $oh, qw(|- git-update-index -z --stdin)
>> >
> ...
> No, you're not using the list form for pipes.  I use that in
> git-graft-ripple:
>
> 	open(P,"-|","git-rev-list","--parents","--merge-order",$range)

Oh, I didn't?
