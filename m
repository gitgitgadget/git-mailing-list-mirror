From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: git:// protocol over SSL/TLS
Date: Fri, 27 Dec 2013 18:16:40 +0400
Message-ID: <20131227181640.314629cc762cab446ae5352e@domain007.com>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
	<20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
	<CAErtv25JGxEs3ytAB019yajQooNs4k=bzukSE9kuHWAbir9-BQ@mail.gmail.com>
	<87mwjm4c3s.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sergey Sharybin <sergey.vfx@gmail.com>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Git List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Dec 27 15:16:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwYDh-0000Ju-MA
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 15:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633Ab3L0OQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 09:16:53 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:41849 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab3L0OQx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 09:16:53 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id rBREGegB018356;
	Fri, 27 Dec 2013 18:16:41 +0400
In-Reply-To: <87mwjm4c3s.fsf@igel.home>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239733>

On Fri, 27 Dec 2013 15:12:07 +0100
Andreas Schwab <schwab@linux-m68k.org> wrote:

> > So guess we just need to recommend using https:// protocol instead
> > of git:// for our users?
> 
> Given how easy it is to verify the integrity of a git repository out
> of band there isn't really much of added security by using TLS for
> transport.

If the devs employ signed tags then yes but otherwise you'd have to
have some reference repository to compare with.  Sure they target for a
more no-brainer setup. ;-)
