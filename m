From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-daemon virtual hosting implementation.
Date: Thu, 24 Aug 2006 13:35:41 -0700
Message-ID: <7vejv598iq.fsf@assigned-by-dhcp.cox.net>
References: <11563591572194-git-send-email-madcoder@debian.org>
	<7vmz9vgqlm.fsf@assigned-by-dhcp.cox.net>
	<200608232256.10108.madcoder@debian.org>
	<1156450516.10054.276.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 22:35:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGLvS-0002b8-OL
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 22:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbWHXUfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 16:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWHXUfi
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 16:35:38 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:29642 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S965073AbWHXUfi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 16:35:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060824203537.QIVH27846.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 Aug 2006 16:35:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id Dwbc1V00h4Noztg0000000
	Thu, 24 Aug 2006 16:35:36 -0400
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1156450516.10054.276.camel@cashmere.sps.mot.com> (Jon Loeliger's
	message of "Thu, 24 Aug 2006 15:15:16 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25976>

Jon Loeliger <jdl@freescale.com> writes:

> On Wed, 2006-08-23 at 15:56, Pierre Habouzit wrote:
>
>> Another option would be not to support virtual hosts, but instead 
>> superseed the --base-path and --user-path with some --base-path-fmt 
>> and --user-path-fmt where the user can specify how to build the path 
>> with simple sprintf-like formats. One could e.g. support:
>>  * %% obviously ;
>>  * %h that will be replaced with the hostname
>>  * %u (only for --user-path-fmt)
>>  * %p (asked path)
>>  * ...
>
> And this is exactly what I have implemented and
> running on my system today!

Where is the patch ;-)?
