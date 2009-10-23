From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: fix fetch where glob is on the top-level URL
Date: Thu, 22 Oct 2009 23:07:51 -0700
Message-ID: <20091023060751.GA14477@dcvr.yhbt.net>
References: <20091021144113.GA7440@cumin> <20091023044843.GA16169@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Brewster <adambrewster@gmail.com>,
	Daniel Cordero <theappleman@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 08:08:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1DKa-0002Ih-TY
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 08:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbZJWGHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 02:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbZJWGHt
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 02:07:49 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60237 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbZJWGHs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 02:07:48 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 24E901F9B9;
	Fri, 23 Oct 2009 06:07:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091023044843.GA16169@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131090>

Eric Wong <normalperson@yhbt.net> wrote:
> From 3abaf9fdf216fd0307bb9e9f03772bd80a64177c Mon Sep 17 00:00:00 2001
> From: Adam Brewster <adambrewster@gmail.com>
> Date: Thu, 22 Oct 2009 21:26:32 -0700
> Subject: [PATCH] git svn: fix fetch where glob is on the top-level URL

Actually, no, something is broken here it seems...  Ugh, falling asleep :x

-- 
Eric Wong
