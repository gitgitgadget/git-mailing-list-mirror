From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] checkout -d: explicitly detach HEAD even when switching to the tip of a branch
Date: Thu, 29 Mar 2007 19:10:24 +0200
Message-ID: <20070329171024.GA2809@steel.home>
References: <7vr6r879zp.fsf@assigned-by-dhcp.cox.net> <200703291044.l2TAig5M021533@localhost.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Thu Mar 29 19:10:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWy8x-0001pP-S1
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 19:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbXC2RK2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 13:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbXC2RK2
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 13:10:28 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:29871 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030456AbXC2RK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 13:10:27 -0400
Received: from tigra.home (Fcb18.f.strato-dslnet.de [195.4.203.24])
	by post.webmailer.de (klopstock mo48) (RZmta 5.5)
	with ESMTP id I03fa1j2TFqf2P ; Thu, 29 Mar 2007 19:10:25 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D14D6277B6;
	Thu, 29 Mar 2007 19:10:24 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 8D25CD24E; Thu, 29 Mar 2007 19:10:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200703291044.l2TAig5M021533@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg7nw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43459>

Xavier Maillard, Thu, Mar 29, 2007 12:44:42 +0200:
>    This allows you to detach your HEAD and place it at such a
> 
>        $ git checkout -d master
> 
> Hum, excuse my ignorance, but can you explain what exactly could
> be a use case of this ?

A throw-away or an experimental work. A commit importer which cares
about the branch it commits on: to update the branch reference only
when it has reached a stable state.
