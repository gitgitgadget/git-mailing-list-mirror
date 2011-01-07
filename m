From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC/PATCH] t9157-*.sh: Add an svn version check
Date: Fri, 7 Jan 2011 10:39:31 -0800
Message-ID: <20110107183931.GA5560@dcvr.yhbt.net>
References: <4D260A03.90903@ramsay1.demon.co.uk> <20110107173114.GA31376@dcvr.yhbt.net> <AANLkTi=VpHtQ+x5hyfCei-=X=ry4X=+TSGg7EKa7zs4j@mail.gmail.com> <20110107180220.GA20031@dcvr.yhbt.net> <20110107181946.GB28980@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>,
	Steven Walter <stevenrwalter@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 19:39:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbHDu-0004tq-3h
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 19:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab1AGSjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 13:39:33 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48406 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754953Ab1AGSjc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 13:39:32 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D5F71F68D;
	Fri,  7 Jan 2011 18:39:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20110107181946.GB28980@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164735>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Eric Wong wrote:
> 
> > Wait, looking through my backlog, this could fix the problem
> > Ramsay was having but was lost in the shuffle (my fault) :x
> > 
> > Ramsay: does this fix it?
> > 
> > From 9a4f35d6ff9a66b7b5e57c7124a7cd6df0adad7b Mon Sep 17 00:00:00 2001
> > From: Steven Walter <stevenrwalter@gmail.com>
> > Date: Fri, 22 Oct 2010 21:55:58 -0400
> > Subject: [PATCH] t9157-git-svn-fetch-merge.sh: remove dependency on subversion 1.5
> 
> Context, for reference:
> 
>   http://thread.gmane.org/gmane.linux.kernel/1052314/focus=161717

Ah thanks, I completely forgot about that, too :x  I'll take Ramsay's
patch.

-- 
Eric Wong
