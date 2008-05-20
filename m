From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git GUI vs interactive post-commit hooks
Date: Wed, 21 May 2008 00:31:58 +0200
Message-ID: <20080520223158.GB13123@steel.home>
References: <c6c947f60805190348g3395f8degae81963b402856b6@mail.gmail.com> <20080519131942.GA5526@atjola.homenet>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Gladysh <agladysh@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bj?rn Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 21 00:32:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyaO4-0000tN-Tt
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 00:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763773AbYETWcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 18:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758966AbYETWcB
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 18:32:01 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:40280 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763773AbYETWcA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 18:32:00 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarKZB1HUNA==
Received: from tigra.home (Faa97.f.strato-dslnet.de [195.4.170.151])
	by post.webmailer.de (mrclete mo17) (RZmta 16.37)
	with ESMTP id w06366k4KIo6ME ; Wed, 21 May 2008 00:31:58 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 296B5277BD;
	Wed, 21 May 2008 00:31:58 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 671CC56D28; Wed, 21 May 2008 00:31:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080519131942.GA5526@atjola.homenet>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82514>

Bj?rn Steinbrink, Mon, May 19, 2008 15:19:42 +0200:
> On 2008.05.19 14:48:14 +0400, Alexander Gladysh wrote:
> > 
> > Any advice? I do want to input password for my key each time I use it.
> 
> For a graphical tool, you might want to use something like
> gtk-led-askpass, which shows a window with a password prompt. SSH will
> make use of it if SSH_ASKPASS contains its path _and_ ssh is not started
> from a terminal. Unfortunately, the latter is probably not true for git
> gui most of the time.

Redirect stdin from /dev/null
