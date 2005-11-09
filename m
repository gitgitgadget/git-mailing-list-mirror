From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Wed, 09 Nov 2005 15:47:09 -0800
Message-ID: <7vek5p8juq.fsf@assigned-by-dhcp.cox.net>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz>
	<7vvf0r6x97.fsf@assigned-by-dhcp.cox.net>
	<20050924125001.GB25069@pasky.or.cz>
	<7virwqwd3z.fsf@assigned-by-dhcp.cox.net>
	<20051109223303.GG30496@pasky.or.cz>
	<7v3bm59zxu.fsf@assigned-by-dhcp.cox.net>
	<20051109233614.GA4051@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 00:47:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZzeu-0008Qp-UC
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbVKIXrN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 18:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbVKIXrM
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:47:12 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:33493 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751612AbVKIXrL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 18:47:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109234648.DJPI16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 18:46:48 -0500
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051109233614.GA4051@reactrix.com> (Nick Hengeveld's message of
	"Wed, 9 Nov 2005 15:36:14 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11446>

Nick Hengeveld <nickh@reactrix.com> writes:

> On Wed, Nov 09, 2005 at 03:14:21PM -0800, Junio C Hamano wrote:
>
>> > ...; is it safe to assume that the
>> > default template post-update hook shipped with GIT will be
>> > good-to-be-autoenabled on public repositories 
>> 
>> Please yell loudly when somebody posts a patch or brings up a
>> proposal to break that assumption in the future.
>
> Wouldn't this be a problem on public repositories that are hosted with
> DAV?

Not unless you arrange the DAV server to honor hooks. ;-).

IOW, yeah, there may be problems.
