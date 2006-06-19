From: Matthias Hopf <mhopf@suse.de>
Subject: Re: git-rebase nukes multiline comments
Date: Mon, 19 Jun 2006 11:53:00 +0200
Message-ID: <20060619095300.GB15209@suse.de>
References: <20060616171251.GA29820@suse.de> <4492E8F9.4000106@shlrm.org> <7v7j3gdc7t.fsf@assigned-by-dhcp.cox.net> <1150494975.DBA8A55@be12.dngr.org> <7vwtbgbsax.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jun 19 11:53:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsGRS-0000g9-Mm
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 11:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWFSJxD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 05:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWFSJxD
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 05:53:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:42707 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932316AbWFSJxC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 05:53:02 -0400
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id C07411D786
	for <git@vger.kernel.org>; Mon, 19 Jun 2006 11:53:00 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vwtbgbsax.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22125>

On Jun 16, 06 16:21:26 -0700, Junio C Hamano wrote:
> Having said that, I would say it is a bug.  We should be able to
> rebase, cherry-pick and/or rebase a patch with an arbitrary
> binary garbage in the commit log message (I think the latter two
> command do).  But because of the reason (2) above, it is very
> low on my priority to change it.

I understand. Many thanks for your explainations. I think this intended
log format should be documented somewhere, that would help a lot. I
don't think that many developers using git in CVS style know about this
convention.

Said that, I assume git nuking the multiline comment was a bug in 1.3.1
that has been (somewhat ;) solved.

Matthias

-- 
Matthias Hopf <mhopf@suse.de>       __        __   __
Maxfeldstr. 5 / 90409 Nuernberg    (_   | |  (_   |__         mat@mshopf.de
Phone +49-911-74053-715            __)  |_|  __)  |__  labs   www.mshopf.de
