From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Mon, 28 Apr 2008 20:10:12 +0200
Message-ID: <20080428181012.GB6710@steel.home>
References: <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com,
	peff@peff.net, johannes.schindelin@gmx.de, srb@cuci.nl
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 20:12:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqXpF-0005rl-Fu
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 20:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965398AbYD1SKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 14:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765526AbYD1SKR
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 14:10:17 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:51048 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965398AbYD1SKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 14:10:15 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarKZBJxGkw==
Received: from tigra.home (Faada.f.strato-dslnet.de [195.4.170.218])
	by post.webmailer.de (klopstock mo25) (RZmta 16.27)
	with ESMTP id 20662fk3SHP0CC ; Mon, 28 Apr 2008 20:10:12 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 1D0F0277BD;
	Mon, 28 Apr 2008 20:10:12 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 2086F56D28; Mon, 28 Apr 2008 20:10:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80576>

Paolo Bonzini, Mon, Apr 28, 2008 17:32:18 +0200:
> This patch parallels what a previous patch did to "git push".
> It makes "git fetch" with no repository argument similar to
> "git remote update" with no default group set.  Of course,
> "git fetch" with no arguments honors skipDefaultUpdate too.

You may consider to update "git remote add" to make all new remotes
.skipDefaultUpdate. And otherwise, I promise to hate your patch
everytime when I mindlessly type "git fetch" in, for instance, my v4l2
repo (which is a pretty collection of all kinds of remotes). All of
sudden it starts updating them and losing old references. And that
without me even touching configuration.

Please, consider making this behaviour non-default. Just because the
all current repos suddenly start updating itself where they didn't
before. Same goes for you "git push" patch.
