From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: git:// protocol over SSL/TLS
Date: Fri, 27 Dec 2013 18:56:57 +0400
Message-ID: <20131227185657.0dee9b2062fe6c632cd7d3a4@domain007.com>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
	<20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
	<CAErtv25JGxEs3ytAB019yajQooNs4k=bzukSE9kuHWAbir9-BQ@mail.gmail.com>
	<87mwjm4c3s.fsf@igel.home>
	<vpqwqiqpe80.fsf@anie.imag.fr>
	<CAErtv25URyB3znN1CMd87374NUjaSFvg=cee_-c=s8bB2j052A@mail.gmail.com>
	<20131227183958.b8e55d7e3c8c38b46137ea9c@domain007.com>
	<CAErtv25uWbsH15yohh+6Jun3eD51dZzvj7udoBf14_EwXzSUPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Git List <git@vger.kernel.org>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 27 15:57:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwYqh-0006kd-Q2
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 15:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691Ab3L0O5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 09:57:11 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:42046 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565Ab3L0O5L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 09:57:11 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id rBREuvMB020972;
	Fri, 27 Dec 2013 18:56:58 +0400
In-Reply-To: <CAErtv25uWbsH15yohh+6Jun3eD51dZzvj7udoBf14_EwXzSUPg@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239741>

On Fri, 27 Dec 2013 20:47:54 +0600
Sergey Sharybin <sergey.vfx@gmail.com> wrote:

[...]
> > As discussed in an earlier thread here, a good indication of the
> > dumb version of the protocol being in use is no display of the
> > fetching progress on the client while doing `git clone` because this
> > information (like "compressing objects ..." etc) is sent by the
> > server-side Git process which is only there if HTTP[S] "was smart".
> > Otherwise the client just GETs packs of objects, traverses them,
> > GETs more and so on, so batches of HTTP GET requests correlating to
> > clone sessions in the web server logs should also be indicative of
> > the problem.
> 
> Just to verify, if i see messages like "Receiving objects:   1%
> (7289/705777), 1.72 MiB | 340.00 KiB/s" it means server is "smart" ?

I would say yes, because your Git knows the precise number of objects to
receive.  Unfortunately, I won't swear by this as this was a long time
ago I have seen cloning using the dumb protocol.

By the way, here [1] is that discussion.

1. http://thread.gmane.org/gmane.comp.version-control.git/238933/focus=238946
