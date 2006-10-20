From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-svnimport.perl: copying directory from original SVN place
Date: Thu, 19 Oct 2006 17:23:45 -0700
Message-ID: <7vmz7rrg1a.fsf@assigned-by-dhcp.cox.net>
References: <20061008213118.GA1367@sashak.voltaire.com>
	<20061020002219.GF24676@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Fri Oct 20 02:23:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaiAw-0000WX-8i
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 02:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946744AbWJTAXr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 20:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946753AbWJTAXr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 20:23:47 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:12730 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1946744AbWJTAXr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 20:23:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061020002346.GJWQ16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Thu, 19 Oct 2006 20:23:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cQPp1V00a1kojtg0000000
	Thu, 19 Oct 2006 20:23:50 -0400
To: Sasha Khapyorsky <sashak@voltaire.com>
In-Reply-To: <20061020002219.GF24676@sashak.voltaire.com> (Sasha Khapyorsky's
	message of "Fri, 20 Oct 2006 02:22:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29394>

Sasha Khapyorsky <sashak@voltaire.com> writes:

> Hi guys,
>
> On 23:31 Sun 08 Oct     , Sasha Khapyorsky wrote:
>> 
>> When copying whole directory, if source directory is not in already
>> imported tree, try to get it from original SVN location. This happens
>> when source directory is not matched by provided 'trunk' and/or
>> 'tags/branches' templates or when it is not part of specified SVN
>> sub-project.
>
> Any news with it?

I've pushed it out in "master" after 1.4.3, to see if anybody
cares about git-svnimport would scream.  If we do not hear from
anybody about breakage that would be a good sign, otherwise we
would get a fix so that is good as well ;-).
