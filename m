From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] gitweb: Add support for per project git URLs
Date: Wed, 16 Aug 2006 13:40:33 -0700
Message-ID: <7vveos2z3y.fsf@assigned-by-dhcp.cox.net>
References: <200608152003.05693.jnareb@gmail.com>
	<200608152303.17994.jnareb@gmail.com>
	<200608161450.35118.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 22:41:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDSBq-0002fK-S9
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 22:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWHPUkf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 16:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWHPUkf
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 16:40:35 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:56530 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751168AbWHPUke (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 16:40:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060816204034.WYIB6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Aug 2006 16:40:34 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608161450.35118.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 16 Aug 2006 14:50:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25526>

Jakub Narebski <jnareb@gmail.com> writes:

> It is now possible for project to have individual clone/fetch URLs.
> They are provided in new file 'cloneurl' added below project's
> $GIT_DIR directory.
>
> If there is no cloneurl file, concatenation of git base URLs with
> project name is used.
>
> This is merge of Jakub Narebski and David Rientjes
>   gitweb: Show project's git URL on summary page
> with Aneesh Kumar
>   gitweb: Add support for cloneurl.
>   gitweb: Support multiple clone urls
> patches.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

I'll take this for now, but we might want to consider moving
'description' and 'cloneurl' information to the config file to
prevent cluttering.

        gitweb.description
        gitweb.giturl

The URL is not for cloning only, but also for fetch/pull, right?
