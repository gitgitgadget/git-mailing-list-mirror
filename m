From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] Make git-apply understand "\ No newline at end of file" in non-english locales
Date: Mon, 5 Sep 2005 07:25:49 +0200
Message-ID: <20050905052549.GA1875@c165.ib.student.liu.se>
References: <20050904172901.GA20574@c165.ib.student.liu.se> <20050904184625.GB23525@c165.ib.student.liu.se> <7vd5noeiub.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 07:27:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EC9Ug-0006U3-Qf
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 07:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVIEFZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 01:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVIEFZ4
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 01:25:56 -0400
Received: from [85.8.31.11] ([85.8.31.11]:53967 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932206AbVIEFZ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 01:25:56 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 6A767411A; Mon,  5 Sep 2005 07:30:24 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EC9UL-0000pI-00; Mon, 05 Sep 2005 07:25:49 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5noeiub.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8082>

On Sun, Sep 04, 2005 at 12:25:16PM -0700, Junio C Hamano wrote:
> Fredrik Kuivinen <freku045@student.liu.se> writes:
> 
> > The message "\ No newline at end of file" which sometimes is produced
> > by diff(1) is locale dependent. We can't assume more than that it
> > begins with "\ ".
> >
> > Signed-off-by: Fredrik Kuivinen <freku@ida.liu.se>
> > ---
> >
> > The previous patch wasn't doing the right thing. Hopefully I have
> > managed to get it right this time.
> 
> I noticed that you left 12 in the previous patch, and thought it
> was a sane safety measure to make sure that the incomplete line
> marker is of reasonably length, not just any line that starts
> with '\ ' (i.e. "\ foobar\n", which is a tad short).
> 

Maybe the first patch wasn't that bad after all :)

In the current diffutils package the Swedish translation is one of the
shortest ones, so 12 is ok for now at least.

- Fredrik
