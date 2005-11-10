From: Junio C Hamano <junkio@cox.net>
Subject: Re: Expected Behavior?
Date: Thu, 10 Nov 2005 14:52:46 -0800
Message-ID: <7vzmocw1xd.fsf@assigned-by-dhcp.cox.net>
References: <E1EZKOB-0002j5-VY@jdl.com>
	<7vwtjjllw4.fsf@assigned-by-dhcp.cox.net>
	<20051108210332.GB23265@c165.ib.student.liu.se>
	<7v7jbig6m7.fsf@assigned-by-dhcp.cox.net>
	<20051108225320.GB4805@c165.ib.student.liu.se>
	<7vmzkenzcx.fsf@assigned-by-dhcp.cox.net>
	<20051109081906.GA4960@c165.ib.student.liu.se>
	<20051110203411.GX30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 23:53:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaLHo-0005sm-Qr
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 23:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVKJWwt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 17:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVKJWwt
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 17:52:49 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:19396 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932174AbVKJWws (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 17:52:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051110225226.WGMH16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Nov 2005 17:52:26 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051110203411.GX30496@pasky.or.cz> (Petr Baudis's message of
	"Thu, 10 Nov 2005 21:34:11 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11532>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Wed, Nov 09, 2005 at 09:19:06AM CET, I got a letter
> where Fredrik Kuivinen <freku045@student.liu.se> said that...
>> On Tue, Nov 08, 2005 at 09:50:54PM -0800, Junio C Hamano wrote:
>> > Fredrik Kuivinen <freku045@student.liu.se> writes:
>> > 
>> Oups, I haven't thought about that. I kind of like the idea that you
>> can see the branch name in the file names though. How about replacing
>> any slashes in the branch names with underscores? So the branch
>> 'foo/bar' will give rise to files with suffixes like '_foo_bar' and
>> '_foo_bar_<number>'.
>
> I like it too. :-)
>
> Now, this would look like file3~master in Cogito (or file3~~master in
> case of name conflict, etc.).

One thing I like about Cogito's is the use of tilde instead of
underscore -- much much less likely to clash with real filenames
and easiliy recognizable as throwaway copies.

One thing I _don't_ like about both is there is no way for 'git
reset --hard' to get rid of them, when the user decides to retry
from scratch after seeing a failed merge that left too many of
them.
