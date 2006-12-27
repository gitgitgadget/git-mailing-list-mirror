From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] An early draft of v1.5.0 release notes
Date: Wed, 27 Dec 2006 02:50:49 -0800
Message-ID: <7vvejx7gty.fsf@assigned-by-dhcp.cox.net>
References: <7vvejx948y.fsf@assigned-by-dhcp.cox.net>
	<emtgps$f1q$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jnareb@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 27 11:51:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzWNC-0000mf-JW
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 11:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbWL0Kuw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 05:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754453AbWL0Kuv
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 05:50:51 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:63815 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094AbWL0Kuv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 05:50:51 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061227105050.TIEQ20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Dec 2006 05:50:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3mr31W00h1kojtg0000000; Wed, 27 Dec 2006 05:51:04 -0500
To: git@vger.kernel.org
In-Reply-To: <emtgps$f1q$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	27 Dec 2006 11:12:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35461>

Jakub Narebski <jnareb@gmail.com> writes:

> Just a few comments:
>
>>  - git-add without any argument does not add everything
>>    anymore.  Say "git add ." if you want to.
>
> Perhaps information that git-add can be used to add ignored files
> with -f option should be added? Or is it not important enough?

Thanks.  Will change the above bullet to this:

 - git-add without any argument does not add everything
   anymore.  Use 'git-add .' instead.  Also you can add
   otherwise ignored files with an -f option.
