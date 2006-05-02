From: Olaf Hering <olh@suse.de>
Subject: Re: git-bisect broken in 1.2.4
Date: Tue, 2 May 2006 09:33:04 +0200
Message-ID: <20060502073304.GA26111@suse.de>
References: <20060501181020.GA21263@suse.de> <20060502070155.GA861@informatik.uni-freiburg.de> <7vpsiwopkv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue May 02 09:33:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FapNi-0008BS-70
	for gcvg-git@gmane.org; Tue, 02 May 2006 09:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWEBHdH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 03:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWEBHdH
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 03:33:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:31176 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932372AbWEBHdG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 03:33:06 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 7F72F1D8D2;
	Tue,  2 May 2006 09:33:05 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>, pasky@suse.cz
Content-Disposition: inline
In-Reply-To: <7vpsiwopkv.fsf@assigned-by-dhcp.cox.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19403>

 On Tue, May 02, Junio C Hamano wrote:

> Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:
> 
> > Olaf Hering wrote:
> >> Did SuSE just pick up a bad version of git, 1.2.4?
> >> git-bisect doesnt work correctly in the kernel sources, .git/HEAD doesnt
> >> contain the commit id anymore, but 'ref: refs/heads/bisect'
> >> 
> >> CONFIG_LOCALVERSION_AUTO depends on the id.
> > Probably you should update to at least linux-v2.6.15-g117a93d.  The
> > script to determine the localversion[1] depends on .git/HEAD being a
> > symlink.
> >
> > Since 
> >
> > 	git-1.1.4-g2fabd21
> >
> > .git/HEAD isn't a symlink any more (per default at least).
> 
> Ouch.  Although what Uwe says is all correct, we should not say
> "don't try kernel older than 2615-117a".  That makes bisect
> rather useless.
> 
> > You can rebuild git with USE_SYMLINK_HEAD if you really want the old
> > behaviour.
> 
> That probably is a sane thing to do.

Ok, thanks for the patch.
Petr, can you update our git package in time?
